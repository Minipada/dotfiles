#!/bin/bash

BOOST_VERSION_MAIN="1"
BOOST_VERSION_SUB="58"
OUTPUT_BOOST_TAR="boost_$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB.tar.gz"
OUTPUT_BOOST="boost_$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB"
wget --output-document=$OUTPUT_BOOST https://sourceforge.net/projects/boost/files/boost/$BOOST_VERSION_MAIN.$BOOST_VERSION_SUB.0/boost_$BOOST_VERSION_MAIN\_$BOOST_VERSION_SUB\_0.tar.gz/download
tar -xzvf $OUTPUT_BOOST
cd $OUTPUT_BOOST
./bootstrap.sh --libdir=/usr/lib/x86_64-linux-gnu
./b2
sudo ./b2 install
rm -rf $OUTPUT_BOOST