package com.wangziyang.mes.technology.request;

import com.wangziyang.mes.common.BasePageReq;

/**
 * bom 分页请求
 *
 * @author wangziyang
 * @since 20200328
 */

public class SpBomReq extends BasePageReq {
    /**
     * 物料模糊查询
     */
    private  String materielCodeLike ;

    /**
     * 获取 物料模糊查询
     *
     * @return materielCodeLike 物料模糊查询
     */
    public String getMaterielCodeLike() {
        return this.materielCodeLike;
    }

    /**
     * 设置 物料模糊查询
     *
     * @param materielCodeLike 物料模糊查询
     */
    public void setMaterielCodeLike(String materielCodeLike) {
        this.materielCodeLike = materielCodeLike;
    }
}
