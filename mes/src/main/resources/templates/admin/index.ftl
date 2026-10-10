<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>黑科开源-MES系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <#include "${request.contextPath}/common/common.ftl">
    <link rel="stylesheet" href="${request.contextPath}/css/splayui.css" media="all">
    <style id="splayui-bg-color">
    </style>
</head>
<body class="layui-layout-body splayui-all">
<div class="layui-layout layui-layout-admin">

    <div class="layui-header header">
        <div class="layui-logo">
        </div>
        <a>
            <div class="splayui-tool"><i title="展开" class="fa fa-outdent" data-side-fold="1"></i></div>
        </a>

        <ul class="layui-nav layui-layout-left layui-header-menu layui-header-pc-menu mobile layui-hide-xs">
        </ul>
        <ul class="layui-nav layui-layout-left layui-header-menu mobile layui-hide-sm">
            <li class="layui-nav-item">
                <a href="javascript:;"><i class="fa fa-list-ul"></i> 选择模块</a>
                <dl class="layui-nav-child layui-header-menu">
                </dl>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <button type="button"  class="fa fa-github-alt " onclick="notice()"  data-method="setTop" >B站视频</button>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" data-refresh="刷新"><i class="fa fa-refresh"></i></a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;" data-clear="清理" class="splayui-clear"><i class="fa fa-trash-o"></i></a>
            </li>
            <li class="layui-nav-item splayui-setting">
                <a href="javascript:;">
                    <img id="js-user-avatar" src="" class="layui-nav-img" style="width:36px;height:36px;border-radius:50%;object-fit:cover;margin-right:8px;">
                    <span id="js-user-name">admin</span>
                </a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="javascript:;" data-iframe-tab="page/user-setting.html" data-title="基本资料"
                           data-icon="fa fa-gears">基本资料</a>
                    </dd>
                    <dd>
                        <a href="javascript:;" data-iframe-tab="page/user-password.html" data-title="修改密码"
                           data-icon="fa fa-gears">修改密码</a>
                    </dd>
                    <dd>
                        <a class="login-out" href="${request.contextPath}/login-ui">退出登录</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item splayui-select-bgcolor mobile layui-hide-xs">
                <a href="javascript:;" data-bgcolor="配色方案"><i class="fa fa-ellipsis-v"></i></a>
            </li>
        </ul>
    </div>
    <form class="layui-form" style=" display: flex; flex-direction: column;">
        <div class="layui-side layui-bg-black" style="display: flex; flex-direction: column;">
            <div style="height: 94% ; display: flex;">
                <div class="layui-side-scroll layui-left-menu">
                </div>
            </div>

            <div layui-left-menu style="display: flex; height: 6% ;margin-right: 4px;">
                <i class="layui-icon layui-icon-search" style=" width: 30px;margin-top: 5px;font-size:24px ;"></i>
                <input name="search" type="text" placeholder="搜索..." class="layui-input layui-input-search"
                       autocomplete="off">
            </div>
            <button class="layui-btn layui-hide" lay-submit lay-filter="js-search-filter">搜索</button>
        </div>
    </form>

    <div class="layui-body">
        <div class="layui-tab" lay-filter="splayuiTab" id="top_tabs_box">
            <ul class="layui-tab-title" id="top_tabs">
                <li class="layui-this" id="splayuiHomeTabId" lay-id=""></li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"> <i class="fa fa-dot-circle-o"></i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-page-close="other"><i class="fa fa-window-close"></i> 关闭其他</a>
                        </dd>
                        <dd><a href="javascript:;" data-page-close="all"><i class="fa fa-window-close-o"></i> 关闭全部</a>
                        </dd>
                    </dl>
                </li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div id="splayuiHomeTabIframe" class="layui-tab-item layui-show">
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['element', 'layer', 'spLayui', 'form'], function () {
        var element = layui.element,
            layer = layui.layer,
            spLayui = layui.spLayui,
            form = layui.form;

        spUtil.ajax({
            url: '${request.contextPath}/admin/sys/user/current',
            type: 'GET',
            success: function (data) {
                var user = data.data;
                if (user) {
                    $('#js-user-name').text(user.name || user.username);
                    if (user.picId) {
                        $('#js-user-avatar').attr('src', '${request.contextPath}/admin/sys/user/avatar/' + user.picId);
                    } else {
                        var initial = user.name ? user.name.charAt(0) : (user.username ? user.username.charAt(0) : '?');
                        $('#js-user-avatar').attr('src', 'data:image/svg+xml;base64,' + btoa('<svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36"><circle cx="18" cy="18" r="18" fill="%23e6e6e6"/><text x="18" y="24" font-size="18" text-anchor="middle" fill="%23999999">' + initial + '</text></svg>'));
                    }
                }
            },
            errNoTip: true
        });

        spLayui.init('${request.contextPath}/admin/list/index/menu/tree');
        /**
         * 搜索后重新绘制菜单
         */
        form.on('submit(js-search-filter)', function (data) {

            if (data.field.search) {
                var urlPath = '${request.contextPath}/admin/list/index/menu/search/tree/' + data.field.search;
                itemNav =true;
            } else {
                var urlPath = '${request.contextPath}/admin/list/index/menu/tree';
                itemNav =false;
            }
            spUtil.ajax({
                url: urlPath,
                async: false,
                type: 'GET',
                // 是否显示 loading
                // showLoading: true,
                // 是否序列化参数
                serializable: false,
                // 参数
                data: {},
                success: function (data) {
                    spLayui.initMenu(data.data.menuInfo,itemNav);
                }
            });
            return false;
        });
    });
    //视频弹框
    function  notice(){
        layer.open({
            type: 1
            ,title: false //不显示标题栏
            ,closeBtn: true
            ,area: ['40%', '45%']
            ,move: '.mine-move'
            ,shade: 0.8
            ,scrollbar: false
            ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
            ,btnAlign: 'c'
            ,moveType: 1 //拖拽模式，0或者1
            ,content: '<iframe style="height: 99%;width: 100%" src="//player.bilibili.com/player.html?bvid=BV1k7411U7KX&page=1"  border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>'
            ,success: function(layero){

            }
        });
    }
</script>

<!-- ========== AI 客服（扣子 Coze）官方聊天窗 ==========
     令牌从后端 /client/ai/config 动态获取，避免暴露在前端 HTML/JS 中。
     后端读取 application-pro.yml 的 coze.token，便于运维更换与权限管理。 ========== -->
<script src="https://lf-cdn.coze.cn/obj/unpkg/flow-platform/chat-app-sdk/1.2.0-beta.20/libs/cn/index.js"></script>
<script>
  // 从后端拉取 botId / token / chatTitle，避免 PAT 令牌硬编码在前端
  fetch('${request.contextPath}/client/ai/config')
    .then(function (resp) { return resp.json(); })
    .then(function (res) {
      // 注意：MES 的 Result 类用 code=0 表示成功（不是 200）
      if (!res || res.code !== 0 || !res.data || !res.data.botId || !res.data.token) {
        console.error('[AI客服] 后端配置接口返回异常：', res);
        return;
      }
      var cfg = res.data;
      new CozeWebSDK.WebChatClient({
        config: {
          type: 'bot',          // 官方要求必填，类型为智能体
          botId: cfg.botId,
          isIframe: false      // 非 iframe 方式，避免小程序跨域限制
        },
        // 新版 ui 配置（替代旧版 componentProps），确保 header/close 按钮生效
        ui: {
          header: {
            isShow: true,        // 显示顶部标题栏
            isNeedClose: true    // 显示右上角 × 关闭按钮
          },
          asstBtn: {
            isNeed: true         // 显示右下角悬浮球
          },
          chatBot: {
            title: cfg.chatTitle || 'MES 智能客服'
          }
        },
        auth: {
          type: 'token',
          token: cfg.token,
          onRefreshToken: async function () { return cfg.token; }  // 官方示例用 async
        }
      });
    })
    .catch(function (err) {
      console.error('[AI客服] 加载配置失败，AI 客服不可用：', err);
    });
</script>
</body>
</html>