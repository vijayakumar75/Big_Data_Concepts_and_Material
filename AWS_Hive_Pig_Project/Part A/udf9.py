#!/usr/bin/python

from pig_util import outputSchema
import re

@outputSchema("out:int")
def polirevVal(date_string):
	txt = date_string
	
	re1='((?:(?:[1]{1}\\d{1}\\d{1}\\d{1})|(?:[2]{1}\\d{3}))[-:\\/.](?:[0]?[1-9]|[1][012])[-:\\/.](?:(?:[0-2]?\\d{1})|(?:[3][01]{1})))(?![\\d])'	# YYYYMMDD 1
	re2='.*?'	# Non-greedy match on filler
	re3='((?:(?:[0-2]?\\d{1})|(?:[3][01]{1})))(?![\\d])'	# Day 1

	rg = re.compile(re1+re2+re3,re.IGNORECASE|re.DOTALL)
	m = rg.search(txt)
	if m:
		yyyymmdd1=m.group(1)
		day1=m.group(2)
		return(int(day1))
	

