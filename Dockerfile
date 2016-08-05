FROM alpine:3.2

	# Install dependencies 
	RUN apk --update add curl ca-certificates tar sqlite icu bash && \
	    curl -Ls https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk > /tmp/glibc-2.21-r2.apk && \
	    apk add --allow-untrusted /tmp/glibc-2.21-r2.apk


	# Java version
	ENV JAVA_VERSION_MAJOR 7
	ENV JAVA_VERSION_MINOR 79
	ENV JAVA_VERSION_BUILD 15
	ENV JAVA_PACKAGE       jdk


	# Download and unarchive Java
	RUN mkdir /opt && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
	  http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz \
	    | tar -xzf - -C /opt &&\
	    ln -s /opt/jdk1.7.0_79 /opt/jdk &&\
	    rm -rf /opt/jdk/*src.zip \
	           /opt/jdk/lib/missioncontrol \
	           /opt/jdk/lib/visualvm \
	           /opt/jdk/lib/*javafx* \
	           /opt/jdk/jre/lib/plugin.jar \
	           /opt/jdk/jre/lib/ext/jfxrt.jar \
	           /opt/jdk/jre/bin/javaws \
	           /opt/jdk/jre/lib/javaws.jar \
	           /opt/jdk/jre/lib/desktop \
	           /opt/jdk/jre/plugin \
	           /opt/jdk/jre/lib/deploy* \
	           /opt/jdk/jre/lib/*javafx* \
	           /opt/jdk/jre/lib/*jfx* \
	           /opt/jdk/jre/lib/amd64/libdecora_sse.so \
	           /opt/jdk/jre/lib/amd64/libprism_*.so \
	           /opt/jdk/jre/lib/amd64/libfxplugins.so \
	           /opt/jdk/jre/lib/amd64/libglass.so \
	           /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
	           /opt/jdk/jre/lib/amd64/libjavafx*.so \
	           /opt/jdk/jre/lib/amd64/libjfx*.so \
	    && addgroup -g 999 app && adduser -D  -G app -s /bin/false -u 999 app \
	    && rm -rf /tmp/* \
	    && rm -rf /var/cache/apk/* \
	    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf


	# Set environment
	ENV JAVA_HOME /opt/jdk
	ENV PATH ${PATH}:/opt/jdk/bin	
