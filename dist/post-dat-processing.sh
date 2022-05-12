#!/bin/bash

if [ -f 'OTLN.dat' ]; then
  sed -i '/cover.jpg/d' 'OTLN.dat'
  sed '/<machine name="Default">/{:a;N;/<\/machine>/!ba};/<description>Default/d' 'OTLN.dat' > 'OTLN_metadata.dat'
  rm 'OTLN.dat'
else
  echo 'No OTLN.dat found'
fi