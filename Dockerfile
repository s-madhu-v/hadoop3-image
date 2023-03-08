FROM ubuntu

USER root

RUN useradd hadoop_user
RUN apt update
RUN apt -y upgrade

RUN apt -y install tldr
RUN apt -y install default-jdk
RUN apt -y install vim

RUN apt -y install openssh-server
RUN apt -y install openssh-client
RUN service ssh start

RUN su hadoop_user
RUN cd
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar xvf ~/hadoop-3.3.4.tar.gz
RUN mkdir hadoop_home
RUN mv ~/hadoop-3.3.4/* ~/hadoop_home

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

CMD ["/bin/sh"]


