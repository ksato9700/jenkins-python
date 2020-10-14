FROM jenkins/jenkins:lts-slim
USER root
ARG UID=10000
ARG GID=10000
RUN userdel jenkins \
    && chown ${UID}:${GID} $JENKINS_HOME \
    && groupadd -g ${GID} jenkins \
    && useradd -u ${UID} -g ${GID} -m -s /bin/bash jenkins
RUN apt-get update \
    && apt-get install -y pipenv libcurl4-openssl-dev libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev libgdbm-dev libbz2-dev liblzma-dev zlib1g-dev uuid-dev libffi-dev libdb-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER jenkins
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile \
    && echo 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
WORKDIR /home/jenkins
SHELL ["/bin/bash", "-c"]
RUN source ~/.bash_profile \
    && pyenv install 3.8.1
