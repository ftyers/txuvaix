import sys
s = 0
t = {}
for line in sys.stdin.readlines():
	if line.strip() == '': continue
	if line.strip()[0] == '!' and line.strip()[1] == '%':
		s += 1
		t[s] = [x for x in line.strip().split(' ') if x != '']
	else:
		continue
	if s == 2: 
		out = '';
		if len(t[1]) != len(t[2]):
			continue
		for i in range(1,len(t[1])):
			out += t[1][i] + ':' + t[2][i] + ' ' 
		print(out)	
		print()
		s = 0

