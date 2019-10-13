#!/bin/bash
set -e
set -x

DB=${DB:-h2}
DB_DRIVER=${DB_DRIVER:-org.h2.Driver}
DB_URL=${DB_URL:-jdbc:h2:/tmp/activiti6;AUTO_SERVER=TRUE}
DB_USERNAME=${DB_USERNAME:-sa}
DB_PASSWORD=${DB_PASSWORD:-}
DB_DIALECT=${DB_DIALECT:-org.hibernate.dialect.H2Dialect}

case "${DB}" in
  h2|mysql)
    sed 's#{{DB}}#'"${DB}"'#g' -i /tmp/activiti6/config/db.properties
    sed 's#{{DB_DRIVER}}#'"${DB_DRIVER}"'#g' -i /tmp/activiti6/config/db.properties
    sed 's#{{DB_URL}}#'"${DB_URL}"'#g' -i /tmp/activiti6/config/db.properties
    sed 's#{{DB_USERNAME}}#'"${DB_USERNAME}"'#g' -i /tmp/activiti6/config/db.properties
    sed 's#{{DB_PASSWORD}}#'"${DB_PASSWORD}"'#g' -i /tmp/activiti6/config/db.properties

    sed 's#{{DB_DRIVER}}#'"${DB_DRIVER}"'#g' -i /tmp/activiti6/config/activiti-app.properties
    sed 's#{{DB_URL}}#'"${DB_URL}"'#g' -i /tmp/activiti6/config/activiti-app.properties
    sed 's#{{DB_USERNAME}}#'"${DB_USERNAME}"'#g' -i /tmp/activiti6/config/activiti-app.properties
    sed 's#{{DB_PASSWORD}}#'"${DB_PASSWORD}"'#g' -i /tmp/activiti6/config/activiti-app.properties
    sed 's#{{DB_DIALECT}}#'"${DB_DIALECT}"'#g' -i /tmp/activiti6/config/activiti-app.properties

    cp -f /tmp/activiti6/config/activiti-app.properties ${CATALINA_HOME}/webapps/activiti-app/WEB-INF/classes/META-INF/activiti-app/
    cp -f /tmp/activiti6/config/db.properties ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/

    sed 's#create.demo.users=true#create.demo.users=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    sed 's#create.demo.definitions=true#create.demo.definitions=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    sed 's#create.demo.models=true#create.demo.models=false#g' -i ${CATALINA_HOME}/webapps/activiti-rest/WEB-INF/classes/engine.properties
    ;;
esac

catalina.sh run
