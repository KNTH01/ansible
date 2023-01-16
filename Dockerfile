FROM ubuntu:latest as base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo && \
    apt-get install -y vim && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS me
ARG TAGS
RUN useradd -ms /bin/bash knth
RUN usermod -aG sudo knth
RUN echo "knth ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER knth
WORKDIR /home/knth

FROM me
COPY . .
# CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]
