# activiti6-docker


## How to use this image
### Start a activiti6 instance
```
$ docker run --name activiti6 -d -p 8080:8080 junnplus/activiti6
```
you can customise using the following environment variables:
- `DB` The database type, option h2 / mysql, default to `h2`.
- `DB_DRIVER` The database  driver for jdbc, default to `org.h2.Driver`.
- `DB_URL` The database url for jdbc, default to`jdbc:h2:/tmp/activiti6;AUTO_SERVER=TRUE`.
- `DB_USERNAME` The database username, default to `sa`.
- `DB_PASSWORD` The database password, default to empty.
- `DB_DIALECT` The dialect specifies the type of database used in hibernate, default to `org.hibernate.dialect.H2Dialect`.

#### ...via `docker-compose`
example.yml for mysql:
```
version: '3.1'
services:
    activiti6:
        image: junnplus/activiti6
        ports:
            - "8080:8080"
        environment:
            - "DB=mysql"
            - "DB_DRIVER=com.mysql.jdbc.Driver"
            - "DB_URL=jdbc:mysql://mysql:3306/activiti6?characterEncoding=UTF-8"
            - "DB_USERNAME=activiti6"
            - "DB_PASSWORD=activiti6"
            - "DB_DIALECT=org.hibernate.dialect.MySQLDialect"
        depends_on:
            - mysql
        links:
            - mysql
        restart: always
    mysql:
        image: mysql:5.6
        command: mysqld --character-set-server=utf8 --collation-server=utf8_unicode_ci
        environment:
            - "MYSQL_DATABASE=activiti6"
            - "MYSQL_USER=activiti6"
            - "MYSQL_PASSWORD=activiti6"
            - "MYSQL_ROOT_PASSWORD=activiti6"
        restart: always
```
### Accessing
you can access the activiti6 app on `http://localhost:8080`.
