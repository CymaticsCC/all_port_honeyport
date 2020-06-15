FROM golang

#设置时区变量
ENV TZ=Asia/Shanghai

#调整时区,从github拉取相应源码，并编译
run ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    go get github.com/md-irohas/tcppc-go && \
    cd /go/src/github.com/md-irohas/tcppc-go && \
    go build main.go

#跳转至生成的二进制位置
WORKDIR /go/bin/

#执行命令
cmd ["./tcppc-go", "-T","86400","-w","log/tcppc-%Y%m%d.jsonl"]
