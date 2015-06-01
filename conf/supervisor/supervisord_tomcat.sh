#!/bin/bash
function shutdown()
{
    date
    echo "Shutting down Tomcat"
    unset CATALINA_PID # Necessary in some cases
    unset LD_LIBRARY_PATH # Necessary in some cases
    unset JAVA_OPTS # Necessary in some cases

    . /data/tomcat/bin/catalina.sh stop
}

date
echo "Starting Tomcat"
export CATALINA_PID=/tmp/$$
export JAVA_HOME=/usr/java/default
export JAVA_OPTS="-Xms128m -Xmx192m"

. /data/tomcat/bin/catalina.sh start

echo "Waiting for `cat $CATALINA_PID`"
wait `cat $CATALINA_PID`