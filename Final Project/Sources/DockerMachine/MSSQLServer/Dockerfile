FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

RUN mkdir -p /usr/src/scripts
RUN mkdir -p /usr/src/output
RUN mkdir -p /usr/src/data

RUN apt update && apt install php7.0 php7.0-mbstring -y
RUN apt install texlive-math-extra -y \
	&& apt install texlive-latex-extra-doc -y \
	&& apt install texlive-latex-extra -y \
	&& apt install texlive-lang-polish -y \
	&& apt install texlive-fonts-recommended -y \
	&& apt install xzdec -y
	
RUN cd ~; \
	mkdir ~/texmf; \
	tlmgr init-usertree; \
	tlmgr option repository ftp://tug.org/historic/systems/texlive/2015/tlnet-final \
	tlmgr update;
	
RUN tlmgr install listings

COPY ./scripts/ /usr/src/scripts

RUN chmod +x /usr/src/scripts/entrypoint.sh
RUN chmod +x /usr/src/scripts/run.sh

EXPOSE 1433

CMD /bin/bash /usr/src/scripts/entrypoint.sh