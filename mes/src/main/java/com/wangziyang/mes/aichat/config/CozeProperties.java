package com.wangziyang.mes.aichat.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 扣子（Coze）平台连接配置，对应 application-pro.yml 中的 coze: 段。
 * 所有 AI 客服相关参数集中在此，避免散落在代码各处。
 */
@Component
@ConfigurationProperties(prefix = "coze")
public class CozeProperties {

    /** 对话接口地址，国内版固定 https://api.coze.cn/v3/chat */
    private String apiUrl;

    /** API 令牌（PAT），注意保密；正式环境建议从环境变量注入 */
    private String token;

    /** 智能体 ID，来自扣子发布后地址栏 */
    private String botId;

    /** 聊天窗标题 */
    private String chatTitle = "MES 智能客服";

    /** 连接超时（毫秒） */
    private int connectTimeout = 5000;

    /** 读取超时（毫秒） */
    private int readTimeout = 60000;

    // ===== getter / setter =====

    public String getApiUrl() { return apiUrl; }
    public void setApiUrl(String apiUrl) { this.apiUrl = apiUrl; }

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }

    public String getBotId() { return botId; }
    public void setBotId(String botId) { this.botId = botId; }

    public String getChatTitle() { return chatTitle; }
    public void setChatTitle(String chatTitle) { this.chatTitle = chatTitle; }

    public int getConnectTimeout() { return connectTimeout; }
    public void setConnectTimeout(int connectTimeout) { this.connectTimeout = connectTimeout; }

    public int getReadTimeout() { return readTimeout; }
    public void setReadTimeout(int readTimeout) { this.readTimeout = readTimeout; }
}
