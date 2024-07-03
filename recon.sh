#!/bin/bash

if [[ -d $DOMAIN ]]; then
    echo "Recon for $DOMAIN:"
    mkdir $DOMAIN | domain-recon -d $DOMAIN --domains-only | dnsx -silent > "$DOMAIN\_resolvedDomains.txt" | anew -q "$DOMAIN\_resolvedDomains.txt"
    httpx -l "resolvedDomains.txt" -t 10 -silent > "$DOMAIN\_webservers.txt" | anew "$DOMAIN\_webservers.txt" | notify -silent -bulk
    smap -iL "$DOMAIN\_resolvedDomains.txt" | anew "$DOMAIN\_openports.txt" 

else
    echo "error" | notify -silent -bulk

fi

