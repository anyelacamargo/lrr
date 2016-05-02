readMatrix = function(filename)
{
  m = read.table(filename, header=T, sep='\t');
  return(n);
}

performSearch = function(m, lrr)
{
  j = c();
  for(cn in colnames(m)[2:57])
  {
    h = c()
    for(genename in lrr$genename)
    {
      #print(genename)
      i = grep(genename, m[,1]);
      if(length(i) > 0)
      {
        h[[genename]] = m[[cn]][i];
      }
      else
      {
        h[[genename]] = 0;
      }
    }
    j = cbind(j,h)
  }
  j = data.frame(j);j
  colnames(j) = colnames(m)[2:57];
  return(j)
}

readLRR = function(filename)
{
  lrr= read.table(filename, header=T)
  return(lrr)
  
}


countHits = function(d)
{
  i = which(as.numeric(d) != 0)
  return(length(i))
  
}

readBlastProt = function(filename, thr)
{
  rb = read.table(filename, header=T, sep='\t')
  i = which(rb$evalue < thr)
  rb = rb[i, c(-1,-2,-3,-4)];
  return(rb)
}


k = j;
k = data.frame(k, u=apply(j, 1,function(x) countHits(x)))

m = readMatrix('pangenome_matrix_t0_nr_t1_l60_C75_S95_ref_c30_s30.annot.tr.tab');
lrr = readLRR('178_NBSLRR_genes.csv');
j = performSearch(m, lrr);
j = data.frame(j, score=apply(j, 1,function(x) countHits(x)));
write.table(j, file='matrixLLR50Genome.csv', sep=',', quote = F, row.names=TRUE);


rb = readBlastProt('blastlrrprot3.out');
