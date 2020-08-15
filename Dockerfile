FROM jupyter/base-notebook

ARG NB_UID
ENV uid=${NB_UID}
RUN echo ${uid}

USER root
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:longsleep/golang-backports && apt-get update
RUN apt-get install -y make cargo clang ghc golang-1.15 && apt-get upgrade -y

RUN echo "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/go-1.15/bin/go\"" > /etc/environment

USER $NB_UID
RUN pip install pandas tqdm matplotlib

RUN mkdir ~/tmp && touch ~/tmp/zero