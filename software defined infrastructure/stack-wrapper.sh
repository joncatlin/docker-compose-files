#!/bin/bash
# declare STRING variable

#echo $STRING
#echo $#
#echo $@
#echo "${@: -1}"
export stackname=${@: -1}
echo $stackname

# docker stack deply $@
