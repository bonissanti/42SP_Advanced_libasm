FROM ubuntu:latest
LABEL authors="brunrodr"

RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    libcriterion-dev