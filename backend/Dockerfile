FROM fedora:30
LABEL \
    name="Cloud Distribution Review Rot - Backend" \
    vendor="Cloud distribution team" \
    license="MIT"
RUN dnf -y install git && \
    yum -y install python3-pip && yum -y clean all && \
    pip3 install --upgrade setuptools && \
    git clone https://github.com/redhat-aqe/review-rot && \
    cd review-rot && \
    python3 setup.py install
# This will allow a non-root user to install a custom root CA at run-time
RUN chmod 777 /etc/pki/tls/certs/ca-bundle.crt
COPY run.sh /src/
USER 1001
ENTRYPOINT ["/src/run.sh"]
