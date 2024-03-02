FROM opensuse/tumbleweed:latest

RUN zypper --non-interactive refresh \
    && zypper --non-interactive install make

WORKDIR /project
VOLUME /project
