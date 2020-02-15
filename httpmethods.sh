#!/bin/bash

for METHOD in GET POST PUT TRACE CONNECT OPTIONS PROPFIND;

do
printf "$METHOD " ;
printf "$METHOD / HTTP/1.1\nHost: $1\n\n" | nc -q 1 $1 80 | grep "HTTP/1.1"

done