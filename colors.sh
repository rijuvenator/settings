#!/bin/bash

echo -e "\e[1;4;38;5;9mC \e[1;4;38;5;208mO \e[1;4;38;5;11mL \e[1;4;38;5;34mO \e[1;4;38;5;12mR \e[1;4;38;5;129mS\e[m"

#echo -e "\e[1mUsage:\e[m"
echo -e "\e[1mUsage:\e[m colors.sh [OPTIONS]"
#echo "  colors.sh [OPTIONS]"

echo -e "\e[1mOptions:\e[m"
echo "  -t, --text      color foreground text instead"
echo "  -e, --empty     print color boxes without numbers"
echo "  -c, --columns   print in a tall column (for terminal widths less than 144 characters)"
echo ""

printf "\e[4mTo use an SGR code, do:\e[m \e[1mprintf "
printf '"\'
printf "e[CODEm"
printf '"'"\e[m\n"
echo -e "\e[1mCODE\e[m is one of "
echo -e "  \e[1m38;5;INDEX\e[m  (foreground)"
echo -e "  \e[1m48;5;INDEX\e[m  (background)"
echo -e "\e[1mINDEX\e[m is as below"
echo ""

echo -e "\e[4mOther SGR CODEs:\e[m"
echo -e "  1: \e[1mLorem ipsum\e[m (bold)"
echo -e "  2: \e[2mLorem ipsum\e[m (faint)"
echo -e "  4: \e[4mLorem ipsum\e[m (underline)"
echo -e "  5: \e[5mLorem ipsum\e[m (blink)"
echo -e "  7: \e[7mLorem ipsum\e[m (invert)"
echo -e "  8: \e[8mLorem ipsum\e[m (conceal)"
echo ""

echo -e "\e[4mStandard color CODEs:\e[m"
echo -e "   \e[1m30 + n\e[m: foreground color                     equivalent to 38;5;n"
echo -e "   \e[1m40 + n\e[m: background color                     equivalent to 48;5;n"
echo -e "   \e[1m90 + n\e[m: high intensity foreground color      equivalent to 38;5;n+8"
echo -e "  \e[1m100 + n\e[m: high intensity background color      equivalent to 48;5;n+8"
echo "where 0 ≤ n ≤ 7 as below, or n = 9 for default"
echo ""

echo -e "\e[4mExtended color table\e[m\n"

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
		printf "\e[$((FGBG));5;$((i))m %3d" $i
	else
		printf "\e[48;5;$((i))m  "
	fi
	printf "\e[m"
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
		printf "\e[$((FGBG));5;$((i))m %3d" $i
	else
		printf "\e[48;5;$((i))m  "
	fi
	printf "\e[m"
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
