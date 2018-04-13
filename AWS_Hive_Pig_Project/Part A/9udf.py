#!/usr/bin/python

from pig_util import outputSchema
import re

@outputSchema("out:int")
def polirevVal(date_string):

txt=date_string

re1='.*?'	# Non-greedy match on filler
re2='\\d+'	# Uninteresting: int
re3='.*?'	# Non-greedy match on filler
re4='\\d+'	# Uninteresting: int
re5='.*?'	# Non-greedy match on filler
re6='\\d+'	# Uninteresting: int
re7='.*?'	# Non-greedy match on filler
re8='(\\d+)'	# Integer Number 1

rg = re.compile(re1+re2+re3+re4+re5+re6+re7+re8,re.IGNORECASE|re.DOTALL)
m = rg.search(txt)
if m:
    int1=m.group(1)
    return "("+int1+")"+"\n"



