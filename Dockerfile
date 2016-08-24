FROM alpine:3.2


ENV JAVA_VERSION_MAJOR=8
ENV JAVA_VERSION_MINOR=72
ENV JAVA_VERSION_BUILD=15
ENV JAVA_PACKAGE=server-jre
ENV JAVA_HOME=/opt/jdk
ENV PATH=${PATH}:/opt/jdk/bin
ENV LANG=C.UTF-8

ARG VERSION=8.92.14-r0
ENV MAJOR=8

RUN apk update --purge 
RUN apk add curl 
RUN apk add unzip=6.0-r1 
RUN apk add openjdk8-jre-base=8.92.14-r0

RUN curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/${MAJOR}/jce_policy-${MAJOR}.zip > /tmp/jce_policy-${MAJOR}.zip \
&& unzip -d /tmp/ /tmp/jce_policy-${MAJOR}.zip \
&& rm -vf /usr/lib/jvm/java-1.${MAJOR}-openjdk/jre/lib/security/*.jar \
&& cp -vf /tmp/UnlimitedJCEPolicyJDK${MAJOR}/*.jar /usr/lib/jvm/java-1.${MAJOR}-openjdk/jre/lib/security \
&& rm -rf /tmp/*

RUN apk del --force --purge unzip \
&& apk del --force --purge curl
