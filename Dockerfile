FROM apache/hadoop:3

USER root

RUN yum -y install which
RUN yum -y install java-1.8.0-openjdk-devel
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
RUN yum -y install pdsh

CMD ["/bin/sh"]