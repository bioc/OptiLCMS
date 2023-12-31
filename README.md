# OptiLCMS

### Introduction

**OptiLCMS** is an R package providing an optimized LC-MS raw data processing workflow. The source code of the "MS Spectral Processing" Module in [MetaboAnalyst](https://dev.metaboanalyst.ca/MetaboAnalyst/upload/SpectraUpload.xhtml) is contained here. OptiLCMS can be used to repeat the results generated by MetaboAnalyst at local, and is also optionally dependent by MetaboAnalystR to 


### Installation

There are 3 typical approaches provided for users to install this package as below.

#### (a.) Install devlopement (beta) version

```R
# Latest features could only be obtained from this approach, make sure 'devtools' installed first
devtools::install_github("xia-lab/OptiLCMS", build = TRUE, build_vignettes = FALSE, build_manual =TRUE)

```

#### (b.) Install from the local R tar package

Download the latest version from the following Options:

1. Local version ([v0.99.7](https://drive.google.com/file/d/19CBsJQnvdmhK7WrAk3SqPH8GwRMn5TT_/view?usp=sharing));

2. Web version ([v0.99.8](https://drive.google.com/file/d/1nayoRQxk0Xpn66_dC_gyGsJM28T0mHwZ/view?usp=sharing));

Download the packages above (Recommending Option 1 for local use) and run the following command in R terminal. 

**NOTE:** option 2 (web version) is used by our website and highly synchronized with the local version.

```R
# Remember to replace the PATH_TO_TAR as the right path of your downloaded package (OptiLCMS_0.99.x.tar.gz).
install.packages(PATH_TO_TAR, repos = NULL, type="source")

```


#### (c.) Install from Bioconductor (available soon)

```R
# Install from Bioconductor repository, Please make sure 'Bioconductor' has been installed first
BiocManager::install("OptiLCMS")

```

### Tutorial

A step-by-step tutorial will be prepared for users to start their analysis by following them (available soon).

### Citation

OptiLCMS package has been developed by the [XiaLab](https://www.xialab.ca/) at McGill University. If you use the R package, please cite us: 

* Pang, Z., Chong, J., Li, S. and Xia, J. (2020) MetaboAnalystR 3.0: Toward an Optimized Workflow for Global Metabolomics. Metabolites 10(5) 186 [link](https://doi.org/10.3390/metabo10050186)

*From within R:*

```R
citation("OptiLCMS")
```

### New features requests & Bugs reports

To inform us of any bugs or requests, please open a new issue (and @ Zhiqiang-PANG !!) or send an email to zhiqiang.pang@mail.mcgill.ca.





