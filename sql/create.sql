
CREATE TABLE `t_test` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `user_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `task_id` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `task_type` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `task_stage` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
    `priority` int(11) NOT NULL DEFAULT '0' COMMENT '优先级',
    `crt_retry_num` int(11) NOT NULL DEFAULT '0' COMMENT '已经重试几次了',
    `max_retry_num` int(11) NOT NULL DEFAULT '0' COMMENT '最大能重试几次',
    `max_retry_interval` int(11) NOT NULL DEFAULT '0' COMMENT '最大重试间隔',
    `schedule_log` varchar(4096) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '调度信息记录',
    `task_context` varchar(8192) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务上下文，用户自定义',
    `order_time` int(20) NOT NULL DEFAULT '0' COMMENT '调度时间，越小调度越优先',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_task_id` (`task_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_tasktype_status_modify_time` (`status`,`order_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci


CREATE TABLE `t_schedule_cfg` (
    `task_type` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务类型',
    `schedule_limit` int(11) DEFAULT '0' COMMENT '一次拉取多少个任务',
    `schedule_interval` int(11) NOT NULL DEFAULT '10',
    `max_processing_time` int(11) DEFAULT '0' COMMENT '处于执行中的最大时间',
    `max_retry_num` int(11) DEFAULT '0' COMMENT '最大重试次数',
    `retry_interval` int(11) DEFAULT NULL COMMENT '初始重试间隔',
    `max_retry_interval` int(11) DEFAULT NULL COMMENT '最大重试间隔',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
    `modify_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`task_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE `t_schedule_pos` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `task_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    `schedule_begin_pos` int(11) NOT NULL DEFAULT '0' COMMENT '调度开始于几号表',
    `schedule_end_pos` int(11) NOT NULL DEFAULT '0' COMMENT '调度结束于几号表',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modify_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_task_type` (`task_type`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO t_schedule_cfg (task_type, schedule_limit, schedule_interval, max_processing_time, max_retry_num, retry_interval, max_retry_interval)
VALUES ("lark", 100, 10, 30, 3, 5, 30);



INSERT INTO t_schedule_pos (task_type, schedule_begin_pos, schedule_end_pos)
VALUES ("lark", 1, 1);
