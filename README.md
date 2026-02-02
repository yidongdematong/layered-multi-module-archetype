# layered-multi-module-archetype

快速生成标准化分层多模块 Java 项目的 Maven 原型，纯架构骨架无内置依赖，职责解耦，贴合企业级开发规范
## 核心特性
- 规范分层架构：严格遵循 Controller → Service → Repository → Model 分层设计，贴合企业开发习惯
- 标准化多模块：解耦拆分为 common/controller/model/repository/service，模块职责单一、边界清晰
- 统一依赖管理：父 POM 预留集中管控依赖版本能力，从根源避免版本冲突，可按需灵活扩展
- 一键快速生成：通过 mvn archetype:generate 命令，无需手动搭建目录，直接生成标准化项目骨架
- 无侵入扩展：纯架构原型不内置任何技术栈依赖，可自由集成 Spring Boot/MyBatis 等任意框架
- 分支化扩展：基础主干为纯架构骨架，技术栈集成版本（如 Spring Boot）将在后续分支中提供
##  快速开始
1. 安装原型到本地 Maven 仓库
```
# 克隆本项目到本地
git clone https://github.com/yidongdematong/layered-multi-module-archetype.git
# 进入项目根目录
cd layered-multi-module-archetype
# 安装原型到本地（自动编译并注册到Maven本地仓库）
mvn clean install
```

2. 一键生成分层多模块项目
   执行以下命令，按控制台提示输入自定义项目 GAV 参数（groupId/artifactId/version），即可生成标准化项目骨架：
 ```
# 完整参数版（显式指定所有参数）
mvn archetype:generate \
  -DarchetypeGroupId=io.github.bobby \          # 你的原型组ID
  -DarchetypeArtifactId=layered-multi-module-archetype \  # 你的原型构件ID
  -DarchetypeVersion=1.0.0-SNAPSHOT \           # 你的原型版本
  -DgroupId=com.demo \                          # 项目组ID（必填，替换为你的实际值）
  -DartifactId=my-project \                     # 父项目名称（必填，替换为你的实际值）
  -Dversion=1.0.0-SNAPSHOT \                    # 项目版本（可选，默认就是这个值，可省略）
  -Dpackage=com.demo.myproject \                # 基础包名（可选，默认=${groupId}.${artifactId}，可省略）
  -DrootArtifactId=my-project \                 # 子模块前缀（可选，默认=${artifactId}，可省略）
  -DjavaVersion=8 \                             # Java版本（可选，默认8，可省略）
  -DinteractiveMode=false                       # 非交互式，无需手动回车确认
```
 
  ##  实际生成的标准项目架构
   生成的项目遵循约定优于配置原则，目录结构标准化，子模块自动拼接根项目 ArtifactId，纯架构无内置依赖：
  ```    
  your-project/  # 自定义的根项目名（执行命令时输入的artifactId）
   ├── pom.xml                # 父POM：统一管理依赖、版本、插件，所有子模块继承，预留依赖管控能力
   ├── your-project-common/   # 通用工具模块：工具类、全局常量、通用枚举、全局异常定义、公共工具方法
   ├── your-project-model/    # 数据模型模块：实体类（Entity）、请求DTO、响应VO、数据传输对象等
   ├── your-project-repository/ # 数据访问模块：数据访问层接口与实现（DAO/Mapper/Repository）
   ├── your-project-service/  # 业务逻辑模块：业务服务接口、接口实现类，封装核心业务逻辑
   └── your-project-controller/ # 接口层模块：对外暴露的API接口（Controller）、接口参数校验、请求转发
   ```
## 核心说明
### 原型定位
   本原型主干为纯架构骨架，仅提供标准化的分层多模块目录结构和统一的 Maven 依赖管理规范，不内置任何第三方技术栈依赖（如 Spring Boot、MyBatis、Logback 等），最大程度保证扩展性，适配不同技术栈选型需求。
   
### 扩展方式
   按需引入依赖：可直接在父 POM 或各子模块 POM 中，灵活引入所需技术栈依赖，无任何侵入性
   分支化集成：后续将在项目不同分支中，提供已集成主流技术栈的版本（如spring-boot分支），开箱即用
   自定义扩展：基于标准化结构，可自由新增模块、调整分层，完全适配个性化业务需求
### 开源许可证
   本项目采用Apache License 2.0 开源许可证，允许商业使用、修改、分发，仅需保留版权声明。



[yidongdematong@gmail.com](yidongdematong@gmail.com):联系我