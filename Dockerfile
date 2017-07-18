FROM fabric8/java-centos-openjdk8-jdk

MAINTAINER wguo <guowj12@gmail.com>

ENV GERRIT_HOME /var/gerrit
ENV GERRIT_VERSION 2.14.1
ENV GERRIT_USER gerrit2

RUN adduser gerrit2 -d ${GERRIT_HOME} 
RUN yum install -y openssl openssh perl curl su-exec wget git
RUN cd ${GERRIT_HOME} && wget -o gerrit.war https://www.gerritcodereview.com/download/gerrit-${GERRIT_VERSION}.war
RUN mv ${GERRIT_HOME}/gerrit-${GERRIT_VERSION}.war ${GERRIT_HOME}/gerrit.war
RUN chown ${GERRIT_USER}:${GERRIT_USER} -R ${GERRIT_HOME}

RUN su - ${GERRIT_USER} -c "java -jar gerrit.war init -d ${GERRIT_HOME}"
RUN su - ${GERRIT_USER} -c "java -jar gerrit.war reindex"

COPY gerrit.config /var/gerrit/etc/gerrit.config
RUN chown ${GERRIT_USER}:${GERRIT_USER} -R ${GERRIT_HOME}

COPY gerrit-start.sh /gerrit-start.sh
RUN chmod +x /gerrit*.sh

EXPOSE 8080 29418

ENTRYPOINT ["/gerrit-start.sh"]

CMD ["sh", "-c", "echo $HOME"]
