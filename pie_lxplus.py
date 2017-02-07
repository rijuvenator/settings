#!/usr/bin/env python

import sys
version = sys.version_info[0]*10 + sys.version_info[1]

if len(sys.argv)>1:
	maxbar=int(sys.argv[1])
else:
	maxbar=50

ducmd = r'du -cks $(ls -FA) 2>/dev/null | sort -n -r -k 1'
lscmd = r'echo $LS_COLORS'
flcmd = r'ls -FA'
if version > 26:
	import subprocess as bash
	lines    = bash.check_output(ducmd, shell=True).split('\n')
	lscolors = bash.check_output(lscmd, shell=True).strip('\n').split(':')
	filelist = bash.check_output(flcmd, shell=True).strip('\n').split()
else:
	import commands as bash
	lines    = bash.getoutput(ducmd).split('\n')
	lscolors = bash.getoutput(lscmd).strip('\n').split(':')
	filelist = bash.getoutput(flcmd).strip('\n').split()

ftypes = {'' : '', 'b' : '1'}
for pair in lscolors:
	lpair = pair.split('=')
	if lpair[0][0] == '*':
		tmp = lpair[0][1:]
		lpair[0] = tmp
	ftypes[lpair[0]] = lpair[1]

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
		else:
			for i in range(2,6):
				if name[-i:] in ftypes.keys():
					opt = name[-i:]
					break

		REALMAX = MAXLENGTH-len(name)+len(colstring(name, opt))
		fstring = '{NAME:>'+str(REALMAX)+'s} {SIZE:'+str(MAXSIZE)+'d} {PERCENT:6.2f}% {BAR:s}'
		print fstring.format(NAME=colstring(name, opt), PERCENT=float(size)/total*100, SIZE=size, BAR=piebar(float(size)/total))
print ''
