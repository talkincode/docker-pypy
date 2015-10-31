FROM ubuntu:14.04
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN apt-get update  && \
    apt-get install -y  wget libffi-dev openssl openssl-dev git gcc tcpdump crontabs pypy && \
    pypy --version && \
    apt-get clean all

RUN mkdir /pysetup
RUN wget -P /pysetup http://python-distribute.org/distribute_setup.py
RUN wget -P /pysetup https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN pypy /pysetup/distribute_setup.py
RUN pypy /pysetup/get-pip.py
RUN rm -rf /pysetup
