#!/bin/bash
export adaptor=woocommerce

export adaptor_repo="https://github.com/venkatramanm/bpp.${adaptor}.git" 

tooldir=`dirname $0`
tooldir=$PWD/$tooldir
application_dir="$tooldir/site"

mkdir -p $application_dir
cd $application_dir

for repo in "https://github.com/venkatramanm/common.git" "https://github.com/venkatramanm/reflection.git" "https://github.com/venkatramanm/swf-all.git" "https://github.com/venkatramanm/swf-plugin-bootstrap.git" "https://github.com/venkatramanm/beckn-sdk-java.git" "https://github.com/venkatramanm/swf-plugin-beckn.git" "https://github.com/venkatramanm/bpp.core.git" "https://github.com/venkatramanm/bpp.shell.git" "https://github.com/venkatramanm/bpp.search.git" "https://github.com/venkatramanm/swf-bpp-archetype.git" "$adaptor_repo"
do 
    echo "Building $repo"
    dir=`basename $repo |sed 's/.git//g'`
    if [ ! -d $dir ] 
    then
        git clone $repo 
    fi
    cd $application_dir/$dir 
    git pull
    mvn clean install 
    cd $application_dir
done

cd $application_dir/
if [ ! -d "${adaptor}.app" ] 
then
mvn archetype:generate -DarchetypeGroupId=com.github.venkatramanm.swf-all -DarchetypeArtifactId=swf-bpp-archetype -DarchetypeCatalog=local -DgroupId=in.succinct -DartifactId=${adaptor}.app -Dadaptor=${adaptor} -Dversion=1.0-SNAPSHOT
fi
cd ${adaptor}.app 
mvn clean compile 
chmod +x bin/*

#rsync --ignore-existing -av overrideProperties.sample/ overrideProperties/
