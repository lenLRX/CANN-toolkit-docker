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