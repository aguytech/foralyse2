#!/bin/bash

### install

sudo apt install -y pandoc texlive-latex-base texlive-latex-recommended texlive-latex-extra

### usage#!/bin/bash

_echoyb "To use pandoc:"
echo "pandoc -s -o \$fileout \$filein"
