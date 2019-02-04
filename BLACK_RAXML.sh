#!/bin/sh

##############################################
# Name: BLACK_RAXML.sh
#
# Phylogenetic analysis of large datasets under maximum likelihood
# Usage: run_script BLACK_RAXML.sh # on AL Supercomputer
#
# Author: C. Black
# Date: 19Jan2019
##############################################

# Find and Load RAxML
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load raxml/8.0.24

# RAxML should be compiled already, but if not, un-hash following steps
	 make -f Makefile.gcc #generates a binary called raxmlHPC
	 rm *.o
	 make -f Makefile.SSE3.gcc #generates a binary called raxmlHPC-SSE3, this is also a sequential version of RAxML that however exploits a type of very fine-grain parallelism in the processor. See here for more information on SSE3 and vector instructions.
	 rm *.o
	 make -f Makefile.PTHREADS.gcc #generates a binary called raxmlHPC-PTHREADS that can run in parallel on several cores that share the same memory (that's the case on all common multi-core desktop and laptop computers). Pthreads are a library for generating and managing a specific sort of leight-weight processes which are called threads.  
	 rm *.o
	 make -f Makefile.SSE3.PTHREADS.gcc 

# raxmlHPC -h ## for help with available commands


# Conduct multiple searches for the best tree
	## Input: binary.phy; Output: RAxML_result.T1 
	## -m: BINGAMMA for binary data (BIN) with the GAMMA (GAMMA) model of rate heterogeneity
	## ­p: parsimonyRandomSeed - Make sure to pass different random number seeds to RAxML and not just 12345
	## ­s: sequenceFileName
	## -n: adds "T1" to the end of the results file
			### Change "T1" to something different (i.e. "T2") for each to avoid overwriting files
	## ­#|­N Specify the number of alternative runs on distinct starting trees
	## ­b bootstrapRandomNumberSeed: turns on bootstrapping 

raxmlHPC -m BINGAMMA -p 42531 -b 42531 -s binary.phy ­N 200 -n T8 ##required: -s -n -m -p
