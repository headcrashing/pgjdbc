#!/usr/bin/env bash
set -x -e

# Build project
MVN_ARGS="clean package -B -V"

if [[ "${TRAVIS_JDK_VERSION}" == *"jdk6"* ]];
then
    git clone --depth=50 https://github.com/pgjdbc/pgjdbc-jre6.git pgjdbc-jre6
    cd pgjdbc-jre6
    mvn ${MVN_ARGS} -P release,skip-unzip-jdk
elif [[ "${TRAVIS_JDK_VERSION}" == *"jdk7"* ]];
then
    git clone --depth=50 https://github.com/pgjdbc/pgjdbc-jre7.git pgjdbc-jre7
    cd pgjdbc-jre7
    mvn ${MVN_ARGS} -P release,skip-unzip-jdk
elif [ "${PG_VERSION}" == "9.4" ];
then
# Build javadocs for Java 8 and PG 9.4 only
    mvn ${MVN_ARGS} -P release-artifacts,release
else
    mvn ${MVN_ARGS} -P release
fi
