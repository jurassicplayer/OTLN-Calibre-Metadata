#!/bin/bash
# ---------------------------------------------------------------------------------------------
WARNING_TEXT="WARNING: This installer assumes that the target calibre library is ONLY for OTLN.\nDo NOT point this installer at a Calibre Library with other ebooks included.\nIf you fail to heed this warning, this script is liable to fail."

# ---------------------------------------------------------------------------------------------
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SABRETOOLS_DIR="$SCRIPT_DIR/dist/sabretools"
METADATA_DIR="$SCRIPT_DIR/metadata"
# Check for configuration
if [ -f "$SCRIPT_DIR/dist/config.sh" ]; then
  . "$SCRIPT_DIR/dist/config.sh"
  LIBRARY_DIR_OLD="$LIBRARY_DIR"
  OTLN_DIR_OLD="$OTLN_DIR"
fi


# Print out "One-Time Warning" in as obtuse of a way possible
if [ ! -f "$SCRIPT_DIR/dist/config.sh" ]; then
  if command -v kdialog &> /dev/null; then
    kdialog --title 'WARNING' --error "$WARNING_TEXT"
  elif command -v yad &> /dev/null; then
    yad --title='WARNING' --button=OK:0 --text="$WARNING_TEXT"
  elif command -v zenity &> /dev/null; then
    zenity --title='WARNING' --warning --text "$WARNING_TEXT"
  elif command -v Xdialog &> /dev/null; then
    Xdialog --title 'WARNING' --infobox "$WARNING_TEXT" 10 100 40000
  elif command -v dialog &> /dev/null; then
    dialog --title 'WARNING' --infobox "$WARNING_TEXT" 10 100 40000
  else
    echo "WARNING: This installer assumes that the target calibre library is ONLY for OTLN."
    echo "Do NOT point this installer at a Calibre Library with other ebooks included."
    echo "If you fail to heed this warning, this script is liable to fail."
    echo ""
    echo "Press any key to continue"
    read
  fi
fi


RUNCMD=""
# # Check for mono ( can run netcoreapp3.1 sabretools )
# mono and SabreTools doesn't work, breaks
# if command -v mono &> /dev/null; then RUNCMD="mono $SABRETOOLS_DIR/SabreTools.dll"; fi
# Check for dotnet ( can run netcoreapp3.1 OR net5.0 depending on frameworks installed )
if command -v dotnet &> /dev/null; then
  # To make instructions simple, just account for netcoreapp3.1
  if dotnet --list-sdks | grep "3.1" &> /dev/null; then RUNCMD="dotnet $SABRETOOLS_DIR/SabreTools.dll"; fi
fi
# Check for pre-compiled binary
if [ -f "$SABRETOOLS_DIR/SabreTools" ]; then RUNCMD="$SABRETOOLS_DIR/SabreTools"; fi

if [ -z "$RUNCMD" ]; then
  echo "Couldn't find method to run sabretools, please install any of the following:"
  echo "    1) dotnet-runtime and framework for netcoreapp3.1"
  echo "    2) pre-built sabretools in the dist/sabretools folder"
  exit 1
fi


# Check for sabretools folder
if [ ! -d "$SABRETOOLS_DIR" ]; then
  echo "Downloading latest release of SabreTools netcoreapp3.1..."
  LATEST_SABRETOOLS_URL=$(curl -L -s https://api.github.com/repos/SabreTools/SabreTools/releases/latest | grep -o -E "https://(.*)SabreTools.v(.*)_netcoreapp3.1.zip")
  curl -Ls -o "$SCRIPT_DIR/dist/sabretools.zip" $LATEST_SABRETOOLS_URL
  unzip "$SCRIPT_DIR/dist/sabretools.zip" -d "$SABRETOOLS_DIR"
  rm "$SCRIPT_DIR/dist/sabretools.zip"
fi


while [ ! -d "$LIBRARY_DIR" ]; do
  # Check if calibre library path is defined
  if command -v kdialog &> /dev/null; then
    LIBRARY_DIR="$(kdialog --title 'Select library directory' --getexistingdirectory ./)"
  elif command -v yad &> /dev/null; then
    LIBRARY_DIR="$(yad --title='Select library directory' --file --directory ./)"
  elif command -v zenity &> /dev/null; then
    LIBRARY_DIR="$(zenity --title='Select library directory' --file-selection --directory)"
  elif command -v Xdialog &> /dev/null; then
    LIBRARY_DIR="$(Xdialog --title 'Select library directory' --dselect ./ 40 100)"
  elif command -v dialog &> /dev/null; then
    LIBRARY_DIR="$(dialog --title 'Select library directory' --dselect ./ 40 100)"
  else
    echo "Library directory (absolute path)? "
    read LIBRARY_DIR
  fi
  # Exit script if no path selected
  if [ -z "$LIBRARY_DIR" ]; then exit 1; fi
done


# Check if OTLN path is valid
while [ ! -d "$OTLN_DIR" ]; do
  if command -v kdialog &> /dev/null; then
    OTLN_DIR="$(kdialog --title 'Select OTLN directory' --getexistingdirectory ./)"
  elif command -v yad &> /dev/null; then
    OTLN_DIR="$(yad --title='Select OTLN directory' --file --directory ./)"
  elif command -v zenity &> /dev/null; then
    OTLN_DIR="$(zenity --title='Select OTLN directory' --file-selection --directory)"
  elif command -v Xdialog &> /dev/null; then
    OTLN_DIR="$(Xdialog --title 'Select OTLN directory' --dselect ./ 40 100)"
  elif command -v dialog &> /dev/null; then
    OTLN_DIR="$(dialog --title 'Select OTLN directory' --dselect ./ 40 100)"
  else
    echo "OTLN directory (absolute path)? "
    read OTLN_DIR
  fi
  # Exit script if no path selected
  if [ -z "$OTLN_DIR" ]; then exit 1; fi
done


# Create or Update configuration if different
if [ -f "$SCRIPT_DIR/dist/config.sh" ]; then
  if [ ! "$LIBRARY_DIR" = "$LIBRARY_DIR_OLD" ]; then sed -i "s|LIBRARY_DIR=.*|LIBRARY_DIR=\"$LIBRARY_DIR\"|" "$SCRIPT_DIR/dist/config.sh"; fi
  if [ ! "$OTLN_DIR" = "$OTLN_DIR_OLD" ]; then sed -i "s|OTLN_DIR=.*|OTLN_DIR=\"$OTLN_DIR\"|" "$SCRIPT_DIR/dist/config.sh"; fi
else
  echo "#!/bin/bash" > "$SCRIPT_DIR/dist/config.sh"
  echo "LIBRARY_DIR=\"$LIBRARY_DIR\"" >> "$SCRIPT_DIR/dist/config.sh"
  echo "OTLN_DIR=\"$OTLN_DIR\"" >> "$SCRIPT_DIR/dist/config.sh"
fi


# Run sabretools to sync library with metadata.xml
echo "Running command: $RUNCMD --sort --dat=\"$SCRIPT_DIR/dist/OTLN_metadata.xml\" --output-dir=\"$LIBRARY_DIR\" \"$METADATA_DIR\" \"$OTLN_DIR\""
echo -n "Continue (y/N)? "
read CONT
if [ ! "$CONT" = 'Y' ] && [ ! "$CONT" = 'y' ]; then exit 0; fi
$RUNCMD --sort --dat="$SCRIPT_DIR/dist/OTLN_metadata.xml" --output-dir="$LIBRARY_DIR" "$METADATA_DIR" "$OTLN_DIR"


# Check if there are potential conflicting ebooks due to author/title changes
if [ ! "$(comm -23 <(find "$LIBRARY_DIR" -type d -links 2 | sort) <(grep -Po "<machine name=\"\K(.*)(?=\")" "$SCRIPT_DIR/dist/OTLN_metadata.xml" | sed "s/\&amp;/\&/g" | sed "s|^|$LIBRARY_DIR/|g" | sort))" = "" ]; then
  echo "The following is a list of ebook filepaths that are present in your library but not in the metadata.dat file."
  echo "This can be due to author/title fixes or additional ebooks added to your library and may cause conflicts when"
  echo "restoring the calibre database from the metadata.opf files."
  echo "Please remove all offending filepaths from the library before continuing."
  echo "Filepaths:"
  comm -23 <(find "$LIBRARY_DIR" -type d -links 2 | sort) <(grep -Po "<machine name=\"\K(.*)(?=\")" "$SCRIPT_DIR/dist/OTLN_metadata.xml" | sed "s/\&amp;/\&/g" | sed "s|^|$LIBRARY_DIR/|g" | sort)
  echo -n "Continue (y/N)? "
  read CONT
  if [ ! "$CONT" = 'Y' ] && [ ! "$CONT" = 'y' ]; then exit 0; fi
fi


# Restore calibre database using metadata.opf
calibredb --library-path "$LIBRARY_DIR" restore_database --really-do-it