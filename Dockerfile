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
RUN service ssh start

RUN su hadoop_user
RUN cd /home/hadoop_user
RUN wget --output-document /hadoop-zip.tar.gz https://dlcdn.apache.org/hadoop/common/hadoop-3.3.4/hadoop-3.3.4.tar.gz
RUN tar xvf /hadoop-zip.tar.gz --directory=/home/hadoop_user/
RUN mkdir /home/hadoop_user/hadoop_home
RUN mv /home/hadoop_user/hadoop-3.3.4/* /home/hadoop_user/hadoop_home/
RUN rm -rf /home/hadoop_user/hadoop-3.3.4
RUN rm -rf /hadoop-zip.tar.gz

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys

RUN sed '54 c\
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")' /home/hadoop_user/hadoop_home/etc/hadoop/hadoop-env.sh > /out.sh
RUN mv /out.sh /home/hadoop_user/hadoop_home/etc/hadoop/hadoop-env.sh
RUN echo "PATH=\"\$PATH:/home/hadoop_user/hadoop_home/bin\"" >> /home/hadoop_user/.bashrc


CMD ["/bin/sh"]