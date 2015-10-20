#!/bin/bash

sed -e "s/\\\e/\\\033/g" -e "s/e\[/033\[/" colors.sh > colors_mac.sh
chmod +x colors_mac.sh
