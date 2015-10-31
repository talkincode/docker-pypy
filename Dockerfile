FROM ubuntu:14.04
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN mkdir /pysetup
ADD distribute_setup.py /pysetup/distribute_setup.py

RUN apt-get update -y && \
    apt-get install -y  wget libffi-dev openssl libssl-dev git gcc tcpdump && \
    apt-get clean all

RUN cd /opt && wget https://bitbucket.org/pypy/pypy/downloads/pypy-4.0.0-linux64.tar.bz2 && \
    tar -xf pypy-4.0.0-linux64.tar.bz2 && \
    ln -s /opt/pypy-4.0.0-linux64/bin/pypy /usr/local/bin && \
    pypy --version

RUN wget -P /pysetup https://raw.github.com/pypa/pip/master/contrib/get-pip.py && \
    pypy /pysetup/distribute_setup.py && \
    pypy /pysetup/get-pip.py && \
    rm -rf /pysetup && \
    ln -s /opt/pypy-4.0.0-linux64/bin/pip /usr/local/bin
