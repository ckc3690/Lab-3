#Dockerfile to install a webserver using Nginx

ADD VERSION

# Pull base image.
FROM centos:centos7

#Specify Nginx & OS Version
ENV nginxversion="1.12.2-1" \
    os="centos" \
    osversion="7" \
    elversion="7_4"

# Install Nginx & Set directory permissions
RUN yum install -y wget openssl sed &&\
    yum -y autoremove &&\
    yum clean all &&\
    wget http://nginx.org/packages/$os/$osversion/x86_64/RPMS/nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    rpm -iv nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    sed -i '1i\
    daemon off;\
    ' /etc/nginx/nginx.conf
    
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# set working directory.
WORKDIR /usr/share/nginx/html

#Copy static content from running container to new instance
FROM %%explorecali:0.1%%
COPY /usr/share/nginx/html /usr/share/nginx/html

#Copy config file from running container
FROM %%explorecali:0.1%%
COPY nginx.conf /etc/nginx/nginx.conf

#Set folder permissions 
RUN chmod 755 /usr/share/nginx/html

# Set default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 8080
EXPOSE 443
