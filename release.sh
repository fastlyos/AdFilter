#!/bin/bash

# Current Version: 1.6.1

## How to get and use?
# git clone "https://github.com/hezhijie0327/AdFilter.git" && chmod 0777 ./AdFilter/release.sh && bash ./AdFilter/release.sh

## Function
# Get Data
function GetData() {
    dead_domain=(
        "https://raw.githubusercontent.com/hezhijie0327/DHDb/master/dhdb_dead.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/domains.dead.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/hostnames.dead.txt"
    )
    filter_adblock=(
        "https://easylist-downloads.adblockplus.org/easylist.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt"
        "https://easylist-downloads.adblockplus.org/easylistchina.txt"
        "https://easylist-downloads.adblockplus.org/easyprivacy+easylist.txt"
        "https://easylist-downloads.adblockplus.org/easyprivacy.txt"
        "https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt"
        "https://filters.adtidy.org/extension/chromium/filters/14.txt"
        "https://filters.adtidy.org/extension/chromium/filters/224.txt"
        "https://filters.adtidy.org/extension/chromium/filters/3.txt"
        "https://gitee.com/xinggsf/Adblock-Rule/raw/master/mv.txt"
        "https://gitee.com/xinggsf/Adblock-Rule/raw/master/rule.txt"
        "https://raw.githubusercontent.com/VeleSila/VELE-SILA-List/gh-pages/KaFanList.txt"
        "https://raw.githubusercontent.com/banbendalao/ADgk/master/ADgk.txt"
        "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt"
        "https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjxlist.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad2.txt"
        "https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad3.txt"
        "https://raw.githubusercontent.com/xinggsf/Adblock-Plus-Rule/master/ABP-FX.txt"
        "https://sub.adtchrome.com/adt-chinalist-easylist.txt"
        "https://www.fanboy.co.nz/enhancedstats.txt"
        "https://www.fanboy.co.nz/r/fanboy-complete.txt"
        "https://www.fanboy.co.nz/r/fanboy-ultimate.txt"
    )
    filter_domain=(
        "https://gitee.com/damengzhudamengzhu/guanggaoguolv/raw/master/jiekouAD.txt"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/list_browser.txt"
        "https://raw.githubusercontent.com/examplecode/ad-rules-for-xbrowser/master/core-rule-cn.txt"
        "https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt"
    )
    filter_hosts=(
        "https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts"
        "https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt"
        "https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts"
        "https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts"
        "https://raw.githubusercontent.com/neoFelhz/neohosts/gh-pages/full/hosts"
    )
    filter_other=(
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanAD.list"
        "https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/BanProgramAD.list"
        "https://raw.githubusercontent.com/ConnersHua/Profiles/master/Surge/Ruleset/Advertising.list"
        "https://raw.githubusercontent.com/ConnersHua/Profiles/master/Surge/Ruleset/Hijacking.list"
        "https://raw.githubusercontent.com/eHpo1/Rules/master/Surge4/Ruleset/Liby.list"
        "https://raw.githubusercontent.com/lhie1/Rules/master/Surge/Surge%203/Provider/Reject.list"
    )
    filter_white=(
        "https://easylist-downloads.adblockplus.org/exceptionrules.txt"
        "https://gitlab.com/ZeroDot1/CoinBlockerLists/-/raw/master/white_list.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdGuardSDNSFilter/master/Filters/exceptions.txt"
        "https://raw.githubusercontent.com/AdguardTeam/AdGuardSDNSFilter/master/Filters/exclusions.txt"
        "https://raw.githubusercontent.com/EnergizedProtection/unblock/master/basic/formats/domains.txt"
        "https://raw.githubusercontent.com/Ultimate-Hosts-Blacklist/whitelist/master/domains.list"
        "https://raw.githubusercontent.com/WildcardTech/Filter-Domain-List/master/whitelist.txt"
        "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/optional-list.txt"
        "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt"
        "https://raw.githubusercontent.com/mkb2091/blockconvert/master/output/whitelist_domains.txt"
        "https://raw.githubusercontent.com/notracking/hosts-blocklists-scripts/master/hostnames.whitelist.txt"
        "https://raw.githubusercontent.com/privacy-protection-tools/dead-horse/master/anti-ad-white-list.txt"
    )
    rm -rf ./Temp && mkdir ./Temp && cd ./Temp
    for dead_domain_task in "${!dead_domain[@]}"; do
        curl -s --connect-timeout 15 "${dead_domain[$dead_domain_task]}" >> ./dead_domain.tmp
    done
    for filter_adblock_task in "${!filter_adblock[@]}"; do
        curl -s --connect-timeout 15 "${filter_adblock[$filter_adblock_task]}" >> ./filter_adblock.tmp
    done
    for filter_domain_task in "${!filter_domain[@]}"; do
        curl -s --connect-timeout 15 "${filter_domain[$filter_domain_task]}" >> ./filter_domain.tmp
    done
    for filter_hosts_task in "${!filter_hosts[@]}"; do
        curl -s --connect-timeout 15 "${filter_hosts[$filter_hosts_task]}" >> ./filter_hosts.tmp
    done
    for filter_other_task in "${!filter_other[@]}"; do
        curl -s --connect-timeout 15 "${filter_other[$filter_other_task]}" >> ./filter_other.tmp
    done
    for filter_white_task in "${!filter_white[@]}"; do
        curl -s --connect-timeout 15 "${filter_white[$filter_white_task]}" >> ./filter_white.tmp
    done
}
# Analyse Data
function AnalyseData() {
    filter_data=($(cat ./dead_domain.tmp ./filter_white.tmp ../data/data_allow.txt | sed "s/[[:space:]]//g;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/\:\:1//g;s/\:\://g" | tr -d "@^|" | tr "A-Z" "a-z" | grep -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-_\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" | sort | uniq > ./filter_allow.tmp && cat ./filter_adblock.tmp ./filter_domain.tmp ./filter_hosts.tmp ./filter_other.tmp ../data/data_block.txt | sed "s/[[:space:]]//g;s/0\.0\.0\.0//g;s/127\.0\.0\.1//g;s/\:\:1//g;s/\:\://g;s/DOMAIN\,//g;s/DOMAIN\-SUFFIX\,//g" | tr -d "^|" | tr "A-Z" "a-z" | grep -E "^(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-_\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$" | sort | uniq > ./filter_block.tmp && awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./filter_allow.tmp ./filter_block.tmp | sort | uniq | awk "{ print $2 }"))
}
# Generate Information
function GenerateInformation() {
    adfilter_checksum=$(date "+%s" | base64)
    adfilter_description="Filter composed of several other filters can block ads from websites (especially Chinese websites); it can also improve privacy and security. Hey buddy, enjoy your fantastic web surfing experience~"
    adfilter_expires="3 hours (update frequency)"
    adfilter_homepage="https://github.com/hezhijie0327/AdFilter"
    adfilter_timeupdated=$(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y-%m-%dT%H:%M:%S%:z")
    adfilter_title="Zhijie's Ad Filter"
    adfilter_total=$(awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./filter_allow.tmp ./filter_block.tmp | sort | uniq > ./checklist.tmp && sed -n '$=' ./checklist.tmp)
    adfilter_version=$(cat ../release.sh | grep "Current\ Version" | sed "s/\#\ Current\ Version\:\ //g")-$(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%Y%m%d")-$((10#$(date -d @$(echo "${adfilter_checksum}" | base64 -d) "+%H") / 3))
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
    function adfilter_adguardhome() {
        echo "! Checksum: ${adfilter_checksum}" > ../adfilter_adguardhome.txt
        echo "! Title: ${adfilter_title} for AdGuard Home (DNS-level)" >> ../adfilter_adguardhome.txt
        echo "! Description: ${adfilter_description}" >> ../adfilter_adguardhome.txt
        echo "! Version: ${adfilter_version}" >> ../adfilter_adguardhome.txt
        echo "! TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_adguardhome.txt
        echo "! Expires: ${adfilter_expires}" >> ../adfilter_adguardhome.txt
        echo "! Homepage: ${adfilter_homepage}" >> ../adfilter_adguardhome.txt
        echo "! Total: ${adfilter_total}" >> ../adfilter_adguardhome.txt
    }
    function adfilter_dnsmasq() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_dnsmasq.conf
        echo "# Title: ${adfilter_title} for Dnsmasq (DNS-level)" >> ../adfilter_dnsmasq.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_dnsmasq.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_dnsmasq.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_dnsmasq.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_dnsmasq.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_dnsmasq.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_dnsmasq.conf
    }
    function adfilter_domains() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_domains.txt
        echo "# Title: ${adfilter_title} for Pi-hole (DNS-level)" >> ../adfilter_domains.txt
        echo "# Description: ${adfilter_description}" >> ../adfilter_domains.txt
        echo "# Version: ${adfilter_version}" >> ../adfilter_domains.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_domains.txt
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_domains.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_domains.txt
        echo "# Total: ${adfilter_total}" >> ../adfilter_domains.txt
    }
    function adfilter_hosts() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_hosts.txt
        echo "# Title: ${adfilter_title} for AdAway (DNS-level)" >> ../adfilter_hosts.txt
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
        echo "# Title: ${adfilter_title} for SmartDNS (DNS-level)" >> ../adfilter_smartdns.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_smartdns.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_smartdns.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_smartdns.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_smartdns.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_smartdns.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_smartdns.conf
    }
    function adfilter_surge() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_surge.txt
        echo "# Title: ${adfilter_title} for Surge (DNS-level)" >> ../adfilter_surge.txt
        echo "# Description: ${adfilter_description}" >> ../adfilter_surge.txt
        echo "# Version: ${adfilter_version}" >> ../adfilter_surge.txt
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_surge.txt
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_surge.txt
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_surge.txt
        echo "# Total: ${adfilter_total}" >> ../adfilter_surge.txt
    }
    function adfilter_unbound() {
        echo "# Checksum: ${adfilter_checksum}" > ../adfilter_unbound.conf
        echo "# Title: ${adfilter_title} for Unbound (DNS-level)" >> ../adfilter_unbound.conf
        echo "# Description: ${adfilter_description}" >> ../adfilter_unbound.conf
        echo "# Version: ${adfilter_version}" >> ../adfilter_unbound.conf
        echo "# TimeUpdated: ${adfilter_timeupdated}" >> ../adfilter_unbound.conf
        echo "# Expires: ${adfilter_expires}" >> ../adfilter_unbound.conf
        echo "# Homepage: ${adfilter_homepage}" >> ../adfilter_unbound.conf
        echo "# Total: ${adfilter_total}" >> ../adfilter_unbound.conf
    }
    adfilter_adblock
    adfilter_adguardhome
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
            echo "||${filter_data[$filter_data_task]}^" >> ../adfilter_adblock.txt
            echo "|${filter_data[$filter_data_task]}^" >> ../adfilter_adguardhome.txt
            echo "address=/${filter_data[$filter_data_task]}/" >> ../adfilter_dnsmasq.conf
            echo "${filter_data[$filter_data_task]}" >> ../adfilter_domains.txt
            echo "0.0.0.0 ${filter_data[$filter_data_task]}" >> ../adfilter_hosts.txt
            echo ":: ${filter_data[$filter_data_task]}" >> ../adfilter_hosts.txt
            echo "address /${filter_data[$filter_data_task]}/#" >> ../adfilter_smartdns.conf
            echo "DOMAIN,${filter_data[$filter_data_task]}" >> ../adfilter_surge.txt
            echo "local-zone: \"${filter_data[$filter_data_task]}\" always_nxdomain" >> ../adfilter_unbound.conf
        done
        cd .. && rm -rf ./Temp
        exit 0
    else
        awk 'NR == FNR { tmp[$0] = 1 } NR > FNR { if ( tmp[$0] != 1 ) print }' ./filter_allow.tmp ./filter_block.tmp | sort | uniq > ./checklist.tmp
        cat ../adfilter_domains.txt | head -n $(sed -n '$=' ../adfilter_domains.txt) | tail -n +9 > ./checklist.old
        if [ "$(diff ./checklist.tmp ./checklist.old)" == "" ]; then
            cd .. && rm -rf ./Temp
            exit 0
        else
            GenerateInformation
            for filter_data_task in "${!filter_data[@]}"; do
                echo "||${filter_data[$filter_data_task]}^" >> ../adfilter_adblock.txt
                echo "|${filter_data[$filter_data_task]}^" >> ../adfilter_adguardhome.txt
                echo "address=/${filter_data[$filter_data_task]}/" >> ../adfilter_dnsmasq.conf
                echo "${filter_data[$filter_data_task]}" >> ../adfilter_domains.txt
                echo "0.0.0.0 ${filter_data[$filter_data_task]}" >> ../adfilter_hosts.txt
                echo ":: ${filter_data[$filter_data_task]}" >> ../adfilter_hosts.txt
                echo "address /${filter_data[$filter_data_task]}/#" >> ../adfilter_smartdns.conf
                echo "DOMAIN,${filter_data[$filter_data_task]}" >> ../adfilter_surge.txt
                echo "local-zone: \"${filter_data[$filter_data_task]}\" always_nxdomain" >> ../adfilter_unbound.conf
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
