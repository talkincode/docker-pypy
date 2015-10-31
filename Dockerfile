FROM ubuntu:14.04
MAINTAINER jamiesun <jamiesun.net@gmail.com>



RUN apt-get update -y && \
    apt-get install -y  wget libffi-dev openssl libssl-dev git gcc tcpdump pypy && \
    pypy --version && \
    apt-get clean all

RUN mkdir /pysetup
ADD distribute_setup.py /pysetup/distribute_setup.py
RUN wget -P /pysetup https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN pypy /pysetup/distribute_setup.py
RUN pypy /pysetup/get-pip.py
RUN rm -rf /pysetup
