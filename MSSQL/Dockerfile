FROM mcr.microsoft.com/mssql/server:latest

RUN mkdir -p /usr/src/sql
RUN mkdir -p /usr/src/scripts
RUN mkdir -p /usr/src/output

COPY ./sql/ /usr/src/sql
COPY ./scripts/ /usr/src/scripts

RUN chmod +x /usr/src/scripts/entrypoint.sh
RUN chmod +x /usr/src/scripts/import-data.sh

EXPOSE 1433

CMD /bin/bash /usr/src/scripts/entrypoint.sh