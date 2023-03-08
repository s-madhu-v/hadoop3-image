FROM ubuntu

USER root

RUN useradd --create-home hadoop_user
RUN apt update
RUN apt -y upgrade

# RUN apt -y install tldr
RUN apt -y install default-jdk
# RUN apt -y install vim

RUN apt -y install openssh-server
RUN apt -y install openssh-client
RUN apt -y install iproute2
RUN service ssh start

USER hadoop_user
RUN cd /home/hadoop_user
RUN wget --output-document ~/hadoop-zip.tar.gz https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar xvf ~/hadoop-zip.tar.gz --directory=/home/hadoop_user/
RUN mkdir ~/hadoop_home
RUN mv ~/hadoop-3.3.4/* ~/hadoop_home/
RUN rm -rf ~/hadoop-3.3.4
RUN rm -rf ~/hadoop-zip.tar.gz

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

RUN sed '54 c\export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")' ~/hadoop_home/etc/hadoop/hadoop-env.sh > ~/out.sh
RUN mv ~/out.sh ~/hadoop_home/etc/hadoop/hadoop-env.sh
RUN echo "PATH=\"\$PATH:/home/hadoop_user/hadoop_home/bin\"" >> ~/.bashrc

COPY ./hadoop_config/core-site.xml /home/hadoop_user/hadoop_home/etc/hadoop/core-site.xml
COPY ./hadoop_config/hdfs-site.xml /home/hadoop_user/hadoop_home/etc/hadoop/hdfs-site.xml

CMD ["/bin/sh"]