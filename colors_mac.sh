#!/bin/bash

echo -e "\033[1;4;38;5;9mC \033[1;4;38;5;208mO \033[1;4;38;5;11mL \033[1;4;38;5;34mO \033[1;4;38;5;12mR \033[1;4;38;5;129mS\033[m"

#echo -e "\033[1mUsage:\033[m"
echo -e "\033[1mUsage:\033[m colors.sh [OPTIONS]"
#echo "  colors.sh [OPTIONS]"

echo -e "\033[1mOptions:\033[m"
echo "  -t, --text      color foreground text instead"
echo "  -e, --empty     print color boxes without numbers"
echo "  -c, --columns   print in a tall column (for terminal widths less than 144 characters)"
echo ""

printf "\033[4mTo use an SGR code, do:\033[m \033[1mprintf "
printf '"\'
printf "033[CODEm"
printf '"'"\033[m\n"
echo -e "\033[1mCODE\033[m is one of "
echo -e "  \033[1m38;5;INDEX\033[m  (foreground)"
echo -e "  \033[1m48;5;INDEX\033[m  (background)"
echo -e "\033[1mINDEX\033[m is as below"
echo ""

echo -e "\033[4mOther SGR CODEs:\033[m"
echo -e "  1: \033[1mLorem ipsum\033[m (bold)"
echo -e "  2: \033[2mLorem ipsum\033[m (faint)"
echo -e "  4: \033[4mLorem ipsum\033[m (underline)"
echo -e "  5: \033[5mLorem ipsum\033[m (blink)"
echo -e "  7: \033[7mLorem ipsum\033[m (invert)"
echo -e "  8: \033[8mLorem ipsum\033[m (conceal)"
echo ""

echo -e "\033[4mStandard color CODEs:\033[m"
echo -e "   \033[1m30 + n\033[m: foreground color                     equivalent to 38;5;n"
echo -e "   \033[1m40 + n\033[m: background color                     equivalent to 48;5;n"
echo -e "   \033[1m90 + n\033[m: high intensity foreground color      equivalent to 38;5;n+8"
echo -e "  \033[1m100 + n\033[m: high intensity background color      equivalent to 48;5;n+8"
echo "where 0 ≤ n ≤ 7 as below, or n = 9 for default"
echo ""

echo -e "\033[4mExtended color table\033[m\n"

FGBG=48
PRINTEMPTY=0
COL=0
while [ $# -gt 0 ]
do
	case "$1" in
		-t | --text)
			FGBG=38; shift ;;
		-e | --empty)
			PRINTEMPTY=1; shift ;;
		-c | --columns)
			COL=1; shift ;;
	esac
done

for ((i=0;i<16;i++))
do
	if [ $PRINTEMPTY -eq 0 ]
	then
		printf "\033[$((FGBG));5;$((i))m %3d" $i
	else
		printf "\033[48;5;$((i))m  "
	fi
	printf "\033[m"
	if [ $(((i+1)%8)) -eq 0 ]
	then
		printf "\n"
	fi
done
echo ""
for ((i=16;i<256;i++))
do
	if [ $PRINTEMPTY -eq 0 ]
	then
		printf "\033[$((FGBG));5;$((i))m %3d" $i
	else
		printf "\033[48;5;$((i))m  "
	fi
	printf "\033[m"
	if [ $(((i-15)%6)) -eq 0 ] && [ $COL -eq 1 ]
	then
		printf "\n"
	fi
	if [ $(((i-15)%36)) -eq 0 ]
	then
		if [ $COL -eq 0 ]
		then
			printf "\n"
		else
			printf ""
		fi
	fi
done
echo ""
if [ $COL -eq 0 ]
then
	echo ""
fi
