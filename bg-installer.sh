#!/bin/bash
tooldir=`dirname $0`
tooldir=$PWD/$tooldir
application_dir="$tooldir"
#source .aliases

cd $application_dir;

for repo in  https://github.com/Open-Succinct-Community/common.git https://github.com/beckn-on-succinct/beckn-sdk-java.git https://github.com/Open-Succinct-Community/swf-all.git https://github.com/Open-Succinct-Community/swf-plugin-tailwind.git https://github.com/beckn-on-succinct/swf-plugin-beckn.git https://github.com/beckn-on-succinct/catalog.indexer.git https://github.com/beckn-on-succinct/onet.core.git https://github.com/beckn-on-succinct/onet.boc.git https://github.com/beckn-on-succinct/beckn-gateway.git
do 
    echo "Building $repo"
    dir=`basename $repo |sed 's/.git//g'`
    if [ ! -d $dir ]
    then
        git clone $repo
    fi
    if [ $dir == "swf-plugin-tailwind" ]; then
        echo $dir
        git stash
        git pull
        cd ${dir}/src/main/resources/scripts/highlight.js/
        npm install
        cd ${application_dir}/${dir}
        mvn clean install
        cd ${application_dir}
    else
        cd ${application_dir}/${dir}
        git stash
        git pull
        mvn clean install
        cd ${application_dir}
    fi
done
