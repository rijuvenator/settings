#!/usr/bin/env python

import sys
import argparse

# parse command line arguments
parser = argparse.ArgumentParser(formatter_class=lambda prog: argparse.HelpFormatter(prog,max_help_position=30))
parser.add_argument('-m', '--maxbar'  , type=int, default=50, help='bar size'                        )
parser.add_argument('-b', '--nobytes' , action='store_true',  help='don\'t print apparent size'      )
parser.add_argument('-H', '--nohuman' , action='store_true',  help='don\'t print human readable size')
args = parser.parse_args()

# gets output of du, LS_COLORS, and ls
ducmd = r'du -c{BYTES}s $(ls -FA) 2>/dev/null | sort -n -r -k 1'.format(BYTES='k' if args.nobytes else 'b')
lscmd = r'echo $LS_COLORS'
flcmd = r'ls -FA'
version = sys.version_info[0]*10 + sys.version_info[1]
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

# fills ftypes dictionary {type : colorcode}
ftypes = {'' : '', 'b' : '1'}
for pair in lscolors:
	lpair = pair.split('=')
	if lpair[0][0] == '*':
		tmp = lpair[0][1:]
		lpair[0] = tmp
	ftypes[lpair[0]] = lpair[1]

# prints text with a color code given by opt
def colstring(text, opt=''):
	return '\033[' + ftypes[opt] + 'm' + text + '\033[m'

# returns a bar string as a fraction of maxbar with color
def piebar(fraction, MAXBAR=args.maxbar, COL='2'):
	string = '\033[48;5;'+COL+'m'
	for i in range(int(round(fraction * MAXBAR))):
		string += ' '
	string += '\033[m'
	return string

# returns a human readable size string, otherwise just str(size)
def getFormattedSize(size, HUMAN=not args.nohuman, NOBYTES=args.nobytes):
	if HUMAN:
		fsize = size * 2**10 if NOBYTES else size
		fdict = {2**40 : 'G', 2**20 : 'M', 2**10 : 'K'}
		for bsize in fdict:
			if fsize >= bsize:
				fsize = '{0:3.1f}'.format(float(fsize)/(bsize))+fdict[bsize]
				break
		else:
			fsize = str(fsize)+'B'
	else:
		fsize = str(size)
	return fsize

print ''
MAXLENGTH = max([len(x) for x in filelist])
total = None
for line in lines:
	if line == '': continue
	opt = ''
	cols = line.split()
	if total is None:
		# set size, name = TOTAL, color opt = bold
		total = int(cols[0])
		size  = total
		name  = 'TOTAL'
		opt   = 'b'

		# set realmax characters, maxsize characters, format string, formatted size string, then print
		fsize = getFormattedSize(size)
		REALMAX = MAXLENGTH-len(name)+len(colstring(name, opt))
		fstring = '{{NAME:>{REALMAX}s}} {{SIZE:>{MAXSIZE}s}}         {{BAR:s}}'.format(REALMAX=REALMAX, MAXSIZE=max(5, len(fsize)))
		print fstring.format(NAME=colstring(name, opt), SIZE=fsize, BAR=piebar(1., COL='9'))
	else:
		# set size, name => name from ls, color opt
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

		# set realmax characters, maxsize characters, format string, formatted size string, then print
		fsize = getFormattedSize(size)
		REALMAX = MAXLENGTH-len(name)+len(colstring(name, opt))
		MAXSIZE = len(str(size)) if args.nohuman else 5
		fstring = '{{NAME:>{REALMAX}s}} {{SIZE:>{MAXSIZE}s}} {{PERCENT:6.2f}}% {{BAR:s}}'.format(REALMAX=REALMAX, MAXSIZE=max(5, len(fsize)))
		print fstring.format(NAME=colstring(name, opt), PERCENT=float(size)/total*100, SIZE=fsize, BAR=piebar(float(size)/total))
print ''
