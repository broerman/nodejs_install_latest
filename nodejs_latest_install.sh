#!/bin/bash
# Nodejs bash install


# install  nodejs directly  from https://nodejs.org/dist/ under /opt
# and link to /usr/bin.



### editable settings

    NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION:-v6}

    NODE_VERSION_ARCH="linux-x64"
    NODE_PACKAGE_FORMAT="tar.gz"

    NODE_DIR=${NODE_DIR:-/opt}
    NODE_BIN=${NODE_BIN:-/usr/bin}

    if test ! -d $NODE_BIN ; then 
	    echo "!! $NODE_BIN not found! create binary directory first and possibly adjust your PATH variable" ; exit 1
    fi    

### find versions

    NODE_VERSIONS=$( curl -s https://nodejs.org/dist/ | sed -n "s/<a href=\".*\">\(.*\)\/<\/a>.*/\1/p")

### find latest

    NODE_VERSION=$( echo "$NODE_VERSIONS" | sort -V | grep $NODE_MAJOR_VERSION | tail -n1 )


### determine package file

    NODEPACKAGEFILE=$( curl -s https://nodejs.org/dist/$NODE_VERSION/ | sed -n "s/<a href=\".*\">\(.*$NODE_VERSION_ARCH.*$NODE_PACKAGE_FORMAT\)<\/a>.*/\1/p" )
    echo $NODEPACKAGEFILE


### download to /opt

    if test -e $NODE_DIR/$NODEPACKAGEFILE ; then
       echo "$NODE_DIR/$NODEPACKAGEFILE allready exists"
    else        
       wget https://nodejs.org/dist/$NODE_VERSION/$NODEPACKAGEFILE -O $NODE_DIR/$NODEPACKAGEFILE
    fi
### unpack 


 
    tar -C $NODE_DIR  -xzf $NODE_DIR/$NODEPACKAGEFILE
    echo "$NODE_DIR/$NODEPACKAGEFILE extracted to $NODE_DIR"
 
### link it
    
    if test -h $NODE_DIR/nodejs ; then 
	    rm $NODE_DIR/nodejs
    fi	    
     
    
    ln -sf  $NODE_DIR/node-$NODE_VERSION-$NODE_VERSION_ARCH $NODE_DIR/nodejs
    echo "linked to $NODE_DIR/nodejs"

### remove packagefile

    rm $NODE_DIR/$NODEPACKAGEFILE

### link to use it

    ln -sf $NODE_DIR/nodejs/bin/node $NODE_BIN/node
    ln -sf $NODE_DIR/nodejs/bin/npm  $NODE_BIN/npm

    echo "binaries linked to PATH:"
    type node
    type npm

    echo "node --version"
    node --version
    echo "npm --version"
    npm --version     
