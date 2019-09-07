#!/bin/bash
#Punya Florienzh4x
#How To Use
#Install Conndom 
#how to install conndom ? https://github.com/panophan/Conndom
#and next create proxy command : conndom --proxy-create
#and run this is file bash reverse.sh
#No Limit Reverse Hahaha Lol ~

yougetsignal(){
	web="${1}"
	printf "[!] ${korban} YouGetSignal... "
	curl=$(curl -s -x $(conndom --proxy-rand) --connect-timeout 10 -F "remoteAddress=${web}" "https://domains.yougetsignal.com/domains.php" | grep -Po '\["\K.*?(?=",)')
	if [[ ! $curl == '' ]]; then
		total=$(echo $curl | sed 's/ /\n/g' | wc -l)
		echo "$curl" >> result.tmp
		printf "$total Domains\n"
	else
		printf "0 Domains\n"
	fi
}
viewdns(){
	web="${1}"
	printf "[!] ${korban} ViewDNS... "
	curl=$(curl -s -x $(conndom --proxy-rand) --connect-timeout 10 "https://viewdns.info/reverseip/?host=${web}&t=1" -L -D - | grep -Po '(?<=<td>)[[:alnum:]_.-]+?\.[[:alpha:].]{2,10}[^</td]*')
	if [[ ! $curl == '' ]]; then
		total=$(echo $curl | sed 's/ /\n/g' | wc -l)
		echo "$curl" >> result.tmp
		printf "$total Domains\n"
	else
		printf "0 Domains\n"
	fi
}
hackertarget() {
	web="${1}"
	printf "[!] ${korban} HackerTarget... "
	curl=$(curl -s -x $(conndom --proxy-rand) --connect-timeout 10 -d "theinput=${web}&thetest=reverseiplookup&name_of_nonce_field=d210302267&_wp_http_referer=%2Freverse-ip-lookup%2F" "https://hackertarget.com/reverse-ip-lookup/" | sed -n -e '/<pre id="formResponse">/,/<\/pre>/p' | grep -Po '([[:alnum:]_.-]+?\.){1,5}[[:alpha:].]{2,10}')
	if [[ ! $curl == '' ]]; then
		total=$(echo $curl | sed 's/ /\n/g' | wc -l)
		echo "$curl" >> result.tmp
		printf "$total Domains\n"
	else
		printf "0 Domains\n"
	fi
}


if [[ -z $1 ]]; then
	printf "\nMANA TARGETNYA GOBLOK!1!1!\n\n"
	exit 1;
fi

sed -i 's/\r//' $1
IFS=$'\r\n' GLOBIGNORE='*' command eval  'target=($(cat $1))'
for (( i = 0; i <"${#target[@]}"; i++ )); do
	korban=$(echo "${target[$i]}" | grep -Po '([[:alnum:]_.-]+?\.){1,5}[[:alpha:].]{2,10}')

	ngirim=`expr $i % 20`
	if [[ $ngirim == 0 && $i > 0 ]]; then
		sleep 5
	fi

	yougetsignal ${korban};
	hackertarget ${korban};
	viewdns ${korban};
done
wait
printf "\n[!] Filtering Result... \n"
cat result.tmp | sort -u | uniq >> result-$(date +%F).txt
rm -rf result.tmp
printf "[!] Total : $(cat result-$(date +%F).txt | wc -l) Domains\n\n"