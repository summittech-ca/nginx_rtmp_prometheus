ARG ARCH="amd64"
ARG OS="linux"
FROM scratch
COPY ./nginx_rtmp_exporter /bin/nginx_rtmp_exporter

EXPOSE 9728
ENTRYPOINT [ "/bin/nginx_rtmp_exporter" ]
