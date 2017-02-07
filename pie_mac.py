#!/usr/bin/env python

import sys
version = sys.version_info[0]*10 + sys.version_info[1]

if len(sys.argv)>1:
	maxbar=int(sys.argv[1])
else:
	maxbar=50

ducmd = r'du -cks $(ls -FA) 2>/dev/null | sort -n -r -k 1'
flcmd = r'ls -FA'
if version > 26:
	import subprocess as bash
	lines    = bash.check_output(ducmd, shell=True).split('\n')
	filelist = bash.check_output(flcmd, shell=True).strip('\n').split()
else:
	import commands as bash
	lines    = bash.getoutput(ducmd).split('\n')
	filelist = bash.getoutput(flcmd).strip('\n').split()

ftypes = {'' : '', 'b' : '1', 'di':'1;34', 'ln':'1;36', 'ex':'1;31'}

def colstring(text, opt=''):
	return '\033[' + ftypes[opt] + 'm' + text + '\033[m'

def piebar(fraction, MAXBAR=maxbar, COL='2'):
	string = '\033[48;5;'+COL+'m'
	for i in range(int(round(fraction * MAXBAR))):
		string += ' '
	string += '\033[m'
	return string

print ''
MAXLENGTH = max([len(x) for x in filelist])
total = None
for line in lines:
	if line == '': continue
	opt = ''
	cols = line.split()
	if total is None:
		total = int(cols[0])
		size = total
		opt = 'b'
		name = 'TOTAL'
		MAXSIZE = len(str(size))

		REALMAX = MAXLENGTH-len(name)+len(colstring(name, opt))
		fstring = '{NAME:>'+str(REALMAX)+'s} {SIZE:'+str(MAXSIZE)+'d}         {BAR:s}'
		print fstring.format(NAME=colstring(name, opt), SIZE=size, BAR=piebar(1., COL='9'))
	else:
		size = int(cols[0])
		name = cols[1]
	
		for f in filelist:
			if name in f:
				name = f

		if name[-1] == '/':
			opt = 'di'
		elif name[-1] == '@':
			opt = 'ln'
		elif name[-1] == '*':
			opt = 'ex'

		REALMAX = MAXLENGTH-len(name)+len(colstring(name, opt))
		fstring = '{NAME:>'+str(REALMAX)+'s} {SIZE:'+str(MAXSIZE)+'d} {PERCENT:6.2f}% {BAR:s}'
		print fstring.format(NAME=colstring(name, opt), PERCENT=float(size)/total*100, SIZE=size, BAR=piebar(float(size)/total))
print ''
