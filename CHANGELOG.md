
## [1.0.1-SNAPSHOT] - 2026-02-02
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