#!/bin/bash

sed -i '/cover.jpg/d' 'OTLN.dat'
sed '/<machine name="Calibre Library">/{:a;N;/<\/machine>/!ba};/<description>Calibre Library/d' 'OTLN.dat' > 'OTLN_metadata.dat'
rm 'OTLN.dat'