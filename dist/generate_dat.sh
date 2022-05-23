#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Replace <br><br> with </p><p>
echo "Replace '<br>'"
grep -Eolir --include="*.opf" "&lt;br&gt;&lt;br&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/\&lt;br\&gt;\&lt;br\&gt;/\&lt;\/p\&gt;\&lt;p\&gt;/g'
# Replace <br> with </p><p>
grep -Eolir --include="*.opf" "&lt;br&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/\&lt;br\&gt;/\&lt;\/p\&gt;\&lt;p\&gt;/g'
# Remove extra space before closing </p> tags
echo "Remove ' </p>'"
grep -Eolir --include="*.opf" " &lt;/p&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/ \&lt;\/p\&gt;/\&lt;\/p\&gt;/g'
# Remove id="book-description-full" from <p id="book-description-full">
echo "Remove 'id=\"book-description-full\"'"
grep -Eolir --include="*.opf" " id=\"book-description-full\"" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/ id=\"book-description-full\"//g'


# Check for <p><strong>.*?</strong></p> to replace them manually as needed with <p style="font-weight: 600">
echo "-[ Replace <p><strong> with <p style=\"font-weight: 600\"> ]-"
grep -Eolir --include="*.opf" "&lt;p&gt;&lt;strong&gt;.*?&lt;/strong&gt;&lt;/p&gt;" "$SCRIPT_DIR/../metadata"
# Check for explicit color changes to remove them manually
echo "-[ Remove text color overrides ]-"
grep -Eolir --include="*.opf" "style=\"color:" "$SCRIPT_DIR/../metadata"


echo "Continue (y/N)? "
read CONT
if [ "$CONT" = 'Y' ] || [ "$CONT" = 'y' ]; then 
  calibredb --library-path "$SCRIPT_DIR/../metadata" restore_database --really-do-it
  "$SCRIPT_DIR/sabretools/SabreTools" \
    --d2d --include-sha1 --no-automatic-date --superdat \
    --output-dir="$SCRIPT_DIR" --filename="OTLN_metadata" \
    --name="OTLN Metadata" \
    --description="OTLN and Metadata for light novels from #-F" \
    --version="18.4" \
    --author="jurassicplayer" \
    --filter="!item.name:cover.jpg" \
    --filter="!item.name:metadata.db" --filter="!item.name:metadata_db_prefs_backup.json" --filter="!item.name:metadata_pre_restore.db" \
    "$SCRIPT_DIR/../metadata"
fi