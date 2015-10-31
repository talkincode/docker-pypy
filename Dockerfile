FROM ubuntu:14.04
MAINTAINER jamiesun <jamiesun.net@gmail.com>

RUN mkdir /pysetup
ADD get-pip.py /pysetup/get-pip.py
ADD distribute-0.7.3.zip /pysetup/distribute-0.7.3.zip

RUN apt-get update -y && \
    apt-get install -y  wget zip libffi-dev openssl libssl-dev git gcc tcpdump && \
    apt-get clean all

RUN cd /opt && wget https://bitbucket.org/pypy/pypy/downloads/pypy-4.0.0-linux64.tar.bz2 && \
    tar -xf pypy-4.0.0-linux64.tar.bz2 && \
    ln -s /opt/pypy-4.0.0-linux64/bin/pypy /usr/local/bin && \
    pypy --version

RUN cd /pysetup && unzip distribute-0.7.3.zip && cd distribute-0.7.3 && pypy setup.py install

RUN pypy /pysetup/get-pip.py && ln -s /opt/pypy-4.0.0-linux64/bin/pip /usr/local/bin

RUN rm -rf /pysetup

RUN pypy -m pip install  --upgrade setuptools

RUN pypy -m pip install  supervisor

RUN ln -s /opt/pypy-4.0.0-linux64/bin/supervisord /usr/local/bin && \
    ln -s /opt/pypy-4.0.0-linux64/bin/supervisorctl /usr/local/bin
