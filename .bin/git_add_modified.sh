#!/bin/sh


git status -uno | grep modified  | sed -e 's/^.*modified://g' | xargs git add
