#!/bin/bash
#Script that converts all *.ws files in solution to UTF8 for proper diff compatibility on github

find "./mods/modW3ReduxAPI" -name "*.ws" -exec sh -c "echo {}; iconv -f UTF-16 -t UTF-8 {} > {}.temp; mv {}.temp {}" \;