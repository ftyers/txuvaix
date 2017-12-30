tags=$1
tip=`echo "$tags" | grep '\.' | wc -l`
if [[ $tip -gt 0 ]]; then
	tags=`echo $1 | sed 's/\./></g' | sed 's/^/</g' | sed 's/$/>/g'`;
fi
total=0
wgn=0
wmf=0
for i in `cat test/chv.txt | grep "$tags"`; do 
	lex=`echo $i | cut -f1 -d':'`;
	sur=`echo $i | cut -f2 -d':'`;
	mtx=`echo $lex | hfst-lookup -qp chv.lexc.hfst | cut -f2 | grep -v '^$' | tr '\n' '|' | sed 's/|$//g'`;
	
	gen=`echo "$lex" | hfst-optimised-lookup -b 0 -qp chv.gen.hfstol  | cut -f2 | grep -v '^$' | tr '\n' '|' | sed 's/|$//g'`
	mor=`echo "$sur" | hfst-optimised-lookup -qp chv.mor.hfstol | cut -f2 | grep -v '^$' | tr '\n' '/' | sed 's/\/$//g'`;

	rgn="-"
	rmf="-"
	if [[ $sur = $gen ]]; then
		rgn="+";
		wgn=`expr $wgn + 1`;
	fi	
	res=`echo "$mor" | grep "$lex" | wc -l`;
	if [[ $res -gt 0 ]]; then
		rmf="+";
		wmf=`expr $wmf + 1`;
	fi

	echo -e "$rgn\t$rmf\t$lex\t$mtx\t$sur\t$gen\t$mor"
	total=`expr $total + 1`;
done

echo "$wgn/$total"
echo "$wmf/$total"
