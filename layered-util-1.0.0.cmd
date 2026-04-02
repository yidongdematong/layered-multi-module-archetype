@echo off
:: 强制关闭所有命令回显（核心修复：仅这一行就屏蔽所有set/echo底层输出）
@echo off > nul 2>&1
:: 强制UTF-8编码，同时关闭chcp的输出
chcp 65001 > nul 2>&1
:: 启用延迟扩展，确保变量正常解析
setlocal enabledelayedexpansion

:: ====================== 固定参数（自定义原型，不可修改） ======================
set ARCHETYPE_GROUP_ID=io.github.bobby
set ARCHETYPE_ARTIFACT_ID=layered-multi-module-archetype
set ARCHETYPE_VERSION=1.0.0

:: ====================== 可配置参数默认值（安静模式使用） ======================
set DEFAULT_GROUP_ID=com.demo
set DEFAULT_ARTIFACT_ID=demo
set DEFAULT_VERSION=1.0.0
set DEFAULT_ARCHETYPE_CATALOG=local
set DEFAULT_JAVA_VERSION=17
set DEFAULT_COMPILER_PLUGIN_VERSION=3.11.0
set DEFAULT_INTERACTIVE_MODE=false

:: ====================== 脚本标题（拆分输出行，避免解析错误） ======================
echo.
echo ==============================================
echo           分层多模块WMS项目生成工具
echo ==============================================
echo 固定原型信息
REM "拆分每行输出，避免长字符触发解析Bug"
echo 原型GroupId：!ARCHETYPE_GROUP_ID!
echo 原型ArtifactId：!ARCHETYPE_ARTIFACT_ID!
echo 原型版本：!ARCHETYPE_VERSION!
echo ==============================================
echo.

:: ====================== 选择运行模式 ======================
echo 请选择运行模式:
echo 1 - 安静模式（使用默认参数快速生成）
echo 2 - 手动模式（自定义输入可配置参数）
set /p "MODE=请输入模式编号（1/2）:"

:: 模式校验
if not "!MODE!"=="1" if not "!MODE!"=="2" (
    echo 错误：无效的模式编号！只能输入1或2
    pause
    exit /b 1
)

:: ====================== 初始化可配置参数 ======================
if "!MODE!"=="1" (
    echo.
    echo 已选择【安静模式】，使用以下默认参数：
    echo ----------------------------------------------
    echo 项目GroupId: !DEFAULT_GROUP_ID!
    echo 项目ArtifactId：!DEFAULT_ARTIFACT_ID!
    echo 项目版本：!DEFAULT_VERSION!
    echo 原型目录：!DEFAULT_ARCHETYPE_CATALOG!
    echo Java版本：!DEFAULT_JAVA_VERSION!
    echo 编译器插件版本：!DEFAULT_COMPILER_PLUGIN_VERSION!
    echo 交互模式：!DEFAULT_INTERACTIVE_MODE!
    echo ----------------------------------------------
    
    set "GROUP_ID=!DEFAULT_GROUP_ID!"
    set "ARTIFACT_ID=!DEFAULT_ARTIFACT_ID!"
    set "VERSION=!DEFAULT_VERSION!"
    set "ARCHETYPE_CATALOG=!DEFAULT_ARCHETYPE_CATALOG!"
    set "JAVA_VERSION=!DEFAULT_JAVA_VERSION!"
    set "COMPILER_PLUGIN_VERSION=!DEFAULT_COMPILER_PLUGIN_VERSION!"
    set "INTERACTIVE_MODE=!DEFAULT_INTERACTIVE_MODE!"
) else (
    echo.
    echo 已选择【手动模式】，逐个输入参数（回车用默认值）：
    echo ----------------------------------------------
    
    :: 手动输入项目GAV参数
    set /p "GROUP_ID=项目GroupId（默认：!DEFAULT_GROUP_ID!）："
    if "!GROUP_ID!"=="" set "GROUP_ID=!DEFAULT_GROUP_ID!"

    set /p "ARTIFACT_ID=项目ArtifactId（默认：!DEFAULT_ARTIFACT_ID!）："
    if "!ARTIFACT_ID!"=="" set "ARTIFACT_ID=!DEFAULT_ARTIFACT_ID!"

    set /p "VERSION=项目版本（默认：!DEFAULT_VERSION!）："
    if "!VERSION!"=="" set "VERSION=!DEFAULT_VERSION!"

    :: 手动输入其他可配置参数
    set /p "ARCHETYPE_CATALOG=原型目录（默认：!DEFAULT_ARCHETYPE_CATALOG!）："
    if "!ARCHETYPE_CATALOG!"=="" set "ARCHETYPE_CATALOG=!DEFAULT_ARCHETYPE_CATALOG!"

    set /p "JAVA_VERSION=Java版本（默认：!DEFAULT_JAVA_VERSION!）："
    if "!JAVA_VERSION!"=="" set "JAVA_VERSION=!DEFAULT_JAVA_VERSION!"

    set /p "COMPILER_PLUGIN_VERSION=编译器插件版本（默认：!DEFAULT_COMPILER_PLUGIN_VERSION!）："
    if "!COMPILER_PLUGIN_VERSION!"=="" set "COMPILER_PLUGIN_VERSION=!DEFAULT_COMPILER_PLUGIN_VERSION!"

    set /p "INTERACTIVE_MODE=交互模式（默认：!DEFAULT_INTERACTIVE_MODE!）："
    if "!INTERACTIVE_MODE!"=="" set "INTERACTIVE_MODE=!DEFAULT_INTERACTIVE_MODE!"

    echo ----------------------------------------------
    echo 已确认参数：
    echo 项目GroupId：!GROUP_ID!
    echo 项目ArtifactId：!ARTIFACT_ID!
    echo 项目版本：!VERSION!
    echo 原型目录：!ARCHETYPE_CATALOG!
    echo Java版本：!JAVA_VERSION!
    echo 编译器插件版本：!COMPILER_PLUGIN_VERSION!
    echo 交互模式：!INTERACTIVE_MODE!
    echo ----------------------------------------------
)

:: ====================== 输入项目目录 ======================
echo.
set /p "PROJECT_DIR=请输入项目创建目录（例：D:\projects）："

:: 目录校验
if "!PROJECT_DIR!"=="" (
    echo 错误：项目目录不能为空！
    pause
    exit /b 1
)
if not exist "!PROJECT_DIR!" (
    echo 提示：目录 !PROJECT_DIR! 不存在，正在创建...
    md "!PROJECT_DIR!" > nul 2>&1
    if errorlevel 1 (
        echo 错误：创建目录失败，请检查权限！
        pause
        exit /b 1
    )
)

:: ====================== 执行Maven命令 ======================
echo.
echo 开始生成项目...
echo 目标目录：!PROJECT_DIR!
echo 固定原型：!ARCHETYPE_GROUP_ID!/!ARCHETYPE_ARTIFACT_ID!/!ARCHETYPE_VERSION!
echo ==============================================
cd /d "!PROJECT_DIR!" || (
    echo 错误：无法切换到目录 !PROJECT_DIR!
    pause
    exit /b 1
)

:: 执行Maven命令（拆分换行，避免解析错误）
mvn archetype:generate ^
-DarchetypeGroupId=!ARCHETYPE_GROUP_ID! ^
-DarchetypeArtifactId=!ARCHETYPE_ARTIFACT_ID! ^
-DarchetypeVersion=!ARCHETYPE_VERSION! ^
-DgroupId=!GROUP_ID! ^
-DartifactId=!ARTIFACT_ID! ^
-Dversion=!VERSION! ^
-DarchetypeCatalog=!ARCHETYPE_CATALOG! ^
-DjavaVersion=!JAVA_VERSION! ^
-DcompilerPluginVersion=!COMPILER_PLUGIN_VERSION! ^
-DinteractiveMode=!INTERACTIVE_MODE!

:: ====================== 结果反馈 ======================
if errorlevel 1 (
    echo.
    echo ==============================================
    echo 错误：项目生成失败！请检查：
    echo 1. Maven环境（执行mvn -v验证）
    echo 2. 本地原型是否存在（!ARCHETYPE_GROUP_ID!/!ARCHETYPE_ARTIFACT_ID!/!ARCHETYPE_VERSION!）
    echo 3. 目录读写权限
    echo ==============================================
    pause
    exit /b 1
) else (
    echo.
    echo ==============================================
    echo 成功：项目已生成到 !PROJECT_DIR!\!ARTIFACT_ID!
    echo ==============================================
)

pause
endlocal