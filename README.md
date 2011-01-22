# gdownload #

gdownload is a simple CLI to download attachments from a gmail account.
The emails are selected by label name.

## Install ##

    $ gem install gmail
    $ git clone git@github.com:mathieul/gdownload.git
    $ cd gdownload

## Syntax ##

Usage:
  thor gdownload:download LABEL -p, --password=PASSWORD -u, --user=USER

Options:
  -u, --user=USER
  -p, --password=PASSWORD
  -a, [--after=AFTER]

download all attachments from labeled emails from your Gmail account.

## Examples ##

Download all attachments from emails labeled as **download\_me** to *./download/*:

    $ thor download\_me gdownload:download -u my_account -u secret

Same thing but for email received after November 11th 2011:

    $ thor download\_me gdownload:download -u my_account -u secret -a "11 Nov 2011"

