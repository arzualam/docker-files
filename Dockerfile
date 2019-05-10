FROM centos:6.10
MAINTAINER ArzuAlam

RUN yum update -y && yum install openssh-server openssh -y
RUN mkdir /var/run/sshd
RUN echo 'root:test@123' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN ssh-keygen -A
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

