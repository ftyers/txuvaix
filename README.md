# Chuvash homework

First fork this repository, and then clone it:

```
$ git clone https://github.com/YOUR_GITHUB_USERNAME/txuvaix.git
```

Now replace the files `chv.lexc` and `chv.twol` and compile:

```
$ make
hfst-lexc chv.lexc -o chv.lexc.hfst
hfst-lexc: warning: Defaulting to OpenFst tropical type
Root...1 CASES...2 PLURAL...2 N...1 Nouns...
hfst-twolc chv.twol -o chv.twol.hfst
Reading input from chv.twol.
Writing output to chv.twol.hfst.
Reading alphabet.
Reading sets.
Reading rules and compiling their contexts and centers.
Compiling rules.
Storing rules.
hfst-compose-intersect -1 chv.lexc.hfst -2 chv.twol.hfst | hfst-minimise -o chv.gen.hfst
hfst-fst2fst -w chv.gen.hfst -o chv.gen.hfstol
hfst-invert chv.gen.hfst | hfst-minimise | hfst-fst2fst -w -o chv.mor.hfstol
```

Then run the test script:

```
$ bash test.sh 
dc gen 10 19:00:18 CET 2018	100.0	0.06169983032546661	0.12332357021735779	14
```

The final output is:

```
DATE                            P       R                       F-score                 Lines
```
