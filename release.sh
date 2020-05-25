#!/bin/bash

VERSION=${1:-}

git archive --format zip --output "./releases/rules_jsweet-$VERSION.zip" master
