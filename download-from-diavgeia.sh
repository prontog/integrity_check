#!/usr/bin/env bash

URL='https://diavgeia.gov.gr/luminapi/api/search/export?q=decisionType:%22%CE%A0%CE%A1%CE%9F%CE%9A%CE%97%CE%A1%CE%A5%CE%9E%CE%97%20%CE%A0%CE%9B%CE%97%CE%A1%CE%A9%CE%A3%CE%97%CE%A3%20%CE%98%CE%95%CE%A3%CE%95%CE%A9%CE%9D%22&wt=json&sort=recent&page=0'

OUT_DIR=out
API_RESPONSE=$OUT_DIR/res.json
mkdir -p $OUT_DIR

echo Querying luminapi...
curl $URL | jq '.' > $API_RESPONSE

echo Downloading PDF files...
jq -r '.decisionResultList[] | "\(.ada) \(.documentUrl) \(.organizationLabel)"'  $API_RESPONSE | while read ada url org; do
	if [[ $url == "" ]]; then
		echo decision with ada "$ada" and org "$org" has an empty documentUrl
	else
		ORG_DIR=$OUT_DIR/$(echo $org | sed 's/"//g; s/ /_/g; s/\//-/g;')
		FILENAME=${url##*/}.pdf
		if [[ ! -f $ORG_DIR/$FILENAME  ]]; then
			mkdir -p $ORG_DIR
			echo $url
			curl -s $url -o $ORG_DIR/$FILENAME
		fi
	fi
done
