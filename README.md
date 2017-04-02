# integrity_check
An attempt to check the integrity of public...

Monitors diavgeia.gov.gr for new "decisions", checks their integrity and publishes the results on a twitter account.

Created during the [Public Integrity Hackathon](http://www.oecd.org/gov/ethics/public-integrity-hackathon.htm) organized by OECD.

## Prerequisites

- bash
- cURL
- pdftotext
- python

## Downloading PDFs from diavgeia.gov.gr

Use `download-from-diavgeia.sh` bash script to download the PDF files using the diavgeia.gov.gr API. The PDF are saved in directory *out* and are organized by *organization*.

So far it downloads all files returned by the *luminapi* of diavgeia.gov.gr.

```
./download-from-diavgeia.sh
```

## Converting PDF files to text

Convertion of the PDF files to text is done using the *pdftotext* application.

```
find out/ -name '*.pdf' -exec pdftotext -raw {} \;
```

## Posting to twitter

1. Install the [python-twitter](https://github.com/bear/python-twitter) module
1. Create a Twitter account
1. Create a Twitter app with an authentication token
1. Create a .tweetrc file and add the following:
    ```
    [Tweet]
    consumer_key: *consumer_key*
    consumer_secret: *consumer_password*
    access_key: *access_key*
    access_secret: *access_password*
    ```
1. Use tweet.py to post messages!

```
./tweet.py "Integrity-check results: blah blah"
```
