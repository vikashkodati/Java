FROM alpine:3.3
ARG VERSION=8.92.14-r0
ENV MAJOR=8

RUN apk update --purge \
&& apk add curl=7.47.0-r0 \
&& apk add unzip=6.0-r1 \
&& apk add openjdk8-jre-base=${VERSION}

RUN curl -s -k -L -C - -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/${MAJOR}/jce_policy-${MAJOR}.zip > /tmp/jce_policy-${MAJOR}.zip \
&& unzip -d /tmp/ /tmp/jce_policy-${MAJOR}.zip \
&& rm -vf /usr/lib/jvm/java-1.${MAJOR}-openjdk/jre/lib/security/*.jar \
&& cp -vf /tmp/UnlimitedJCEPolicyJDK${MAJOR}/*.jar /usr/lib/jvm/java-1.${MAJOR}-openjdk/jre/lib/security \
&& rm -rf /tmp/*

RUN apk del --force --purge unzip \
&& apk del --force --purge curl

CMD ["java","-version"]

