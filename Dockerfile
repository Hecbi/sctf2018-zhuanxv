FROM aallam/tomcat-mysql

RUN set -ex \
    && rm -rf /opt/tomcat/webapps/* \
    && chmod a+x /opt/tomcat/bin/*.sh

COPY sctf.war /opt/tomcat/webapps/ROOT.war
COPY sctf.sql /home/sctf.sql
COPY init.sh /home/init.sh

RUN chmod +x /home/init.sh

EXPOSE 8080
