FROM jupyter/base-notebook

ARG NB_USER
ARG NB_UID
ARG NB_GID

USER root
RUN apt-get update && apt-get install -y gpg
# .NET Core
RUN wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list
# Now Get!
RUN apt-get update && apt-get install -y software-properties-common apt-transport-https
RUN add-apt-repository ppa:longsleep/golang-backports && apt-get update
RUN apt-get install -y make cargo clang ghc dotnet-sdk-3.1 golang-1.15 && apt-get upgrade -y

USER $NB_UID
# Swift
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
RUN wget https://swift.org/builds/swift-5.2.5-release/ubuntu2004/swift-5.2.5-RELEASE/swift-5.2.5-RELEASE-ubuntu20.04.tar.gz
RUN wget https://swift.org/builds/swift-5.2.5-release/ubuntu2004/swift-5.2.5-RELEASE/swift-5.2.5-RELEASE-ubuntu20.04.tar.gz.sig
RUN gpg --verify swift-5.2.5-RELEASE-ubuntu20.04.tar.gz.sig
RUN tar xzf swift-5.2.5-RELEASE-ubuntu20.04.tar.gz
# Python & Jupyter
RUN pip install pandas tqdm matplotlib

ENV PATH /usr/lib/go-1.15/bin:$HOME/swift-5.2.5-RELEASE-ubuntu20.04/usr/bin:$PATH