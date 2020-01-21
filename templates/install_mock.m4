RUN yum -y --setopt="tsflags=nodocs" update && \
	yum -y --setopt="tsflags=nodocs" install epel-release mock rpm-sign expect && \
	yum clean all && \
	rm -rf /var/cache/yum/,dnl

RUN useradd -u 1000 -G mock builder
RUN chmod g+w /etc/mock/*.cfg

VOLUME ["/rpmbuild"]
ONBUILD COPY mock /etc/mock

# create mock cache on external volume to speed up build
RUN install -g mock -m 2775 -d /rpmbuild/cache/mock
RUN echo "config_opts['cache_topdir'] = '/rpmbuild/cache/mock'" >> /etc/mock/site-defaults.cfg

COPY build-rpm.sh /
COPY local-centos-7-x86_64.cfg /etc/mock/local-centos-7-x86_64.cfg
RUN chmod +x /build-rpm.sh

CMD ["/build-rpm.sh"]
