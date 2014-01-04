#!/bin/sh
name=towerdefense;
bld=../build/$name;
cd $name/;
mkdir -p $bld;

###replace dofiles
../rdfr $name.xml > $bld/$name.xml;

version=$(sed -n 's/.*scenarioVersion="\(.*\)"/\1/p' $bld/$name.xml);

###copy all included lua-files
cp -r --parents $(../riff $bld/$name.xml | sort -u) $bld;

###copy used map and techtree
cp -r --parents $(../mtff $bld/$name.xml) $bld;

##copy localizations, credits.txt, readme.txt etc.
cp -r {$name_*.lng,*.txt} $bld;

###build archives
cd ../build;
zip -r $name.$version.zip $name
tar -cvaf $name.$version.tar.gz $name
rm -r $bld