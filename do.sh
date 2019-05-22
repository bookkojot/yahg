#!/bin/bash

cd hostsblock
make || exit
cd ..

#exit

TMPNAME=tmp-data-domains

rm -rf "$TMPNAME" 2> /dev/null
mkdir "$TMPNAME"
cd "$TMPNAME"

cat ../domains-src.txt | sort -u | wget -i -
cat * | sed "s, \?#.\+,,g" | sort -u | grep "\." | sed "s,^,127.0.0.1 ,g" > ../tmp-hosts-domains

cd ..
#rm -rf "$TMPNAME" 2> /dev/null

#exit

TMPNAME=tmp-data-hostblock

rm -rf "$TMPNAME" 2> /dev/null
mkdir "$TMPNAME"
cd "$TMPNAME"

cat ../hostsblock-src.txt | sort -u | wget -i -
cat *.txt | ../hostsblock/hostsblock | sort -u > ../tmp-hosts-hostsblock
cd ..

#exit

TMPNAME=tmp-data-pre-made

rm -rf "$TMPNAME" 2> /dev/null
mkdir "$TMPNAME"
cd "$TMPNAME"

cat ../pre-made.txt | sort -u | wget -i -
for q in *zip; do unzip -jo "$q";done
grep -rh "^, " . > ../tmp-hosts-pre-made
grep -rh "^0\.0\.0\.0" . > ../tmp-hosts-pre-made
grep -rh "^127\.0\.0\.1" . > ../tmp-hosts-pre-made
cd ..


cat tmp-hosts-* | perl hosts-pretty.pl | sort -u > hosts

