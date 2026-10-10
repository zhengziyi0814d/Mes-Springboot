package com.wangziyang.mes.aichat.controller;

import com.wangziyang.mes.aichat.config.CozeProperties;
import com.wangziyang.mes.common.Result;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * AI 客服前端控制器：向前端暴露扣子配置，避免令牌硬编码在 HTML 里。
 * 路径以 /client/ 开头，复用 ShiroConfig 中 /client/** → anon 的免登录放行规则。
 */
@RestController
@RequestMapping("/client/ai")
public class AiChatController {

    @Autowired
    private CozeProperties cozeProperties;

    /**
     * 给前端 Chat SDK 用的配置接口：返回 botId / token / chatTitle。
     * 前端 JS 先 fetch 这个接口，再用返回值初始化 Chat SDK。
     */
    @ApiOperation("获取AI客服配置")
    @GetMapping("/config")
    public Result<Map<String, String>> config() {
        Map<String, String> data = new HashMap<>();
        data.put("botId", cozeProperties.getBotId());
        data.put("token", cozeProperties.getToken());
        data.put("chatTitle", cozeProperties.getChatTitle());
        return Result.success(data);
    }
}
