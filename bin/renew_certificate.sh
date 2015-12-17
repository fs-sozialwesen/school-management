#!/usr/bin/env bash

sudo service nginx stop
~/src/letsencrypt/letsencrypt-auto certonly --standalone --standalone-supported-challenges http-01 -d www.fs-sozialwesen.de -d fs-sozialwesen.de
sudo service nginx start
