#!/bin/bash
quarto render
rm -rf output/*
mv -f docs/* output
echo "Done. Files available on host at ./docker/docs and ./docker/figures"