FROM php:apache

RUN apt-get update -y && apt-get upgrade -y \
	&& apt-get install -y openssh-server \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get autoclean && apt-get autoremove \
	&& mkdir -p /var/run/sshd \
	&& echo 'root:docker' | chpasswd \
	&& sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& echo 'ServerName Default' >> /etc/apache2/apache2.conf

EXPOSE 22 80

CMD /etc/init.d/ssh start \
	&& /etc/init.d/apache2 start \
	&& tail -f /dev/null