FROM alpine

#環境変数の初期値
ENV XTEVE_PORT 34400
ENV XTEVE_CONFIG /app/xteve/config/

USER root
RUN echo 'root:root' |chpasswd && \
  mkdir /app && \
  adduser -S xteve -s "/bin/sh" && \
  echo "xteve ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  echo 'xteve:xteve' | chpasswd
COPY ./xteve_linux_amd64/ /app/xteve_linux_amd64/
WORKDIR /app/xteve_linux_amd64
RUN chown xteve xteve && \
  chmod +x xteve

USER xteve
CMD ./xteve -port="${XTEVE_PORT}" -config="${XTEVE_CONFIG}"