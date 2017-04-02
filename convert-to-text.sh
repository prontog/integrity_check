#!/usr/bin/env bash

if [[ $# == 0 ]]; then
	echo "Usage: ${0##*/} PDF_FILE..."
	exit 1
fi

echo "Converting PDF file\(s\) to txt..."
while [[ $# != 0 ]]; do
	PDF_FILE=$1
	if [[ -f $PDF_FILE ]]; then
		echo $PDF_FILE
		pdftotext -raw $PDF_FILE
	else
		echo "not a file: $PDF_FILE"
	fi
	shift
done

