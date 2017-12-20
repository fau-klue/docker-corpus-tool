# Corpus Workbench Docker Image

The IMS Open Corpus Workbench (CWB) is a collection of open-source tools for managing and querying large text corpora.

http://cwb.sourceforge.net/

## Build Image

```
docker build -t cwb .
```

## Usage

To start the Corpus Workbench container:

```
docker run cwb bash
```

To mount corpus data into the container:

```
docker run cwb -v /mycorpusdata:/var/cwb bash
```
