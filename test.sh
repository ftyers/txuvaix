total=0
win=0
str=$1

for j in `python3 test/extract-phon.py < chv.twol | sed 's/ /_/g'`; do 
	echo "================================================="
	echo $j | sed 's/_/ /g' 
	echo "================================================="
	echo $j | sed 's/_/ /g' | hfst-pair-test chv.twol.hfst
done

cat test/chv.txt  | cut -f2 -d':' | hfst-proc chv.morf.hfst > test/chv.tst
for i in `cat test/chv.txt  | cut -f2 -d':'`; do res=`cat test/chv.txt | grep ":$i$" | cut -f1 -d':' | tr '\n' '/' | sed 's/\/$//g'`; echo "^$i/$res$"; done > test/chv.ref
#python3 test/evaluate-morph.py test/chv.tst test/chv.ref

for i in `hfst-fst2strings chv.lexc.hfst | grep -v '<np' | grep "$str"`; do 
	x=`echo $i | cut -f1 -d':'`; 
	k=`echo $i | cut -f2 -d':'`; 
	y=`echo $x | hfst-lookup -qp chv.gen.hfst | cut -f2 | grep -v '^$' | tr '\n' '|' | sed 's/|$//g'`
	z=`cat test/chv.txt | grep "^$x:" | cut -f2 -d':' | tr '\n' '|' | sed 's/|$//g'`;
	r="-"
	if [[ $y = $z ]]; then
		r="+"
		win=`expr $win + 1`
	fi
	echo -e "$r\t$x\t$k\t$z\t$y";
	total=`expr $total + 1`
done
echo "$win/$total"

python3 test/evaluate-morph.py test/chv.tst test/chv.ref > test/chv.res
