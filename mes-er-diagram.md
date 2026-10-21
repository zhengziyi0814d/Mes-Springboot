# MES 制造执行系统 - 数据库 ER 图

## 一、系统管理模块（用户 / 角色 / 权限）

```mermaid
erDiagram
    sp_sys_department ||--o{ sp_sys_department : "parent_id 自关联(父子部门)"
    sp_sys_user ||--o{ sp_sys_user_role : "一个用户可多个角色"
    sp_sys_role ||--o{ sp_sys_user_role : "一个角色可分配给多个用户"
    sp_sys_role ||--o{ sp_sys_role_menu : "一个角色可配多个菜单"
    sp_sys_menu ||--o{ sp_sys_role_menu : "一个菜单可被多角色使用"
    sp_sys_menu ||--o{ sp_sys_menu : "parent_id 自关联(父子菜单)"
    sp_sys_dict ||--o{ sp_sys_dict : "parent_id 自关联(父子字典)"

    sp_sys_user {
        varchar id PK "用户ID"
        varchar name "姓名"
        varchar username "用户名(唯一)"
        varchar password "密码"
        varchar dept_id FK "所属部门"
        varchar mobile "手机号"
        char sex "性别"
    }

    sp_sys_role {
        varchar id PK "角色ID"
        varchar name "角色名称(唯一)"
        varchar code "角色编码(唯一)"
        varchar descr "角色描述"
    }

    sp_sys_menu {
        varchar id PK "菜单ID"
        varchar code "菜单编码"
        varchar name "菜单名称"
        varchar parent_id FK "父菜单ID"
        varchar type "类型(目录/菜单/按钮)"
        varchar permission "权限标识"
    }

    sp_sys_department {
        varchar id PK "部门ID"
        varchar parent_id FK "父部门ID"
        varchar name "部门名称"
        int sort_num "排序"
    }

    sp_sys_dict {
        varchar id PK "字典ID"
        varchar name "标签名"
        varchar value "数据值"
        varchar type "类型"
        varchar parent_id FK "父字典ID"
    }

    sp_sys_user_role {
        varchar id PK "主键"
        varchar user_id FK "用户ID"
        varchar role_id FK "角色ID"
    }

    sp_sys_role_menu {
        varchar id PK "主键"
        varchar role_id FK "角色ID"
        varchar menu_id FK "菜单ID"
    }
```

## 二、基础数据模块（物料 / 工厂 / 线体）

```mermaid
erDiagram
    sp_materile }o--|| sp_flow : "materile.flow_id 指向流程"

    sp_materile {
        varchar id PK "物料ID"
        varchar materiel "物料编码"
        varchar materiel_desc "物料描述"
        varchar mat_type "物料类型(FG成品/PG半成品)"
        varchar unit "基本单位"
        varchar flow_id FK "关联工艺流程ID"
        varchar materiel_source "物料来源(自制/外购)"
        int demand_lead_time "需求提前期(天)"
        decimal safety_stock "安全库存"
    }

    sp_factroy {
        varchar id PK "工厂ID"
        varchar factory "工厂名称"
        varchar factory_desc "工厂描述"
    }

    sp_work_shop {
        varchar id PK "车间ID"
        varchar work_shop "车间名称"
        varchar work_shop_desc "车间描述"
    }

    sp_line {
        varchar id PK "线体ID"
        varchar line "线体名称"
        varchar line_desc "线体描述"
        varchar process_section "工序段代号"
    }

    sp_part {
        varchar id PK "零部件ID"
        varchar part_no "零部件编号(唯一)"
        varchar part_name "零部件名称"
        varchar remark "备注"
    }
```

## 三、技术管理核心模块（BOM / 工艺路线 / 工序）— 最复杂

```mermaid
erDiagram
    sp_bom ||--o{ sp_bom_item : "一个BOM有多个子项"
    sp_bom ||--o{ sp_bom_oper_relation : "一个BOM有多个工序关联"
    sp_bom_oper_relation ||--o{ sp_oper_content : "一个工序关联可有多条工艺内容"
    sp_flow ||--o{ sp_flow_oper_relation : "一个流程包含多道工序"
    sp_oper ||--o{ sp_flow_oper_relation : "工序可被多个流程引用"
    sp_oper ||--o{ sp_bom_oper_relation : "工序可被多个BOM引用"
    sp_oper_content ||--o{ sp_oper_equipment : "工艺内容所需设备"
    sp_oper_content ||--o{ sp_oper_material_list : "工艺内容备料清单"
    sp_oper_content ||--o{ sp_oper_tech_doc : "工艺内容文档"

    sp_bom {
        varchar id PK "BOM主表ID"
        varchar bom_code "BOM编号"
        varchar materiel_code FK "物料编码(关联sp_materile)"
        varchar version_number "版本号"
        varchar state "BOM状态(creat/pass)"
        varchar factory "工厂"
    }

    sp_bom_item {
        varchar id PK "BOM子项ID"
        varchar bom_head_id FK "所属BOM ID"
        varchar materiel_item_code "子项物料编码"
        decimal item_num "用量"
        varchar node_type "节点类型(1零部件/2物料)"
        int node_level "层级(0产品/1半成品/2单元/3物料)"
        varchar node_code "节点编号"
    }

    sp_bom_oper_relation {
        varchar id PK "主键"
        varchar bom_id FK "BOM ID"
        varchar bom_item_id FK "BOM子项ID"
        varchar oper_id FK "工序ID"
        varchar node_name "节点名称"
        int node_level "节点层级"
        int sort_num "排序号"
        varchar is_locked "是否锁定"
    }

    sp_flow {
        varchar id PK "流程ID"
        varchar flow "流程代码"
        varchar flow_desc "流程描述"
        varchar process "流程绘制(如 A→B→C)"
    }

    sp_flow_oper_relation {
        varchar id PK "主键"
        varchar flow_id FK "流程ID"
        varchar per_oper_id FK "前道工序ID"
        varchar oper_id FK "当前工序ID"
        varchar next_oper_id FK "下道工序ID"
        int sort_num "排序号"
        varchar oper_type "工序类型(首道/末道)"
    }

    sp_oper {
        varchar id PK "工序ID"
        varchar oper "工序编码(如 ASY-01)"
        varchar oper_desc "工序描述(装配工序)"
        varchar work_center "加工单元编码"
        decimal oper_time "工序工时(h)"
        decimal produce_cycle "制造周期(h)"
    }

    sp_oper_content {
        varchar id PK "工艺内容ID"
        varchar bom_oper_relation_id FK "BOM工序关系ID"
        varchar bom_id FK "BOM ID"
        varchar oper_id FK "工序ID"
        text oper_content "工序内容(操作说明)"
        text tech_requirement "技术要求"
        text oper_requirement "工序要求"
        varchar is_need_inspect "是否需检验"
        varchar status "状态(draft/completed)"
    }

    sp_oper_equipment {
        varchar id PK "主键"
        varchar oper_content_id FK "工艺内容ID"
        varchar equipment_code "设备编码"
        varchar equipment_name "设备名称"
        decimal require_qty "需求数量"
    }

    sp_oper_material_list {
        varchar id PK "主键"
        varchar oper_content_id FK "工艺内容ID"
        varchar materiel_code "物料编码"
        varchar materiel_name "物料名称"
        decimal require_qty "需求数量"
    }

    sp_oper_tech_doc {
        varchar id PK "主键"
        varchar oper_content_id FK "工艺内容ID"
        varchar doc_desc "文档描述"
        text doc_images "文档图片(JSON)"
        text doc_files "文档附件(JSON)"
    }
```

## 四、订单与计划模块（从物料到生产）

```mermaid
erDiagram
    sp_order }o--|| sp_flow : "order.flow_id 指定生产流程"
    sp_order }o--|| sp_materile : "order.materiel 指定生产物料"
    sp_material_demand_plan }o--|| sp_order : "demand.order_code 关联订单"
    sp_material_demand_plan }o--|| sp_materile : "demand.materiel_code 关联物料"

    sp_order {
        varchar id PK "工单ID"
        varchar order_code "工单编号"
        varchar order_description "工单描述"
        int qty "工单数量"
        varchar order_type "订单类型(P量产/A验证/F返工)"
        varchar flow_id FK "流程ID"
        varchar materiel FK "物料编码"
        datetime plan_start_time "计划开始时间"
        datetime plan_end_time "计划结束时间"
        tinyint statue "状态(1创建/2进行中/3结束/4终结)"
    }

    sp_material_demand_plan {
        varchar id PK "物料需求ID"
        varchar order_code FK "订单编码"
        varchar product_serial_no "产品序列号"
        varchar materiel_code FK "物料编码"
        varchar work_center_code "工作中心编码"
        decimal require_qty "需求数量"
        varchar unit "单位"
        datetime demand_date "需求日期"
        varchar delivery_status "交货状态"
        decimal net_require_qty "净需求数量"
    }
```

## 五、完整全景 ER 图

```mermaid
erDiagram
    %% ===== 系统管理 =====
    sp_sys_user ||--o{ sp_sys_user_role : ""
    sp_sys_role ||--o{ sp_sys_user_role : ""
    sp_sys_role ||--o{ sp_sys_role_menu : ""
    sp_sys_menu ||--o{ sp_sys_role_menu : ""
    sp_sys_department ||--o{ sp_sys_user : ""

    %% ===== 物料/工艺核心 =====
    sp_materile }o--|| sp_flow : "materile.flow_id"
    sp_flow ||--o{ sp_flow_oper_relation : ""
    sp_oper ||--o{ sp_flow_oper_relation : ""
    sp_bom ||--o{ sp_bom_item : ""
    sp_bom ||--o{ sp_bom_oper_relation : ""
    sp_oper ||--o{ sp_bom_oper_relation : ""
    sp_bom_oper_relation ||--o{ sp_oper_content : ""
    sp_oper_content ||--o{ sp_oper_equipment : ""
    sp_oper_content ||--o{ sp_oper_material_list : ""
    sp_oper_content ||--o{ sp_oper_tech_doc : ""

    %% ===== 订单计划 =====
    sp_order }o--|| sp_flow : "order.flow_id"
    sp_order }o--|| sp_materile : "order.materiel"
    sp_material_demand_plan }o--|| sp_order : "demand.order_code"
    sp_material_demand_plan }o--|| sp_materile : "demand.materiel_code"
```

---

## 关系图符号说明

| 符号 | 含义 |
|------|------|
| `||--o{` | 一对多（左边1个，右边多个） |
| `}o--||` | 多对一（右边1个，左边多个） |
| 主键 `PK` | 表里用来唯一标识一条记录的字段 |
| 外键 `FK` | 指向另一张表主键的字段，用于建立表之间的关联 |
