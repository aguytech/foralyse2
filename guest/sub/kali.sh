#!/bin/bash

### repository

# ADDING REPOSITORY IS VERY INVASING IN THE SYSTEM !!

sudo sh -c "echo '# kali\ndeb http://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"
curl https://archive.kali.org/archive-key.asc | sudo apt-key add -

# comment to use repository
sed -i '/^deb/ s|^|#|' /etc/apt/sources.list.d/kali.list

sudo apt update
