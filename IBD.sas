/*research question: 1) what gene families/functions that are enriched in meta-trx in microbiome */
/* 2) in human, what functions are enriched + see if they reflect the microbiome and their health status*/

/* metadata*/
proc import datafile="/home/u64408470/hmp2_metadata_2018-08-20.csv"
  out=metadata
  dbms=csv
  replace;
  getnames=yes; /*use first row as variable names*/
run;

/* ================= host transcriptomics ================*/
proc import datafile="/home/u64408470/host_tx_counts.tsv"
  out=host_tx
  dbms=dlm
  replace;
  delimiter='09'x; /* Specifies Tab delimiter */
  getnames=yes;    /* Uses first row for headers */
  guessingrows=32767; /* Scans data for accurate types */
run;


/* -- save this to lib so it wont have to reload everytime */
libname mylib "/home/u64408470/sasuser.v94/out"; /*define a location to save*/

data mylib.host_tx;    /* Make a permanent copy of work.host_tx and save it on disk as mylib.host_tx */
    set work.host_tx;
run;

data mylib.metadata;   /*make a copy of work.metadata & save it on disk */
    set work.metadata;
run;

/* ============= RUN THIS SO DONT HAVE TO RELOAD DATA for host_tx and metadata ========= */
libname mylib "/home/u64408470/sasuser.v94/out"; /*set the saving lib dir */
proc contents data=mylib.host_tx;
run;

proc contents data=mylib.metadata;
run;

/* -- run diagnosis on the dataset */
proc contents data=host_tx varnum; /* print out number of variables */
run;

proc contents data=host_tx;        /*Getting a detailed report of names, types, and labels */
run; 

proc print data=host_tx;
   var transcript;
run;

/* -- separate host subj to case/ctrl*/
proc contents data=metadata; /* metadata deep dive */
run;

proc print data=metadata;
  var diagnosis 'External ID'n data_type;
run;


/* ================= pathway abundance of microbiome  ================= */
proc import datafile="/home/u64408470/pathabundance_relab.tsv"
  out=pw_abd
  dbms=dlm
  replace;
  getnames=yes;
run;

