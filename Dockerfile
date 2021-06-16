FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]
ARG CANN_TOOLKIT_PATH
COPY pip.conf /root/.pip/pip.conf
ADD $CANN_TOOLKIT_PATH ./
RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list &&\
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list &&\
    apt-get update && \
    apt-get install -y gcc g++ make cmake zlib1g zlib1g-dev openssl libsqlite3-dev libssl-dev libffi-dev unzip pciutils net-tools libblas-dev gfortran libblas3 libopenblas-dev libncursesw5-dev wget &&\
    wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz && \
    tar -zxvf Python-3.7.5.tgz &&\
    cd Python-3.7.5 &&\
    ./configure --prefix=/usr/local/python3.7.5 --enable-loadable-sqlite-extensions --enable-shared &&\
    make -j`nproc` &&\
    make install &&\
    ln -s /usr/local/python3.7.5/bin/python3 /usr/local/python3.7.5/bin/python3.7.5 &&\
    ln -s /usr/local/python3.7.5/bin/pip3 /usr/local/python3.7.5/bin/pip3.7.5 &&\
    echo python37_install_path=/usr/local/python3.7.5 > /etc/use_private_python.info &&\
    echo "export LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH" >> /root/.bashrc &&\
    echo "export PATH=/usr/local/python3.7.5/bin:\$PATH" >> /root/.bashrc &&\
    export LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH &&\
    export PATH=/usr/local/python3.7.5/bin:$PATH &&\
    pip3.7 install attrs &&\
    pip3.7 install numpy==1.17.2 &&\
    pip3.7 install decorator &&\
    pip3.7 install sympy &&\
    pip3.7 install cffi &&\
    pip3.7 install pyyaml &&\
    pip3.7 install pathlib2 &&\
    pip3.7 install psutil &&\
    pip3.7 install protobuf &&\
    pip3.7 install scipy &&\
    pip3.7 install requests
SHELL ["/bin/sh", "-c"]
RUN export LD_LIBRARY_PATH=/usr/local/python3.7.5/lib:$LD_LIBRARY_PATH &&\
    export PATH=/usr/local/python3.7.5/bin:$PATH && \
    chmod +x ./Ascend*.run && ./Ascend*.run --check &&\
    ./Ascend*.run --devel --install-username=root --install-usergroup=root &&\
    echo "source /usr/local/Ascend/ascend-toolkit/set_env.sh" >> /root/.bashrc
