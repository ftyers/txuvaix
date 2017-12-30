all: chv.lexc.hfst chv.twol.hfst 
	hfst-compose-intersect -1 chv.lexc.hfst -2 chv.twol.hfst | hfst-minimise -o chv.gen.hfst
	hfst-fst2fst -w chv.gen.hfst -o chv.gen.hfstol
	hfst-invert chv.gen.hfst | hfst-minimise | hfst-fst2fst -w -o chv.mor.hfstol

chv.lexc.hfst: chv.lexc
	hfst-lexc chv.lexc -o chv.lexc.hfst

chv.twol.hfst: chv.twol
	hfst-twolc chv.twol -o chv.twol.hfst
clean:
	rm *.hfst *.hfstol
