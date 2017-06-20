#!/bin/bash
# Bernd Broermann  bernd@broermann.com


# Nodejs bash install


# this installs  nodejs directly  from https://nodejs.org/dist/ under /opt
# and link to /usr/bin.


# URL will be expanded in this script
    URL="https://nodejs.org/dist/"

### editable settings

    # Version 6 default
    NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION:-v6}

    # architectures seen linux-arm64 linux-armv6l linux-armv7l linux-ppc64 linux-ppc64le linux-s390x linux-x64 linux-x86

    ARCH=$( uname -m ) 
    ARCH=${ARCH/x86_64/x64}
    ARCH=${ARCH/i[346]86/x86}

    # for linux only ;)
    NODE_VERSION_ARCH="linux-$ARCH"

    # we prefer gzipped tarballs
    NODE_PACKAGE_FORMAT="tar.gz"

    # preset application dir is /opt
    NODE_DIR=${NODE_DIR:-/opt}
    # binary dir is
    NODE_BIN=${NODE_BIN:-/usr/bin}

    if test ! -d $NODE_BIN ; then 
	    echo "!! $NODE_BIN not found! correct \$NODE_BIN or create binary directory first and possibly adjust your PATH variable" ; exit 1
    fi    

### find versions
    NODE_VERSIONS=$( ( curl -s $URL || wget -q $URL -O - ) | sed -n "s/<a href=\".*\">\(.*\)\/<\/a>.*/\1/p")

### find latest

    NODE_VERSION=$( echo "$NODE_VERSIONS" | sort -V | grep $NODE_MAJOR_VERSION | tail -n1 )


### determine package file
    URL="$URL$NODE_VERSION/"
    NODEPACKAGEFILE=$( ( curl -s $URL || wget -q $URL -O - ) | sed -n "s/<a href=\".*\">\(.*$NODE_VERSION_ARCH.*$NODE_PACKAGE_FORMAT\)<\/a>.*/\1/p" )
    echo "try to install $NODEPACKAGEFILE ."


### download to /opt

    if test -e $NODE_DIR/$NODEPACKAGEFILE ; then
       echo "$NODE_DIR/$NODEPACKAGEFILE allready exists"
    else        
	 URL=$URL$NODEPACKAGEFILE    
         ( curl -s $URL -o $NODE_DIR/$NODEPACKAGEFILE || wget -q $URL -O $NODE_DIR/$NODEPACKAGEFILE )
    fi
### unpack 


 
    tar -C $NODE_DIR  -xzf $NODE_DIR/$NODEPACKAGEFILE
    echo "$NODE_DIR/$NODEPACKAGEFILE extracted to $NODE_DIR ."
 
### link it
    
    if test -h $NODE_DIR/nodejs ; then 
	    rm $NODE_DIR/nodejs
    fi	    
     
    
    ln -sf  $NODE_DIR/node-$NODE_VERSION-$NODE_VERSION_ARCH $NODE_DIR/nodejs
    echo "linked to $NODE_DIR/nodejs ."

### remove packagefile

    rm $NODE_DIR/$NODEPACKAGEFILE

### link to use it

    ln -sf $NODE_DIR/nodejs/bin/node $NODE_BIN/node
    ln -sf $NODE_DIR/nodejs/bin/npm  $NODE_BIN/npm

    type node
    type npm

    echo -n "node --version  "
    node --version
    echo -n "npm --version  "
    npm --version     
