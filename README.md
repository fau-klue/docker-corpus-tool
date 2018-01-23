# Corpus Tools Docker Image

Docker Images for the IMS Open Corpus Workbench and UCS Toolkit.

## CWB
The IMS Open Corpus Workbench (CWB) is a collection of open-source tools for managing and querying large text corpora.

http://cwb.sourceforge.net/

## UCS
The UCS toolkit is a collection of libraries and scripts for the statistical analysis of cooccurrence data.

http://www.collocations.de/software.html

# Building the Images

How to build the images:
```
# Corpus Workbench
docker build -t cwb -f cwb/Dockerfile .

# UCS toolkit
docker build -t ucs -f ucs/Dockerfile .

# Corpus Workbench and CUCS toolkit
docker build -t cwb-ucs -f cwb-ucs/Dockerfile .
```

# Using the Images

To run the containers:
```
docker run -ti cwb
docker run -ti ucs
docker run -ti cwb-ucs
```

Mounting a volume for persistent storage:
```
docker run -ti cwb -v /home/yourname/data:/data
```
