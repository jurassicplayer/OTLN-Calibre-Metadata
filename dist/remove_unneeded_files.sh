#!/bin/bash

#sed -i '/cover.jpg/d' 'OTLN.dat'
sed '/<machine name="Default">/{:a;N;/<\/machine>/!ba};/<description>Default/d' 'OTLN.dat' > 'OTLN_metadata.dat'
rm 'OTLN.dat'

# Copy covers from my library to a temporary location
rsync -avm --include='*.jpg' -f 'hide,! */' "../Calibre Library/" "./covers"
# Archive the covers
7z a covers.7z ./covers/*