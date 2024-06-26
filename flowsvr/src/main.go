﻿package main

import (
	"fmt"

	"github.com/niuniumart/asyncflow/flowsvr/src/config"
	"github.com/niuniumart/asyncflow/flowsvr/src/initialize"
	"github.com/niuniumart/asyncflow/flowsvr/src/rtm"
	"github.com/niuniumart/gosdk/gin"
)

func main() {

	// 初始化配置
	config.Init()
	// 初始资源，主要是MySQL，Redis连接
	initialize.InitResource()
	// 开启任务治理
	var rtm rtm.TaskRuntime
	rtm.Run()
	// 创建一个web服务
	router := gin.CreateGin() // 调库的
	// 这里跳进去就能看到有哪些接口
	initialize.RegisterRouter(router)
	fmt.Println("before router run")
	// 启动web server，这一步之后这个主协程启动会阻塞在这里，请求可以通过gin的子协程进来
	err := gin.RunByPort(router, config.Conf.Common.Port)
	fmt.Println(err)
}
