FROM centos:7
LABEL \
    name="Cloud Distribution Review Rot - Backend" \
    vendor="Cloud distribution team" \
    license="MIT"
RUN yum -y install git epel-release && \
    yum -y install python-pip && yum -y clean all && \
    pip install --upgrade pip setuptools && \
    git clone https://github.com/redhat-aqe/review-rot && \
    cd review-rot && \
    python setup.py install
# This will allow a non-root user to install a custom root CA at run-time
RUN chmod 777 /etc/pki/tls/certs/ca-bundle.crt
COPY run.sh /src/
USER 1001
ENTRYPOINT ["/src/run.sh"]
