FROM jboss/base-jdk:8

MAINTAINER wguo <guowj12@gmail.com>

ENV GERRIT_HOME=/var/gerrit \
    GERRIT_VERSION=2.14.1 \
    GERRIT_USER=gerrit2

# User root to add user and install software
USER root

RUN adduser gerrit2 -d ${GERRIT_HOME} && \
yum install -y openssl openssh wget git && \
cd ${GERRIT_HOME} && wget https://www.gerritcodereview.com/download/gerrit-${GERRIT_VERSION}.war && \
mv ${GERRIT_HOME}/gerrit-${GERRIT_VERSION}.war ${GERRIT_HOME}/gerrit.war && \
chown ${GERRIT_USER}:${GERRIT_USER} -R ${GERRIT_HOME}

# Switch to gerrit2 to init gerrit
USER ${GERRIT_USER}

RUN cd ${GERRIT_HOME} && java -jar gerrit.war init -d ${GERRIT_HOME} && \
cd ${GERRIT_HOME} && java -jar gerrit.war reindex

# Back to root
USER root

COPY gerrit.config /var/gerrit/etc/gerrit.config
RUN chown ${GERRIT_USER}:${GERRIT_USER} -R ${GERRIT_HOME}

COPY gerrit-start.sh /gerrit-start.sh
RUN chmod +x /gerrit*.sh

EXPOSE 8080 29418

ENTRYPOINT ["/gerrit-start.sh"]

CMD ["sh", "-c", "echo $HOME"]
