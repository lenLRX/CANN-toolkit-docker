# CANN toolkit docker脚本

## 构建docker镜像
```bash
docker build --build-arg CANN_TOOLKIT_PATH=Ascend-cann-tookit<version+arch>.run . -t atc:latest
```
注意:
1. 非root用户请加上sudo
2. 请将Ascend-cann-tookit<version+arch>.run改为实际上的toolkit路径(必须是相对路径)

## 运行
```bash
docker run -it -v=`pwd`:/work atc:latest
```
注意:
1. 非root用户请加上sudo
2. ```-v=`pwd`:/work```表示将当前目录映射到docker容器内的/work目录。详细信息请查阅docker官方文档:)

# CANN AMCT 量化工具docker脚本

1. 从这个[仓库](https://github.com/lenLRX/caffe)下载zip[代码](https://github.com/lenLRX/caffe/archive/refs/heads/ascend-amct.zip),得到的zip包可能叫ascend-amct.zip或caffe-ascend-amct.zip
2. 从[这里](https://support.huawei.com/enterprise/zh/ascend-computing/cann-pid-251168373/software)下载amct的包Ascend-cann-amct_1.76.22.10.220_ubuntu18.04-x86_64.tar.gz
3. 执行以下命令构建docker镜像,要求:
    * 本需要先构建前面的CANN-toolkit镜像
    * CANN_AMCT_PATH=前面下载的amct包名字
    * CAFFE_SRC=本地的caffe代码zip包
    * 非root用户请在前面加上sudo
```bash
docker build --build-arg CANN_AMCT_PATH=Ascend-cann-amct_1.76.22.10.220_ubuntu18.04-x86_64.tar.gz --build-arg CAFFE_SRC=caffe-ascend-amct.zip -f Dockerfile.amct . -t amct-caffe:latest
```