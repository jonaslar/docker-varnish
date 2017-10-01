FROM openshift/base-centos7
MAINTAINER Jonas Larsen <jonas.larsen@norsk-tipping.no>

# Install repo
COPY epel7.repo /etc/yum.repos.d/epel.repo

# Install base system
RUN yum install -y --enablerepo=epel varnish vim && \
    yum clean all

# Make our custom VCLs available on the container
# ADD default.vcl /etc/varnish/default.vcl

# Export environment variables
ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

ADD start /start

RUN chmod 0755 /start && chmod -R 0777 /var/lib/varnish

USER 1000120010
CMD ["/start"]
