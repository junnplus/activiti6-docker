FROM tomcat:8.5-jdk8-openjdk

EXPOSE 8080

ENV MYSQL_CONNECTOR_JAVA_VERSION 8.0.16

RUN wget https://github.com/Activiti/Activiti/releases/download/activiti-6.0.0/activiti-6.0.0.zip -O /tmp/activiti.zip && \
        unzip /tmp/activiti.zip -d /tmp && \
        unzip /tmp/activiti-6.0.0/wars/activiti-app.war -d ${CATALINA_HOME}/webapps/activiti-app && \
        unzip /tmp/activiti-6.0.0/wars/activiti-rest.war -d ${CATALINA_HOME}/webapps/activiti-rest && \
        rm -rf /tmp/activiti*

RUN wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.zip -O /tmp/mysql-connector-java.zip && \
        unzip /tmp/mysql-connector-java.zip -d /tmp && \
        cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.jar ${CATALINA_HOME}/webapps/activiti-app/WEB-INF/lib/ && \
        cp /tmp/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_JAVA_VERSION}.jar ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/lib/ && \
        rm -rf /tmp/mysql-connector-java*

RUN rm -rf ${CATALINA_HOME}/webapps/docs ${CATALINA_HOME}/webapps/examples

ADD . /tmp/activiti6
RUN cp /tmp/activiti6/config/context.xml ${CATALINA_HOME}/webapps/manager/META-INF/
RUN cp /tmp/activiti6/config/index.jsp ${CATALINA_HOME}/webapps/ROOT/

CMD ["/tmp/activiti6/start.sh"]
