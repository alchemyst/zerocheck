# https://pythonspeed.com/articles/alpine-docker-python/
FROM python:slim

WORKDIR /usr/src/zerocheck

RUN apt update && apt install -y make cargo clang ghc

RUN pip install pandas tqdm

RUN mkdir ~/tmp && touch /tmp/zero

CMD ["make bench"]