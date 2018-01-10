#!/bin/bash

total=0
win=0
str=$1
of=/tmp/chv.out
lines=`cat chv.lexc chv.twol | grep -v '^$' | grep -v '^!' | tr -d '[\n ]' | wc -c | sed 's/$/\/80/g' | bc`

cat test/chv.txt  | cut -f2 -d':' | hfst-proc chv.mor.hfstol > test/chv.tst
for i in `cat test/chv.txt  | cut -f2 -d':'`; do 
	res=`cat test/chv.txt | grep ":$i$" | cut -f1 -d':' | tr '\n' '/' | sed 's/\/$//g'`; echo "^$i/$res$"; 
done > test/chv.ref

d=`date`
echo -ne "$d\t" >> test/history.log
python3 test/evaluate-morph.py test/chv.tst test/chv.ref > test/chv.res 2>> test/history.log
tail -4 test/history.log | sed "s/$/\t$lines/g" >/dev/stderr

#echo "" > $of
#for i in `hfst-fst2strings chv.lexc.hfst | grep -v '<np' | grep "$str"`; do 
#	x=`echo $i | cut -f1 -d':'`; 
#	k=`echo $i | cut -f2 -d':'`; 
#	y=`echo $x | hfst-optimised-lookup -qp chv.gen.hfstol | cut -f2 | grep -v '^$' | sort | tr '\n' '|' | sed 's/|$//g'`
#	z=`cat test/chv.txt | grep "^$x:" | cut -f2 -d':' | sort | tr '\n' '|' | sed 's/|$//g'`;
#	r="-"
#	if [[ $y = $z ]]; then
#		r="+"
#		win=`expr $win + 1`
#	fi
#	echo -e "$r\t$x\t$k\t$z\t$y" >> $of; 
#	total=`expr $total + 1`
#done
#echo "$win/$total"
#
#for i in `cat $of  | grep -P -o '(<[^>\t]+>)+' | sort -u`; do 
#	win=`cat $of | grep "$i" | grep "^+" | wc -l`; 
#	fail=`cat $of | grep "$i" | grep "^-" | wc -l`; 
#	per=`echo "$win/($win+$fail)*100" | bc -l | head -c 5`; 
#	echo -e "$per\t$win\t$fail\t$i"; 
#done | sort -gr > /tmp/chv.par
#
#wc -l /tmp/chv.par /tmp/chv.out
