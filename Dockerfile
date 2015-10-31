FROM centos:centos7
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN yum update -y

RUN yum install -y  wget libffi-devel \
    openssl openssl-devel zlib git gcc tcpdump \
    crontabs python-devel python-setuptools

RUN yum clean all

ADD pypy-4.0.0-linux64.tar.bz2 /opt/pypy-4.0.0-linux64.tar.bz2


RUN tar -xf pypy-1.8-linux64.tar.bz2 && \
    ln -s /opt/pypy-4.0.0-linux64/bin/pypy /usr/local/bin && \
    pypy --version

RUN curl -O http://python-distribute.org/distribute_setup.py && \
    curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py && \
    pypy distribute_setup.py && \
    pypy get-pip.py && \
    rm -f get-pip.py && \
    rm -f distribute_setup.py && \
    ln -s /opt/pypy-4.0.0-linux64/bin/pip /usr/local/bin
