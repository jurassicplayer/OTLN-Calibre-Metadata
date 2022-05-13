#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


# Replace <br><br> with </p><p>
echo "Replace '<br>'"
egrep -lir --include="*.opf" "&lt;br&gt;&lt;br&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/\&lt;br\&gt;\&lt;br\&gt;/\&lt;\/p\&gt;\&lt;p\&gt;/g'
# Replace <br> with </p><p>
egrep -lir --include="*.opf" "&lt;br&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/\&lt;br\&gt;/\&lt;\/p\&gt;\&lt;p\&gt;/g'
# Remove extra space before closing </p> tags
echo "Remove ' </p>'"
egrep -lir --include="*.opf" " &lt;/p&gt;" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/ \&lt;\/p\&gt;/\&lt;\/p\&gt;/g'
# Remove id="book-description-full" from <p id="book-description-full">
echo "Remove 'id=\"book-description-full\"'"
egrep -lir --include="*.opf" " id=\"book-description-full\"" "$SCRIPT_DIR/../metadata" | xargs -d '\n' sed -i 's/ id=\"book-description-full\"//g'


# Check for <p><strong>.*?</strong></p> to replace them manually as needed with <p style="font-weight: 600">
echo "-[ Replace <p><strong> with <p style=\"font-weight: 600\"> ]-"
egrep -lir --include="*.opf" "&lt;p&gt;&lt;strong&gt;.*?&lt;/strong&gt;&lt;/p&gt;" "$SCRIPT_DIR/../metadata"
# Check for explicit color changes to remove them manually
echo "-[ Remove text color overrides ]-"
egrep -lir --include="*.opf" "style=\"color:" "$SCRIPT_DIR/../metadata"


calibredb restore_database --really-do-it