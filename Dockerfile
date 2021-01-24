FROM alpine

#環境変数の初期値
ENV XTEVE_URL https://xteve.de/download/xteve_2_linux_amd64.zip
ENV XTEVE_PORT 34400
ENV XTEVE_CONFIG /app/xteve/config/

USER root
RUN echo 'root:root' |chpasswd && \
  mkdir /app && \
  adduser -S xteve -s "/bin/sh" && \
  echo "xteve ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo 'xteve:xteve' | chpasswd
WORKDIR /app/
RUN wget $XTEVE_URL -O xteve.zip && \
  unzip xteve.zip && \
  rm -rf xteve.zip && \
  chown xteve xteve && \
  chmod +x xteve
USER xteve
CMD ./xteve -port="${XTEVE_PORT}" -config="${XTEVE_CONFIG}"