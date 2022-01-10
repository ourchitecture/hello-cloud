#!/bin/sh

chown -R pptruser:pptruser /app

exec runuser -u pptruser "$@"
