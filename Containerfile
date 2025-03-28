FROM docker.io/library/ubuntu:latest
RUN apt update && apt install --no-install-recommends -y vim
WORKDIR /outside
CMD [ "/usr/bin/vim" ]
