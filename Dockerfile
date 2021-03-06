ARG BASE_IMAGE=node:11.14.0-alpine
FROM ${BASE_IMAGE}
LABEL maintainer="addressr@mountain-pass.com.au"
ARG USER=node
ARG PACKAGE
USER ${USER}

RUN mkdir -p "/home/${USER}/.npm"
RUN npm config set prefix "/home/${USER}/.npm"
RUN npm config get prefix
RUN npm install -g "${PACKAGE}"
ENV PATH="/home/${USER}/.npm/bin:$PATH"

ENV ELASTIC_PORT="9200"
ENV ELASTIC_HOST="host.docker.internal"
ENV ADDRESSR_INDEX_TIMEOUT="30s"
ENV ADDRESSR_INDEX_BACKOFF="1000"
ENV ADDRESSR_INDEX_BACKOFF_INCREMENT="1000"
ENV ADDRESSR_INDEX_BACKOFF_MAX="10000"

WORKDIR "/home/${USER}"

CMD "addressr-server"
