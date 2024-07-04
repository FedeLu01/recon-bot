#!/bin/bash

DOMAIN=$1

if [[ -z $DOMAIN ]]; then
    mkdir /opt/bounty/"$DOMAIN" && cd /opt/bounty/"$DOMAIN" && touch /opt/bounty/"$DOMAIN"/resolvedDomains.txt && touch /opt/bounty/"$DOMAIN"/webservers.txt && touch /opt/bounty/"$DOMAIN"/openports.txt 

    while true; do
        echo "Recon for $DOMAIN:"
        domain-recon -d $DOMAIN --domains-only | dnsx -silent > /opt/bounty/"$DOMAIN"/resolvedDomains.txt | anew -q /opt/bounty/"$DOMAIN"/resolvedDomains.txt
        httpx -l /opt/bounty/"$DOMAIN"/resolvedDomains.txt -t 10 -silent > /opt/bounty/"$DOMAIN"/webservers.txt | anew /opt/bounty/"$DOMAIN"/webservers.txt | notify -silent -bulk
        smap -iL /opt/bounty/"$DOMAIN"/resolvedDomains.txt | anew /opt/bounty/"$DOMAIN"/openports.txt 
        sleep 3600
    done
else
    echo "error" | notify -silent

fi

