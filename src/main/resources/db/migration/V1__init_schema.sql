CREATE TABLE `tb_blog`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NOT NULL COMMENT '商户id',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `images` varchar(2048) NOT NULL COMMENT '探店的照片，最多9张，多张以\",\"隔开',
  `content` varchar(2048) NOT NULL COMMENT '探店的文字描述',
  `liked` int(8) UNSIGNED NULL DEFAULT 0 COMMENT '点赞数量',
  `comments` int(8) UNSIGNED NULL DEFAULT NULL COMMENT '评论数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_blog_comments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `blog_id` bigint(20) UNSIGNED NOT NULL COMMENT '探店id',
  `parent_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的1级评论id，如果是一级评论，则值为0',
  `answer_id` bigint(20) UNSIGNED NOT NULL COMMENT '回复的评论id',
  `content` varchar(255) NOT NULL COMMENT '回复的内容',
  `liked` int(8) UNSIGNED NULL DEFAULT NULL COMMENT '点赞数',
  `status` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '状态，0：正常，1：被举报，2：禁止查看',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_follow`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `follow_user_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_seckill_voucher` (
  `voucher_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的优惠券的id',
  `stock` int UNSIGNED NOT NULL COMMENT '库存',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '生效时间',
  `end_time`   timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '失效时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`voucher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='秒杀优惠券表，与优惠券是一对一关系';

CREATE TABLE `tb_shop` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '商铺名称',
  `type_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺类型的id',
  `images` varchar(1024) NOT NULL COMMENT '商铺图片，多个图片以\',\'隔开',
  `area` varchar(128) DEFAULT NULL COMMENT '商圈，例如陆家嘴',
  `address` varchar(255) NOT NULL COMMENT '地址',
  `x` double UNSIGNED NOT NULL COMMENT '经度',
  `y` double UNSIGNED NOT NULL COMMENT '纬度',
  `avg_price` bigint UNSIGNED DEFAULT NULL COMMENT '均价，取整数',
  `sold` int UNSIGNED NOT NULL COMMENT '销量',
  `comments` int UNSIGNED NOT NULL COMMENT '评论数量',
  `score` int UNSIGNED NOT NULL COMMENT '评分，1~5分，乘10保存，避免小数',
  `open_hours` varchar(32) DEFAULT NULL COMMENT '营业时间，例如 10:00-22:00',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `foreign_key_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_shop_type` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) DEFAULT NULL COMMENT '类型名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `sort` int UNSIGNED DEFAULT NULL COMMENT '顺序',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_sign` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `year` year NOT NULL COMMENT '签到的年',
  `month` tinyint UNSIGNED NOT NULL COMMENT '签到的月',
  `date` date NOT NULL COMMENT '签到的日期',
  `is_backup` tinyint(1) UNSIGNED DEFAULT NULL COMMENT '是否补签',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_user` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(11) NOT NULL COMMENT '手机号码',
  `password` varchar(128) DEFAULT '' COMMENT '密码，加密存储',
  `nick_name` varchar(32) DEFAULT '' COMMENT '昵称，默认是用户id',
  `icon` varchar(255) DEFAULT '' COMMENT '人物头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqe_key_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_user_info` (
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '主键，用户id',
  `city` varchar(64) DEFAULT '' COMMENT '城市名称',
  `introduce` varchar(128) DEFAULT NULL COMMENT '个人介绍，不要超过128个字符',
  `fans` int UNSIGNED DEFAULT 0 COMMENT '粉丝数量',
  `followee` int UNSIGNED DEFAULT 0 COMMENT '关注的人的数量',
  `gender` tinyint UNSIGNED DEFAULT 0 COMMENT '性别，0：男，1：女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `credits` int UNSIGNED DEFAULT 0 COMMENT '积分',
  `level` tinyint UNSIGNED DEFAULT 0 COMMENT '会员级别，0~9级,0代表未开通会员',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_voucher` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT '商铺id',
  `title` varchar(255) NOT NULL COMMENT '代金券标题',
  `sub_title` varchar(255) DEFAULT NULL COMMENT '副标题',
  `rules` varchar(1024) DEFAULT NULL COMMENT '使用规则',
  `pay_value` bigint UNSIGNED NOT NULL COMMENT '支付金额，单位分',
  `actual_value` bigint UNSIGNED NOT NULL COMMENT '抵扣金额，单位分',
  `type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '0普通券；1秒杀券',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '1上架; 2下架; 3过期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_voucher_order` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT '主键',            -- 不自增：通常由雪花/发号器生成
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '下单的用户id',
  `voucher_id` bigint(20) UNSIGNED NOT NULL COMMENT '购买的代金券id',
  `pay_type` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '1余额;2支付宝;3微信',
  `status` tinyint UNSIGNED NOT NULL DEFAULT 1 COMMENT '1未支付;2已支付;3已核销;4已取消;5退款中;6已退款',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `use_time` timestamp NULL DEFAULT NULL COMMENT '核销时间',
  `refund_time` timestamp NULL DEFAULT NULL COMMENT '退款时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_voucher` (`voucher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





