FROM bioconductor/release_base

## Remain current
RUN apt-get update -qq \
	&& apt-get dist-upgrade -y

## Intall build dependencies
RUN apt-get update -qq \
	&& apt-get install  -y  \
    	curl \
    	netcdf-bin \
	    libnetcdf-dev 
	    
## Check free memory on build host to troubleshoot build errors
RUN free -m && free -mh
  
# Setup default cran repo
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

# This installs other R packages under Bioconductor
RUN Rscript -e "source('http://bioconductor.org/biocLite.R'); biocLite('mzR')"

CMD "/bin/bash

