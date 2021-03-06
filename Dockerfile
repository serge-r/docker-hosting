# Version: 0.1.0

# Add a setup script for set a base enviroment

FROM centos:latest
MAINTAINER serge <mail@r-serge.info>

RUN yum -y update && yum -y install epel-release
RUN yum -y install mariadb-libs libmcrypt libtool-ltdl libXpm libxslt httpd freetype libidn libcurl libxml2 pcre openssl-libs libjpeg-turbo zlib libpng libX11 freetype expat mod_fcgid

COPY content/ /opt/content
RUN /opt/content/bin/setup.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
EXPOSE 80 443
