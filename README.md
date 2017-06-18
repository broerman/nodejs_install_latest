# Nodejs bash install


### editable settings

    NODE_VERSION_REQ="v6"
    NODE_VERSION_ARCH="linux-x64"
    NODE_PACKAGE_FORMAT="tar.gz"


### find versions

    NODE_VERSIONS=$( curl -s https://nodejs.org/dist/ | sed -n "s/<a href=\".*\">\(.*\)\/<\/a>.*/\1/p")

### find latest

    NODE_VERSION_REQ_LATEST=$(  echo "$NODE_VERSIONS" | sort -V | grep $NODE_VERSION_REQ | tail -n1 )


### determine package file

    NODEPACKAGEFILE=$( curl -s https://nodejs.org/dist/$NODE_VERSION_REQ_LATEST/ | sed -n "s/<a href=\".*\">\(.*$NODE_VERSION_ARCH.*$NODE_PACKAGE_FORMAT\)<\/a>.*/\1/p" )
    echo $NODEPACKAGEFILE


### download to /opt

    cd /opt
    wget https://nodejs.org/dist/$NODE_VERSION_REQ_LATEST/$NODEPACKAGEFILE

### unpack 

    tar -xvzf $NODEPACKAGEFILE

### moveit

    mv node-$NODE_VERSION_REQ_LATEST-$NODE_VERSION_ARCH nodejs

### remove packagefile

    rm $NODEPACKAGEFILE

### link to use it

    ln -s /opt/nodejs/bin/node /usr/bin/node
    ln -s /opt/nodejs/bin/npm /usr/bin/npm

