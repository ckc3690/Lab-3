#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

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

#Copy

# Define working directory.
WORKDIR /usr/share/nginx/html

#Copy website content from host to volume in working directory
RUN -p 8080:80 -d -v /home/netsys/Desktop/lab3/nginxfiles/html:/usr/share/nginx/html

#Attach

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 8080
EXPOSE 443
