# Nodejs bash install


install  nodejs v6 lastest  directly  from https://nodejs.org/dist/ under /opt
and link to /usr/bin with automatic architecture recognition.




### editable settings

NODE_MAJOR_VERSION default is v6 , change it by exporting variables

    export NODE_MAJOR_VERSION="v8"


if you are not root user install in your $HOME environment

NODE_DIR default applikationdirectory is /opt

    export NODE_DIR=$HOME

NODE_BIN default Binarypath is /usr/bin 

    export NODE_BIN=$HOME/bin

