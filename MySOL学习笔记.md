# MySOL学习笔记

```
登录MySQL
	1.通过MySQL自带客户端
	//只限于root用户
	2.通过OS命令行
	mtsql-h 主机名 -p 端口号 -u 用户名 -p 密码
登出MySQL
	1.命令行
	exit
	2.快捷键
	ctrl+C
```

## SQL常见命令

```
1.查看所有DB
show databases;
2.打开DB
use 库名;
3.查看当前DB内所有表
show tables from 库名;
5.创建表
create table(
	列名 列类型
	列名 列类型
	……
);
6.查看表结构
desc 表名;
```

## 查看MySQL版本

```
1.服务端内
select version();
2.OS命令行
mysql --version
或者
mysql --V
```

## MySQL语言规范

1. 不区分大小写

2. 命令用;或者\g结尾

3. 可以换行，缩进

4. 注释

   单行注释：#文字

   		或者：-- 文字

   注意--和文字之间的空格

   多行注释：/\*文字\*/

## SQL语言分类

  - SQL(Structured Query Language) ：结构化查询语言
  - SQL是在关系数据库上执行数据操作、检索及维护所使用的标准语言，可以用来查询数据，操纵数据，定义数据，控制数据
  - 所有的数据库都使用相同或者相似的语言
  - SQL可分为：   
    - 数据定义语言（DDL）：Data Definition Language
    - 数据操纵语言（DML）：Data Manipulation Language
    - 事务控制语言（TCL）：Transaction Control Language
    - 数据查询语言（DQL）：Data Query Language
    - 数据控制语言（DCL）：Data Control Language

### 数据定义语言（DDL）

  - Data Definition Language
  - 用于建立，修改，删除数据库对象
  - 包括：   
    - Create：创建表或者其他对象的结构
    - Alter：修改表或者其他对象的结构
    - Drop：删除表或者其他对象的结构
    - TRUNCATE：删除表数据，保留表结构

### 数据操作语言（DML）

  - Data Manipulation Language
  - 用于改变数据表中的数据
  - 和事务相关，执行完后需要经过事务控制语句提交后才真正的将改变应用到数据库中
  - 包括：   
    - Insert：将数据插入到数据库表中
    - Update：更新数据库表中已存在的数据
    - Delete：删除数据库表中的数据

### 事务控制语言（TCL）

  - Tranction Control Language
  - 用来维护数据一致性的语句
  - 包括：   
    - Commit：提交，确认已经进行的数据改变
    - RollBack：回滚，取消已经进行的数据改变
    - SavePoint：保存点，使当前的事务可以回退到指定的保存点，便于取消部分改变

### 数据查询语言（DQL）

  - Data Query Language
  - 用来查询所需要的数据
  - Select语句

### 数据控制语言（DCL）

  - Data Control Language
  - 用于执行权限的授予和收回操作
  - 包括：   
    - GRANT：授予，用于给用户或角色授予权限
    - REVOKE：用于收回用户或者角色已有的权限
    - CREATE USER：创建用户

## 数据查询语言（DQL）

### 基础查询

``` mysql
USE employees;#要标记查询的库
#基础查询
SELECT 查询列表 FROM 表名 ;
/*特点：
		1.查询目标可以是表中字段，常量值，表达式，函数。
		2.查询结果位于虚拟表格。
*/

#1.查询单个字段
SELECT last_name FROM employees;
#2.查询多个字段
SELECT last_name,
        salary,
        email FROM employees;
#3.简易查询表内所有数据
SELECT * FROM employees;
#4.关键字冲突
    /*如果你需要查询名为SELECT的表
    SELECT SELECT FROM employees;显然不行
    你需要着重号`解决来，所以改写为*/
SELECT `SELECT` FROM employees;
#5.查询常量值
SELECT 100;
SELECT '100';
SELECT 'john';/*这是单引号*/
#6.查询表达式
SELECT 100*98；
SELECT 100%98；
#7.查询函数
SELECT VERSION()；
#8.为字段命名
	/*意义：
	1.便于理解
	2.区分重名字段*/
	#方式一（使用AS）
SELECT 目标 AS 名称 ,
		目标 AS 名称 ,
		目标 AS 名称 FROM 表名；
	#方式二（使用空格）
SELECT 目标 名称 ,
		目标 名称 ,
		目标 名称 FROM 表名；
	/*Eg.查询salary，显示结果为out put和out#put
	SELECT salary AS OUT put FROM employees;
	SELECT salary AS out#PUT FROM employees;显然不行
	因为out put含有非法空格和#，所以改写为*/
	SELECT salary AS "out put" FROM employees;
	SELECT salary AS "out#PUT" FROM employees;
	SELECT salary AS 'out put' FROM employees;
	SELECT salary AS 'out#PUT' FROM employees;
#8.去重
	/*用于查找所有目标种类*/
SELECT DISTINCT 目标 FROM 表名;
#9.+号的使用
	/*只能用于运算*/
SELECT 100+98；
	#>>198
SELECT '100'+98；
	#>>198
SELECT 'john'+98;
	#>>98
SELECT null+98;
	#>>null
```

#### 条件查询

```mysql
#基本语法
SELECT 查询列表
	FROM 表名
		WHERE 筛选条件;
```

**筛选条件大致分为三部分：**

1. 条件表达式

```mysql
#条件运算符
>	<	=	!=	<>	>=	<=
```

2. 逻辑表达式

```mysql
#基本逻辑运算符
&& AND;#与
|| OR; #或
! NOT; #非
```

3. 模糊查询

```mysql
#模糊查询表达式
	LIKE
	BETWEEN 'a' AND 'b'
	IN
	IS
	IS NOT
	IS null
	IS NOT null
#通配符
	%	#任意多个字符
	_	#任意单个字符
#安全等于
	<=>	#包含IS和=
```

*Eg.*

```mysql
USE myemployees;
#查询所有工资高于12000的员工信息
SELECT
       concat(first_name,' ',last_name) AS 名字,
       salary AS 工资
    FROM employees
    WHERE salary>12000;
    
#查询所有部门编号不为90的员工的姓和部门编号
SELECT
        last_name AS 姓,
        department_id AS 部门编号
    FROM employees
    WHERE department_id != 90;
    
#查询所有工资在10000~20000人的姓，工资和奖金
SELECT
       last_name AS 姓名,
        salary AS 工资,
       commission_pct*salary AS 奖金
    FROM employees
    WHERE salary>=10000||salary<=20000;
    
#查询部门编号不在90~110或者工资高于15000的员工信息
SELECT
        *
    FROM employees
    WHERE
          department_id<90
          OR
          department_id>110
          OR
          salary>15000;
          
#查询员工姓名内包含字符a的员工信息
SELECT
        *
    FROM employees
    WHERE 
          last_name LIKE '%a%'
    OR 
          first_name LIKE '%a%';
          
#查询员工名中第三个字符为n，第五个字符为l的员工名和工资
SELECT
        last_name AS 名,
        salary AS 工资
    FROM employees
    WHERE
            last_name LIKE '__n_l%';
            
#查询员工名里第二个字符为下划线的员工名
SELECT
        last_name AS 名
    FROM employees
    WHERE
            last_name LIKE '_\_%'
        AND #也可以像下面一样自定义转义字符
            last_name LIKE '_$_%' ESCAPE '$';
            
#查询所有工资在10000~20000人的员工信息（包含10000和20000）
SELECT
        *
    FROM employees
    WHERE
        salary BETWEEN 10000 AND 20000
    AND#简洁的语法糖
        salary BETWEEN 20000 AND 10000;
        
#查询员工工种编号指代IT_PROG,AD_VP,AD_PRES中某一个的员工名和工种编号
SELECT
        last_name AS 员工名,
        job_id AS 工种编号
FROM employees#IN括号内的数据必须相同或者兼容且不支持通配符
WHERE job_id IN('IT_PROG','AD_VP','AD_PRES');

#查询没有奖金的员工信息
SELECT
        *
FROM employees
WHERE commission_pct IS NULL ;
```

#### 排序查询

```mysql
#基本排序语法
SELECT
		*
FROM 查询列表
WHERE 筛选条件#可选
ORDER BY 排序列表 升降序#ASC升序，DESC降序
```

Eg.

```mysql
#查询员工信息，按工资降序排列
SELECT
        *
FROM employees
ORDER BY salary DESC;

#按入职时间先后排列部门编号大于等于90的员工的员工名和入职时间
SELECT
        last_name AS 员工名,
        hiredate AS 入职时间
FROM employees
WHERE department_id>=90
ORDER BY hiredate ASC;

#按年薪高低排列员工信息和年薪【按表达式查询】
SELECT
        * ,
       (salary*12*(1+IFNULL(commission_pct,0)))/1000 AS 年薪（K）
FROM employees
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) ASC ;

SELECT
        * ,
       salary*12*(1+IFNULL(commission_pct,0)) AS 年薪
FROM employees/*别名也可以*/
ORDER BY 年薪 DESC;

#排列员工名，年薪，部门编号，按年薪升序，按部门降序；
SELECT
        last_name AS 员工名,
        department_id AS 部门ID,
        salary*12*(1+IFNULL(commission_pct,0)) AS 年薪
FROM employees
ORDER BY department_id DESC ,salary*12*(1+IFNULL(commission_pct,0)) ASC;
```

### 单行函数

```mysql
#VERSION函数查看MySQL版本号
 SELECT VERSION();

#DATABASE函数查看当前数据库
SELECT DATABASE();

#USER查看当前用户
SELECT USER();
```



#### 字符函数

```mysql
#LENGTH函数获取字节数
SELECT LENGTH('jojo');
SELECT LENGTH('乔乔');/*查看字符集*/
	SHOW VARIABLES LIKE '%char%';

#CONCAT函数拼接字符集
SELECT CONCAT(first_name,'_',last_name)
FROM employees;

#UPPER/LOWER函数将字符大写/小写化
SELECT UPPER('jojo');
SELECT LOWER('JOJO')；

#SUBSTR(ING)函数截取字符串（MySQL的计数从1开始）
SELECT SUBSTR('环银河系漱口爆破爽',5) OutPut;
SELECT SUBSTRING('环银河系漱口爆破爽',5,2) OutPut;/*SUBSTRING(字符串,始位,长度)*/

#INSTR函数返回检索字符的第一个索引
SELECT INSTR('WhouldYoukindlyPlease','Kindly') AS OutPut;

#TRIM函数消去字符串前后空格或其他字符串
SELECT  TRIM('    理解之枪    ');
SELECT  TRIM('a' FROM 'aaaaaa洛克希德·马丁aaaaa');
SELECT  TRIM('force' FROM 'forceforceforceforce原力forceforceforceforce');

#LPAD/RPAD函数用指定字符串将字符串填充左/右填充至指定长度
SELECT LPAD('Box',10,'Bi');
SELECT RPAD('Bi',10,'Box');
SELECT LPAD('Box',2,'Bi');/*长度不足削减原字符串*/

#REPLACE函数将指定字符替换为指定的其他字符
SELECT REPLACE('InterYes!InterYes!','Inter','Amd');
```

Eg.

```mysql
#将姓大写，名小写，拼接
SELECT CONCAT(UPPER(first_name),'-',LOWER(last_name))
FROM employees;/*函数可以相互嵌套*/

#将姓名首字符大写，拼接
SELECT CONCAT(
    UPPER(
        SUBSTR(
            first_name,1,1
            )
        ),
    LOWER(
        SUBSTR(first_name,2
            )
        ),
    '-',
    UPPER(
        SUBSTR(
            last_name,1,1
            )
        ),
    LOWER(
        SUBSTR(
            last_name,2
            )
        )
    )
FROM employees;
```

#### 数学函数

```mysql
#ROUND函数四舍五入指定变量
SELECT ROUND(1.625);
SELECT ROUND(1.625,2);/*ROUND(截尾变量,保留位数)*/

#CEIL/FLOOR函数将变量向上/下取整至整数
SELECT CEIL(1.625);/*【SELECT CEIL(1.00);】>>1*/
SELECT FLOOR(1.625);

#TRUNCATE函数截断至小数点后指定位
SELECT TRUNCATE(1.625,1);

#MOD函数取模指定变量
SELECT MOD(10,3);/*【MOD(a,b)】<=>【a%b】*/
```

#### 日期函数

```mysql
#NOW函数返回日期
SELECT NOW();

#CURDATE函数返回系统年月日
SELECT CURDATE();

#CURTIME函数返回系统时间
SELECT CURTIME();

#YEAR/MONTH/MONTHNAME/DAY/HOUR/MINUTE/SECOND函数截出日期的年/月/日/小时/分钟/秒部分
SELECT YEAR(NOW());/*【YEAR(年-月-日 小时:分钟:秒)】可只保留Date，下同*/
SELECT MONTH(NOW());/*输出月编号*/
SELECT MONTHNAME(NOW());/*输出月名*/
SELECT DAY(NOW());
SELECT HOUR(NOW());/*【YEAR(年-月-日 小时:分钟:秒)】可只保留Time，下同*/
SELECT MINUTE(NOW());
SELECT SECOND(NOW());

#STR_TO_DATE函数将指定日期格式文本转化为日期
SELECT STR_TO_DATE('2000-12-13','%Y-%m-%d');

#DATE_FORMAT函数将日期转化为指定格式文本
SELECT DATE_FORMAT(NOW(),'%Y-%m-%d');
```

*日期格式标识符*

| 标识符 | 含义                  |
| ------ | --------------------- |
| %Y     | 四位数的年份          |
| %y     | 两位数的年份          |
| %m     | 月份（01,02……11,12）  |
| %c     | 月份（1,2……11,12）    |
| %d     | 日（01,02……）         |
| %H     | 小时（24小时制）      |
| %h     | 小时（12小时制）      |
| %i     | 分钟（00，01……58,59） |
| %s     | 秒（00,01^58,59）     |

Eg.

```mysql
#按照月-日 年的格式查询4-3 1992入职的员工
SELECT
        *
FROM employees
WHERE hiredate= STR_TO_DATE('4-3 1992','%m-%d %Y');

#查询有奖金的员工的员工名，奖金，【x年/x月/x日】格式的入职日期
SELECT
        last_name AS 员工名,
       commission_pct*salary AS 奖金,
       DATE_FORMAT(hiredate,'%Y年/%m月/%d日')
FROM employees
WHERE commission_pct IS NOT NULL;
```

#### 流程控制函数

```mysql
#IF函数判断表达式返回两个指定结果之一
SELECT  IF(1>2,'1>2','1<=2');

#CASE语句按变量分别输出结果
CASE 变量名
	WHEN 变量可能值
		THEN 结果
	WHEN 变量可能值
		THEN 结果
	ELSE 其他结果
		END
		
#CASE语句进行多级条件判断
CASE
	WHEN 表达式
		THEN 语句
	WHEN 表达式
		THEN 语句
	ELSE 表达式
		END
```

Eg.

```mysql
#根据有无奖金输出员工名和奖金判断结果（‘有奖金！’或‘无奖金’）
SELECT
        last_name,
       IF(commission_pct IS NULL ,'有奖金！','无奖金')
FROM employees ;

#用CASE语句输出员工名和Pur，Hum，Shi三个部门的名称和Other部门
SELECT last_name,
       department_id ,
CASE department_id
            WHEN 30
                THEN 'Pur'
            WHEN 40
                THEN 'Hum'
            WHEN 50
                THEN 'Shi'
        ELSE 'Other'
    END
FROM employees;

#查询员工名和等级，如果工资大于20000，返回A，如果工资大于15000，返回B，如果工资大于10000，返回C，如果工资小于10000，返回D
SELECT last_name,
       salary,
CASE
        WHEN salary > 20000
            THEN 'A'
        WHEN salary > 15000
            THEN 'B'
        WHEN salary > 10000
            THEN 'C'
        ELSE 'D'
            END
FROM employees;
```

### 分组函数

*又称为聚合函数，统计函数，多行函数*

**分类：**SUM（求和），AVG（平均值），MAX（最大值），MIN（最小值），COUNT（计算个数）

#### 简易用法

```mysql
#SUM函数对变量求和
SELECT SUM(salary) FROM employees ;

#AVG函数求变量平均值
SELECT AVG(salary) FROM employees ;

#MAX/MIN函数求变量最大值/最小值
SELECT MAX(salary) FROM employees ;
SELECT MIN(salary) FROM employees ;

#COUNT函数对变量求和
SELECT COUNT(salary) FROM employees ;
```

#### 特点

1. 支持类型

**SUM，AVG：**只有int

**MAX，MIN，COUNT：**任意类型

2. **以上**多行函数都**忽略null**

3. 和distinct搭配完成去重运算

```mysql
#DISTINCT关键字去重
SELECT COUNT(DISTINCT salary) FROM employees ;
```

4. 和分组字段查询的字段要求是GIOUP BY后的字段

```mysql
#用GIOUP BY分组查询结果
SELECT salary, SUM(salary)
FROM employees
GROUP BY salary;
```

#### COUNT函数的详细使用

```mysql
#计数指定表列不为空的行数
SELECT COUNT(列名) FROM 库名 ;
#计数表内任意拥有不为空项的行
SELECT COUNT(*) FROM 库名 ;
#在表内添加指定参数列并对其进行计数
SELECT COUNT(参数) FROM 库名 ;
```

*效率分析：*

​	**MYISAM存储引擎：**【COUNT(*)】的效率最高

​	**INNODB存储引擎：**【COUNT(*)和COUNT(1)】的效率都最高

### 分组查询

```mysql
#按照指定参数分组
GROUP BY 参数
#分组后筛选
HAVING 表达式
```

Eg.

```mysql
#查询每个工种的最高工资
SELECT MAX(salary) AS 最高工资,
       job_id
FROM employees
GROUP BY job_id;

#查询每个位置上的部门个数
SELECT COUNT(*) AS 部门个数,
       location_id
FROM departments
GROUP BY location_id;

#筛选出邮箱包含a的每个部门的平均工资
SELECT AVG(salary)
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#查询有奖金的每个领导手下员工的最高工资
SELECT MAX(salary) AS 最高工资 ,
       last_name,
       manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#查询所有员工个数大于二的
SELECT COUNT(*),department_id
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

#查询每个工种有奖金的员工工资大于12000的工种编号和最高工资
SELECT  job_id,MAX(salary)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING MAX(salary)>12000 ;

#查询每个领导编号大于102的每个领导手下员工最低工资大于5000的领导编号及其最低工资
SELECT manager_id,
       MIN(salary)
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING MIN(salary)>5000;
```
