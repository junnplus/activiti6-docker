#!/bin/bash
set -e
set -x

DB=${DB:-}
DB_DRIVER=${DB_DRIVER:-}
DB_URL=${DB_URL:-}
DB_USERNAME=${DB_USERNAME:-}
DB_PASSWORD=${DB_PASSWORD:-}
DB_DIALECT=${DB_DIALECT:-}

case "${DB}" in
  mysql) 
    sed 's#{{DB}}#'"${DB}"'#g' -i /tmp/activiti/config/db.properties
    sed 's#{{DB_DRIVER}}#'"${DB_DRIVER}"'#g' -i /tmp/activiti/config/db.properties
    sed 's#{{DB_URL}}#'"${DB_URL}"'#g' -i /tmp/activiti/config/db.properties
    sed 's#{{DB_USERNAME}}#'"${DB_USERNAME}"'#g' -i /tmp/activiti/config/db.properties
    sed 's#{{DB_PASSWORD}}#'"${DB_PASSWORD}"'#g' -i /tmp/activiti/config/db.properties

    sed 's#{{DB_DRIVER}}#'"${DB_DRIVER}"'#g' -i /tmp/activiti/config/activiti-app.properties
    sed 's#{{DB_URL}}#'"${DB_URL}"'#g' -i /tmp/activiti/config/activiti-app.properties
    sed 's#{{DB_USERNAME}}#'"${DB_USERNAME}"'#g' -i /tmp/activiti/config/activiti-app.properties
    sed 's#{{DB_PASSWORD}}#'"${DB_PASSWORD}"'#g' -i /tmp/activiti/config/activiti-app.properties
    sed 's#{{DB_DIALECT}}#'"${DB_DIALECT}"'#g' -i /tmp/activiti/config/activiti-app.properties

    cp -f /tmp/activiti/config/activiti-app.properties ${CATALINA_HOME}/webapps/activiti-app/WEB-INF/classes/META-INF/activiti-app/
    cp -f /tmp/activiti/config/db.properties ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/

    sed 's#create.demo.users=true#create.demo.users=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    sed 's#create.demo.definitions=true#create.demo.definitions=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    sed 's#create.demo.models=true#create.demo.models=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    ;;
esac

catalina.sh run
