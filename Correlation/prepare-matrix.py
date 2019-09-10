#!/usr/bin/env python

# 12/22/16
# to assign 0 to those species that are not mapped


from sys import *

Refer=open(argv[1], "r");
rf=Refer.readlines();
Refer.close();
Input=open(argv[2], "r");
infile = Input.readlines();
Input.close();
outfile=open(argv[3],"w+");

gene='';
log='';
gene_1='';
log_1='';
gene_2='';
lists=[];


for j in range(len(rf)):
	y=rf[j];
	eachline=y.split();
	gene_2=eachline[0];
	for i in range(len(infile)):
		x=infile[i];
		line1=x.split();
		gene_1=line1[0];
		log_1=line1[1];
		if gene_2==gene_1:
			gene=gene_1;
			log=log_1;
			break;
		else:
			gene=gene_2;
			log=0;
	print >>outfile, gene,log;
outfile.close();