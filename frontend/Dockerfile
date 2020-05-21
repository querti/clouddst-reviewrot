FROM tomaskral/nonroot-nginx
LABEL \
    name="Cloud Distribution Review Rot - Frontend" \
    vendor="Cloud Distribution Team" \
    license="MIT"

USER 0
RUN yum -y install git && yum -y clean all
RUN git clone https://github.com/redhat-aqe/review-rot && \
    rm -rf /usr/share/nginx/html/* && \
    ln -s $(pwd)/review-rot/web/* /usr/share/nginx/html/. && \
    rm /usr/share/nginx/html/js/default-data.json && \
    ln -s /opt/data/data.json /usr/share/nginx/html/js/default-data.json && \
    sed -i 's/https:\/\/raw.githubusercontent.*\/default/js\/default/' /usr/share/nginx/html/js/site.js
EXPOSE 8080
USER 997
