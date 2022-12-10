#!/bin/bash

export woocommerce_adaptor_repo="git@github.com:venkatramanm/bpp.woocommerce.git" 

tooldir=`dirname $0`
tooldir=$PWD/$tooldir
application_dir="$tooldir/site"

mkdir -p $application_dir
cd $application_dir

for repo in "git@github.com:venkatramanm/common.git" "git@github.com:venkatramanm/reflection.git" "git@github.com:venkatramanm/swf-all.git" "git@github.com:venkatramanm/swf-plugin-bootstrap.git" "git@github.com:venkatramanm/beckn-sdk-java.git" "git@github.com:venkatramanm/swf-plugin-beckn.git" "git@github.com:venkatramanm/bpp.shell.git" $woocommerce_adaptor_repo
do 
    echo "Building $repo"
    dir=`basename $repo |sed 's/.git//g'`
    if [ ! -d $dir ] 
    then
        git clone $repo 
    fi
    cd $application_dir/$dir 
    git pull
    if [ "$repo" != "$woocommerce_adaptor_repo" ] 
    then 
        mvn clean install 
    else
        mvn clean compile
    fi
    cd $application_dir
done

cd $application_dir/bpp.woocommerce/
chmod +x bin/*
#rsync --ignore-existing -av overrideProperties.sample/ overrideProperties/
