FROM debian:bullseye-slim

LABEL version="0.1"
LABEL maintainer="Ash Bellett <ash.bellett.ab@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
	&& apt-get install -yqq --no-install-recommends \
        ca-certificates \
        git \
		locales \
		wget

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen \
	&& /usr/sbin/update-locale

RUN apt-get update \
    && apt-get install -yqq --no-install-recommends \
		r-base \
		r-base-dev \
        r-base-core \
		r-recommended

RUN rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*

WORKDIR /home

COPY . .

RUN ./scripts/install.sh

CMD ["/bin/bash", "./scripts/run.sh"]
