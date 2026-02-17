/*research question: 1) what gene families/functions that are enriched in meta-trx in microbiome */
/* 2) in human, what functions are enriched + see if they reflect the microbiome and their health status*/

/* metadata*/
proc import datafile="/home/u64408470/hmp2_metadata_2018-08-20.csv"
  out=metadata
  dbms=csv
  replace;
  getnames=yes; /*use first row as variable names*/
run;

/* host transcriptomics*/
proc import datafile="/home/u64408470/host_tx_counts.tsv"
  out=host_tx
  dbms=dlm
  replace;
  getnames=yes;
run;

/*pathway abundance of microbiome */
proc import datafile="/home/u64408470/pathabundance_relab.tsv"
  out=pw_abd
  dbms=dlm
  replace;
  getnames=yes;
run;
