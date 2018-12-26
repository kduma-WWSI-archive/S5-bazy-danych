FROM mcr.microsoft.com/mssql/server:latest

RUN mkdir -p /usr/src/scripts
RUN mkdir -p /usr/src/output
RUN mkdir -p /usr/src/data

COPY ./scripts/ /usr/src/scripts

RUN chmod +x /usr/src/scripts/entrypoint.sh
RUN chmod +x /usr/src/scripts/run.sh

EXPOSE 1433

CMD /bin/bash /usr/src/scripts/entrypoint.sh