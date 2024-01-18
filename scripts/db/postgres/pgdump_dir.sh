#!/usr/bin/env bash
set -ex

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')

STAGE="${STAGE:?Variable not set or empty}"

DB_USER="${DB_USER:?Variable not set or empty}"
DB_PASS="${DB_PASS:?Variable not set or empty}"
DB_HOST="${DB_HOST:?Variable not set or empty}"
DB_PORT="${DB_PORT:?Variable not set or empty}"
DB_NAME="${DB_NAME:?Variable not set or empty}"
S3_BUCKET="${S3_BUCKET:-bckupsroa-new/tests}"

# Export PGPASSWORD so it can be used by psql
export PGPASSWORD=$DB_PASS

# Get current date in yyyy-MM-DD format
YYYY_MM_DD=$(date '+%Y-%m-%d')

# Create a subdirectory for the stage with the current date
DB_DUMP_PATH="dumps/$STAGE/$YYYY_MM_DD"
rm -rf "$DB_DUMP_PATH"
mkdir -p "$DB_DUMP_PATH"

# Compress the directory of dump files and stream it to S3 using xz compression
echo "$DB_DUMP_PATH"/"$DB_NAME"

# Dump the database into a directory of dump files
pg_dump -v -Z9 -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -Fd -f "$DB_DUMP_PATH/$DB_NAME"
tar -cJf "$DB_NAME.tar.xz" -C "$DB_DUMP_PATH" "$DB_NAME"
echo "File size: $(du -sh "$DB_NAME.tar.xz" | cut -f1)"
aws s3 cp "$DB_NAME.tar.xz" "s3://$S3_BUCKET/$DB_DUMP_PATH/$DB_NAME.tar.xz"
rm -r "$DB_DUMP_PATH"
rm "$DB_NAME.tar.xz"

# Get the end time
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Append the start and end times to a TSV file
echo -e "$0\t$START_TIME\t$END_TIME" >> runtimes_dump-dir.tsv


START_TIME_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$START_TIME" +%s)
END_TIME_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$END_TIME" +%s)
ELAPSED_TIME=$((END_TIME_EPOCH - START_TIME_EPOCH))

ELAPSED_HOURS=$((ELAPSED_TIME / 3600))
ELAPSED_MINUTES=$(( (ELAPSED_TIME / 60) % 60))
ELAPSED_SECONDS=$((ELAPSED_TIME % 60))

echo "Elapsed time: $ELAPSED_HOURS hours, $ELAPSED_MINUTES minutes, $ELAPSED_SECONDS seconds"
#awk -F'\t' '{
#  start = mktime(gensub(/[-:]/, " ", "g", $2));
#  end = mktime(gensub(/[-:]/, " ", "g", $3));
#  sum += end - start;
#  count++
#} END {
#  print "Average runtime: " sum/count " seconds"
#}' runtimes_dump-dir.tsv
