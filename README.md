# Code description

This code allows you to load, tidy, compute and write the resultant data from the raw data from the UCI
HAR Dataset. To use the file, source the file and use the `writeAverages` function, passing the directory containing the data set as first argument, and the output file as the second, as follows:

```r
source("run_analysis.R")
writeAverages("UCI HAR Dataset", "data.txt")
```
