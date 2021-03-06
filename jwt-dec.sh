#!/usr/bin/env bash

#
# jwt-dec.sh <jwt>
#
secret='SECRETS HERE COME PUT YOUR SECRETS HERE'

# `tr` URLencodes output from base64
b64Enc()
{
	declare input=${1:-$(</dev/stdin)}
	printf '%s' "${input}" | base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}

# b64 string must be `n % 4 == 0`
# make b64string URL-safe when creating JWT -> removing '=' padding
# reformat to standards-compliant len
b64Dec()
{
	declare input=${1:-$(</dev/stdin)}
	remainder=$((${#input} % 4));
	if [ $remainder -eq 1 ];
	then
		>2& echo "ERROR: len unexpected, invalid base64"
	elif [[ $remainder -eq 2 || $remainder -eq 3 ]];
	then
		input="${input}$(for i in `seq $((4 - $remainder))`; do printf =; done)"
	fi
	echo "$input" | base64 -d
}

verSig()
{
	declare header_and_payload=${1}
	expected=$(echo "${header_and_payload}" | hs256Enc | b64Enc)
	actual=${2}
	if [ "${expected}" != "${actual}" ]
	then
		echo "invalid signature"
	fi
}

hs256Enc()
{
	declare input=${1:-$(</dev/stdin)}
	printf '%s' "${input}" | openssl dgst -binary -sha256 -hmac "${secret}"
}

# define jwt -eq stdin
declare token=${1:-$(</dev/stdin)};
IFS='.' read -ra part <<< "$token"

declare header=${part[0]}
declare payload=${part[1]}
declare sig=${part[2]}

echo "Header: "
echo "${header}" | b64Dec | jq
echo "Payload: "
echo "${payload}" | b64Dec | jq

verSig "${header}.${payload}" "${sig}"