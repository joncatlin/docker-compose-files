# Pentaho Server

## Description
This image is for the Pentaho server and is a part of a client server setup. The server image runs a Pentaho Data Integration server. It is heavily based on the work done for the bretif/pentaho:8.2 image on Docker Hub.

## Build
```
$ docker build -t joncatlin/pentaho-di .
```
## Run
```
$ docker-compose up -d
```
## Pre-requisites
None.
## Volumes
Three mount points are provided and named as follows
1. Input - map this to the input directory 
2. Output - map this to the directory where results should be placed
3. Processed - map this to a directory to place all files that have been processed