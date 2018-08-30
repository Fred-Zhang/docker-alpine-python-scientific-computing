FROM alpine:3.7

RUN apk add --no-cache python && \
 python -m ensurepip && \
 rm -r /usr/lib/python*/ensurepip && \
 pip install --upgrade pip setuptools && \
 apk add --no-cache nginx && \
 rm -r /root/.cache

RUN apk add --no-cache \
        --virtual=.build-dependencies \
        g++ gfortran file binutils \
        musl-dev python-dev openblas-dev && \
    apk add libstdc++ openblas && \
    apk add nginx && \
    \
    ln -s locale.h /usr/include/xlocale.h && \
    \
    pip install numpy && \
    pip install pandas && \
    pip install scipy && \
    pip install scikit-learn && \
    pip install statsmodels && \
    pip install flask && \
    pip install gevent && \
    pip install gunicorn && \
    \
    rm -r /root/.cache && \
    find /usr/lib/python2.*/ -name 'tests' -exec rm -r '{}' + && \
    find /usr/lib/python2.*/site-packages/ -name '*.so' -print -exec sh -c 'file "{}" | grep -q "not stripped" && strip -s "{}"' \; && \
    \
    rm /usr/include/xlocale.h && \
    \
apk del .build-dependencies