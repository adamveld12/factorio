FROM debian:jessie-slim

ARG VERSION=0.14.23

ENV FACTORIO_VERSION=$VERSION
ENV RCON_PASSWORD=factorio
ENV SAVE_FILE=factorio_save.zip

RUN apt-get update \
 && apt-get install -y curl tar \
 && apt-get clean \
 && mkdir -p /opt/factorio/config /opt/factorio/data /opt/factorio/mods /opt/factorio/saves /etc/factorio.d/ \
 && useradd -ms /bin/bash factorio \
 && chown -R factorio /opt/factorio

WORKDIR /etc/factorio.d

RUN curl -L https://www.factorio.com/get-download/${VERSION}/headless/linux64 | tar xz \
 && mv ./factorio/* /etc/factorio.d \
 && rm -rf ./factorio \
 && echo "config-path=/opt/factorio/config/" >> /etc/factorio.d/config-path.cfg \
 && chmod 775 -R /etc/factorio.d 

USER factorio
WORKDIR /opt/factorio
COPY ./ /opt/factorio/

VOLUME [ "/etc/factorio.d/data/", \
         "/opt/factorio/settings", \
         "/opt/factorio/mods", \
         "/opt/factorio/saves" ]

EXPOSE 3000 3001

ENTRYPOINT [ "/etc/factorio.d/bin/x64/factorio", \
             "--port=3000", \
             "--rcon-port=3001", \
             "--rcon-password=$RCON_PASSWORD", \
             "--mod-directory=/opt/factorio/mods", \
             "--config=/opt/factorio/config.ini", \
             "--server-settings=/opt/factorio/settings/server.json", \
             "--map-gen-settings=/opt/factorio/settings/map.json" ]

CMD [ "-v", "--start-server=/opt/factorio/saves/factorio_save.zip" ]
