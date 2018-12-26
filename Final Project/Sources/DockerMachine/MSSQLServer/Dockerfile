FROM mcr.microsoft.com/mssql/server:latest

RUN mkdir -p /usr/src/scripts
RUN mkdir -p /usr/src/output
RUN mkdir -p /usr/src/data

RUN apt update && apt install php7.0 php7.0-mbstring -y

COPY ./scripts/ /usr/src/scripts

RUN chmod +x /usr/src/scripts/entrypoint.sh
RUN chmod +x /usr/src/scripts/run.sh

EXPOSE 1433

CMD /bin/bash /usr/src/scripts/entrypoint.sh