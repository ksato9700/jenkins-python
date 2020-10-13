FROM jenkins/jenkins:lts-slim
USER root
ARG UID=10000
ARG GID=10000
RUN userdel jenkins \
    && chown ${UID}:${GID} $JENKINS_HOME \
    && groupadd -g ${GID} jenkins \
    && useradd -d "$JENKINS_HOME" -u ${UID} -g ${GID} -s /bin/bash jenkins
RUN apt-get update \
    && apt-get install -y pipenv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER jenkins
