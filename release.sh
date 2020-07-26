#!/bin/bash

# Current Version: 1.0.6

## How to get and use?
# git clone "https://github.com/hezhijie0327/AdFilter.git" && chmod 0777 ./AdFilter/release.sh && bash ./AdFilter/release.sh

## Function
# Get Data
function GetData() {
    filter_adblock=(
        "https://easylist-downloads.adblockplus.org/easylistchina.txt"
        "https://filters.adtidy.org/extension/chromium/filters/224.txt"
        "https://gitee.com/banbendalao/adguard/raw/master/ADgk.txt"
        "https://gitee.com/cjx82630/cjxlist/raw/master/cjx-annoyance.txt"
        "https://gitee.com/cjx82630/cjxlist/raw/master/cjxlist.txt"
        "https://gitee.com/halflife/list/raw/master/ad.txt"
        "https://raw.githubusercontent.com/VeleSila/VELE-SILA-List/gh-pages/KaFanList.txt"
    )
    filter_domain=(
        "https://gitee.com/damengzhudamengzhu/guanggaoguolv/raw/master/jiekouAD.txt"
        "https://raw.githubusercontent.com/Licolnlee/AdBlockList/master/domain.txt"
        "https://raw.githubusercontent.com/examplecode/ad-rules-for-xbrowser/master/core-rule-cn.txt"
    )
    filter_hosts=(
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/-/raw/master/hosts_browser"
        "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
        "https://raw.githubusercontent.com/durablenapkin/scamblocklist/master/hosts.txt"
        "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
        "https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts"
        "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
        "https://raw.githubusercontent.com/neoFelhz/neohosts/gh-pages/full/hosts"
        "https://www.malwaredomainlist.com/hostslist/hosts.txt"
    )
    rm -rf *.txt *.conf ./Temp && mkdir ./Temp && cd ./Temp
    for filter_adblock_task in "${!filter_adblock[@]}"; do
        curl -s --connect-timeout 15 "${filter_adblock[$filter_adblock_task]}" >> ./filter_adblock.tmp
    done
    for filter_domain_task in "${!filter_domain[@]}"; do
        curl -s --connect-timeout 15 "${filter_domain[$filter_domain_task]}" >> ./filter_domain.tmp
    done
    for filter_hosts_task in "${!filter_hosts[@]}"; do
        curl -s --connect-timeout 15 "${filter_hosts[$filter_hosts_task]}" >> ./filter_hosts.tmp
    done
}
# Analyse Data
function AnalyseData() {
    filter_data=($(cat ./filter_adblock.tmp | grep -v "\#\|\\$\|\*\|\/\|\:\|\@" | grep "||" | sed "s/\^//g;s/\|//g" > ./filter_data.tmp && cat ./filter_domain.tmp | grep -v "\!\|\#\|\/\|\:\|\[\|\]\|\|" >> ./filter_data.tmp && cat ./filter_hosts.tmp | grep -v "\#" | grep "0\.0\.0\.0\|127\.0\.0\.1\|\:\:\|\:\:1" | sed "s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/\:\://g" >> ./filter_data.tmp && cat ./filter_data.tmp | grep -v "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" | grep "\." | tr -d -c "[:alnum:]\-\.\n" | tr "A-Z" "a-z" | sed "/\-$/d;/\.$/d;/^$/d;/^\-/d;/^\./d;s/[[:space:]]//g" | sort | uniq | awk "{ print $2 }"))
}
# Generate Information
function GenerateInformation() {
    adfilter_checksum=$(date "+%s" | base64)
    adfilter_description="Filter composed of several other filters which can effectively block the Chinese ads, crypto mining (browser-based), malware domains and online scams."
    adfilter_expires="3 hours (update frequency)"
    adfilter_homepage="https://github.com/hezhijie0327/AdFilter"
    adfilter_timeupdated=$(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    adfilter_title="Zhijie's Ad Filter"
    adfilter_total=$(cat ./filter_data.tmp | grep -v "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" | grep "\." | tr -d -c "[:alnum:]\-\.\n" | tr "A-Z" "a-z" | sed "/\-$/d;/\.$/d;/^$/d;/^\-/d;/^\./d;s/[[:space:]]//g" | sort | uniq > ./checklist.tmp && sed -n '$=' ./checklist.tmp)
    adfilter_version=$(cat ../release.sh | grep "Current\ Version" | sed "s/\#\ Current\ Version\:\ //g")-$(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y%m%d")-$(($(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%H") / 3))
    function adfilter_adblock() {
        echo "! Checksum: ${adfilter_checksum}" > ../adfilter_adblock.txt
        echo "! Title: ${adfilter_title} for Adblock" >> ../adfilter_adblock.txt
        echo "! Description: ${adfilter_description}" >> ../adfilter_adblock.txt
        echo "! Version: ${adfilter_version}" >> ../adfilter_adblock.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_adblock.txt
        echo "! Expires: ${adfilter_expires}" >> ../adfilter_adblock.txt
        echo "! Homepage: ${adfilter_homepage}" >> ../adfilter_adblock.txt
        echo "! Total: ${adfilter_total}" >> ../adfilter_adblock.txt
    }
    function adfilter_dnsmasq() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_dnsmasq.conf
        echo "# Title: ${adfilter_title} for Dnsmasq" >> ../adfilter_dnsmasq.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_dnsmasq.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_dnsmasq.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_dnsmasq.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_dnsmasq.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_dnsmasq.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_dnsmasq.conf
    }
    function adfilter_domains() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_domains.txt
        echo "# Title: ${adfilter_title} for Pi-hole" >> ../adfilter_domains.txt
        echo "# Description: ${adfilter_description}" >> ../adfilter_domains.txt
        echo "# Version: ${adfilter_version}" >> ../adfilter_domains.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_domains.txt
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_domains.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_domains.txt
        echo "# Total: ${adfilter_total}" >> ../adfilter_domains.txt
    }
    function adfilter_hosts() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_hosts.txt
        echo "# Title: ${adfilter_title} for AdAway" >> ../adfilter_hosts.txt
        echo "# Description: ${adfilter_description}" >> ../adfilter_hosts.txt
        echo "# Version: ${adfilter_version}" >> ../adfilter_hosts.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_hosts.txt
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_hosts.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_hosts.txt
        echo "# Total: ${adfilter_total}" >> ../adfilter_hosts.txt
        echo "# (DO NOT REMOVE)" >> ../adfilter_hosts.txt
        echo "127.0.0.1 localhost" >> ../adfilter_hosts.txt
        echo "255.255.255.255 broadcasthost" >> ../adfilter_hosts.txt
        echo "::1 ip6-localhost ip6-loopback localhost" >> ../adfilter_hosts.txt
        echo "fe00::0 ip6-localnet" >> ../adfilter_hosts.txt
        echo "ff00::0 ip6-mcastprefix" >> ../adfilter_hosts.txt
        echo "ff02::1 ip6-allnodes" >> ../adfilter_hosts.txt
        echo "ff02::2 ip6-allrouters" >> ../adfilter_hosts.txt
        echo "ff02::3 ip6-allhosts" >> ../adfilter_hosts.txt
        echo "# (DO NOT REMOVE)" >> ../adfilter_hosts.txt
    }
    function adfilter_smartdns() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_smartdns.conf
        echo "# Title: ${adfilter_title} for SmartDNS" >> ../adfilter_smartdns.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_smartdns.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_smartdns.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_smartdns.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_smartdns.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_smartdns.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_smartdns.conf
    }
    function adfilter_surge() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_surge.txt
        echo "# Title: ${adfilter_title} for Surge" >> ../adfilter_surge.txt
        echo "# Description: ${adfilter_description}" >> ../adfilter_surge.txt
        echo "# Version: ${adfilter_version}" >> ../adfilter_surge.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_surge.txt
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_surge.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_surge.txt
        echo "# Total: ${adfilter_total}" >> ../adfilter_surge.txt
    }
    function adfilter_unbound() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_unbound.conf
        echo "# Title: ${adfilter_title} for Unbound" >> ../adfilter_unbound.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_unbound.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_unbound.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_unbound.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_unbound.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_unbound.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_unbound.conf
    }
    adfilter_adblock
    adfilter_dnsmasq
    adfilter_domains
    adfilter_hosts
    adfilter_smartdns
    adfilter_surge
    adfilter_unbound
}
# Output Data
function OutputData() {
    if [ ! -f "../adfilter_domains.txt" ]; then
        GenerateInformation
        for filter_data_task in "${!filter_data[@]}"; do
            echo "${filter_data[$filter_data_task]}" | sed "s/^/\|\|/g;s/$/\^/g" >> ../adfilter_adblock.txt
            echo "${filter_data[$filter_data_task]}" | sed "s/^/address\=\//g;s/$/\//g" >> ../adfilter_dnsmasq.conf
            echo "${filter_data[$filter_data_task]}" | sed "s/^//g;s/$//g" >> ../adfilter_domains.txt
            echo "${filter_data[$filter_data_task]}" | sed "s/^/127\.0\.0\.1\ /g;s/$//g" >> ../adfilter_hosts.txt
            echo "${filter_data[$filter_data_task]}" | sed "s/^/\:\:1\ /g;s/$//g" >> ../adfilter_hosts.txt
            echo "${filter_data[$filter_data_task]}" | sed "s/^/address\ \//g;s/$/\/\#/g" >> ../adfilter_smartdns.conf
            echo "${filter_data[$filter_data_task]}" | sed "s/^/DOMAIN\-SUFFIX\,/g;s/$//g" >> ../adfilter_surge.txt
            echo "${filter_data[$filter_data_task]}" | sed "s/^/local\-zone\:\ \"/g;s/$/\.\"\ redirect/g" >> ../adfilter_unbound.conf
        done
        cd .. && rm -rf ./Temp
        exit 0
    else
        cat ../adfilter_domains.txt | head -n $(sed -n '$=' ../adfilter_domains.txt) | tail -n +9 > ./checklist.old
        if [ "$(diff ./checklist.tmp ./checklist.old)" = "" ]; then
            cd .. && rm -rf ./Temp
            exit 0
        else
            GenerateInformation
            for filter_data_task in "${!filter_data[@]}"; do
                echo "${filter_data[$filter_data_task]}" | sed "s/^/\|\|/g;s/$/\^/g" >> ../adfilter_adblock.txt
                echo "${filter_data[$filter_data_task]}" | sed "s/^/address\=\//g;s/$/\//g" >> ../adfilter_dnsmasq.conf
                echo "${filter_data[$filter_data_task]}" | sed "s/^//g;s/$//g" >> ../adfilter_domains.txt
                echo "${filter_data[$filter_data_task]}" | sed "s/^/127\.0\.0\.1\ /g;s/$//g" >> ../adfilter_hosts.txt
                echo "${filter_data[$filter_data_task]}" | sed "s/^/\:\:1\ /g;s/$//g" >> ../adfilter_hosts.txt
                echo "${filter_data[$filter_data_task]}" | sed "s/^/address\ \//g;s/$/\/\#/g" >> ../adfilter_smartdns.conf
                echo "${filter_data[$filter_data_task]}" | sed "s/^/DOMAIN\-SUFFIX\,/g;s/$//g" >> ../adfilter_surge.txt
                echo "${filter_data[$filter_data_task]}" | sed "s/^/local\-zone\:\ \"/g;s/$/\.\"\ redirect/g" >> ../adfilter_unbound.conf
            done
            cd .. && rm -rf ./Temp
            exit 0
        fi
    fi
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
