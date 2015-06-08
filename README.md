# Cassandra on Ubuntu

This is derived from the official Docker cassandra image except it is based on the phusion base image.  As usual with my docker repos, I'm using a branch per tag and forcing people to be explicit about what tag they are using.  In the master branch, there are no files.  Please switch to a branch to see how it is built.

Here's how I'm running the image:

    docker run -p 9042:9042 -p 9160:9160 -d zmre/cassandra-ubuntu:2.1.5

Please see the official docker repo instructions on how to use the image for anything fancier: https://registry.hub.docker.com/_/cassandra/

