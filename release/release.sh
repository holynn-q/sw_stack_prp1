#!/bin/bash
# @author   walh@zhaw.ch
# @date     11-04-2012
# @brief    release build script for sw_stack PRP-1
### ----------------------------------------------------------------------------
set -e

# log info
echo "#################################################"
echo "### build SW_Stack_PRP-1                      ###"
echo "#################################################"
echo "-> doc"
echo "-> prp"
echo "-> prp_pcap_tap_userspace"

# remove old builds, create new build ------------------------------------------
rm -rf build
mkdir build

# get release number -----------------------------------------------------------
if head -n 1 changelog.txt | grep '^Release '; then
    version=$(head -n 1 changelog.txt | sed -e 's/^Release //' | tr -d '[:space:]')
fi


# copy documentation
mkdir build/doc
if [ -f ../doc/PRP-1_stack.pdf ]; then
    cp ../doc/PRP-1_stack.pdf build/doc/
else
    echo "Docu does not exist"
    exit 1
fi

# svn exports ------------------------------------------------------------------
svn export ../prp/ build/prp
svn export ../prp_pcap_tap_userspace build/prp_pcap_tap_userspace

# create zip file --------------------------------------------------------------
cd build
zip --quiet -r sw_stack_prp-1.zip  *

echo "-> build/sw_stack_prp-1.zip"
echo "### done..."

exit 0
