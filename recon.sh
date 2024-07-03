#!/bin/bash

if [[ -z $DOMAIN ]]; then
    mkdir $DOMAIN && cd $DOMAIN && touch "$DOMAIN"_resolvedDomains.txt && touch "$DOMAIN"_webservers.txt && touch "$DOMAIN"_openports.txt 

    while true; do
        echo "Recon for $DOMAIN:"
        mkdir $DOMAIN | domain-recon -d $DOMAIN --domains-only | dnsx -silent > "$DOMAIN"_resolvedDomains.txt | anew -q "$DOMAIN"_resolvedDomains.txt
        httpx -l "$DOMAIN"_resolvedDomains.txt -t 10 -silent > "$DOMAIN"_webservers.txt | anew "$DOMAIN"_webservers.txt | notify -silent -bulk
        smap -iL "$DOMAIN"_resolvedDomains.txt | anew "$DOMAIN"_openports.txt 
    done
else
    echo "error" | notify -silent -bulk

fi

