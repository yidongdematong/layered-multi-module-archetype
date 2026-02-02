
## [1.0.1] - 2026-02-02
### 新增
- 新增自定义Java版本参数`javaVersion`，支持命令行`-DjavaVersion=11/17`指定，缺省默认值为Java 8
- 完善`archetype-metadata.xml`必选属性声明：`groupId/artifactId/version/package/rootArtifactId/javaVersion`

### 修复
- 修复Archetype集成测试报错：补充`it-basic`测试配置，添加缺失`rootArtifactId`、`javaVersion`属性
- 修正原型自身pom.xml插件声明，补全groupId与执行goal，修复打包与安装异常
- 修正`archetype-metadata.xml`根目录空路径问题，使用标准`.`表示根目录

### 优化
- 统一全局文件编码为UTF-8，避免中文乱码
- 抽离Maven插件版本到properties，便于统一维护与升级
- 多模块目录命名规范：使用`__rootArtifactId__`占位符，支持子模块前缀自定义

### 文档
- 完善README快速使用命令与参数说明

## [1.0.2] - 2026-02-02  
### 新增
- 新增自定义编译插件版本参数 compilerPluginVersion，支持命令行 -DcompilerPluginVersion=3.11.0/3.13.0 指定，缺省默认值为 3.11.0
- 实现子模块间标准分层依赖：controller → service → repository → model + common，确保架构清晰、无循环依赖

### 修复
- 修复生成项目中插件版本未生效问题：在父 POM 的 <pluginManagement> 中显式绑定 maven-compiler-plugin 版本
- 修正子模块依赖缺失：各子模块 pom.xml 补全对内部模块（如 common, model 等）的声明式依赖

### 优化
- 统一编译插件管理：将 maven-compiler-plugin 版本纳入 ，由父 POM 集中控制，子模块无需重复声明
- 插件版本与 Java 版本解耦：compilerPluginVersion 独立可配，适配不同 JDK 场景（如 JDK 8 用 3.8.1，JDK 17 用 3.11.0+）
- 依赖声明标准化：所有内部模块依赖均通过 <dependencyManagement> 管理版本，子模块仅需声明 groupId + artifactId

### 文档
- 更新 README 示例命令，增加 -DcompilerPluginVersion 参数说明及典型使用场景