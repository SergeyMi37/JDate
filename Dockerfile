ARG IMAGE=intersystemsdc/iris-community:latest
FROM $IMAGE

USER root
RUN apt-get update
RUN apt-get install -y build-essential

COPY py/* /
RUN chmod 6755 /rccx
 
# ENTRYPOINT /iris-main -a /rccx

WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild

USER ${ISC_PACKAGE_MGRUSER}

COPY src src
COPY module.xml module.xml
COPY iris.script iris.script

RUN iris start IRIS \
	&& iris session IRIS < iris.script \
    && iris stop IRIS quietly 

