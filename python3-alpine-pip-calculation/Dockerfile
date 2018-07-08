FROM python:3.6.6-alpine

ARG profile=test
ENV ACTIVE_PROFILE=${profile}
ENV APP_HOME cbaas-data


COPY app ${APP_HOME}/app
COPY scripts ${APP_HOME}/scripts
WORKDIR ${APP_HOME}/app

RUN echo '[global]'>/etc/pip.conf && \
    echo 'trusted-host=mirrors.aliyun.com' >> /etc/pip.conf && \
    echo 'index-url=http://mirrors.aliyun.com/pypi/simple' >>/etc/pip.conf && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	echo "Asia/Shanghai" > /etc/timezone


RUN apk add --no-cache --virtual=.build-dependencies \
        g++ \
	gfortran \
	binutils \
        musl-dev \
	python3-dev \
	openblas-dev \
	libstdc++ \
	openblas && \
    ln -s locale.h /usr/include/xlocale.h && \
    pip install -U pip setuptools wheel && \
    pip install numpy && \
    pip install -r requirements.txt	 && \
    rm -rf ~/.cache/pip && \
    rm -rf /root/.cache && \
    find /usr/local/lib/python3.*/ -name 'tests' -exec rm -rf '{}' + && \
    find /usr/local/lib/python3.*/ -name '__pycache__' -exec rm -rf '{}' + && \
    rm /usr/include/xlocale.h && \
    apk del .build-dependencies
		

EXPOSE 5001
ENTRYPOINT [ "sh","startup.sh","--profile=${ACTIVE_PROFILE}" ]

