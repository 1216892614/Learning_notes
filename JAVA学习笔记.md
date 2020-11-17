# JAVA学习笔记

## 1.基本的输入输出

> - java是纯面向对象的语言，连主函数都写在一个类中，java中没有指针
> - java 用类声明对象的时候 ，实际上，该对象只是一个能够引用对象的简单变量。该声明要创建一个对象的实际的物理拷贝，并把对于该对象的引用赋给该变量。这是通过使用new 运算符实现的。
> - new运算符为对象动态分配（即在运行时分配）内存空间，并返回对它的一个引用。这个引用或多或少的是new分配给对象的内存地址。然后这 个引用被存储在该变量中。这样，在Java 中，所有的类对象都必须动态分配。
> - Scanner 类是用于扫描输入文本

```java
* nextInt(): 只读取数值，剩下”\n”还没有读取，并将光标放在本行中
* next():只读空格之前的数据，并且光标指向本行，方法遇见第一个有效字符（非空格，非换行符）时，开始扫描，当遇见第一个分隔符或结束符(空格或换行符)时，结束扫描，获取扫描到的内容，即获得第一个扫描到的不含空格、换行符的单个字符串。
* nextLine(): 可以扫描到一行内容并作为一个字符串而被获取到。
public class Nextest 
{
	public static void main(String[] args) 
	{
		 String s1,s2;  
	     Scanner sc =new Scanner(System.in);  
	     System.out.print("请输入第一个字符串：");  
	     s1=sc.next();  
	     System.out.print("请输入第二个字符串：");  
	     s2=sc.nextLine();  
	     System.out.println("输入的字符串是："+s1+" "+s2);  
	}
}/*
>>请输入第一个字符串：
1
>>请输入第二个字符串：

>>输入的字符串是： 1
*/
```

> - nextLine()自动读取了被next()去掉的Enter作为他的结束符，所以没办法给s2从键盘输入值。经过验证，我发现其他的next的方法，如double nextDouble() ， float nextFloat() ， int nextInt()  等与nextLine()连用时都存在这个问题，解决的办法是：在每一个 next()、nextDouble() 、  nextFloat()、nextInt() 等语句之后加一个nextLine()语句，将被next()去掉的Enter结束符过滤掉。

> - System.out.println();  是最常用的输出语句，它会把括号里的内容转换成字符串输出到输出窗口（控制台），并且换行，当输出的是一个基本数据类型时，会自动转换成字符串，如果输出的是一个对象，会自动调用对象的toString();方法，将返回值输出到控制台
> - System.out.print(); 与第一个很相似，区别就是上一个输出后会换行，而这个命令输出后并不换行。
> - System.out.printf(); 这个方法延续了C语言的输出方式，通过格式化文本和参数列表输出。

> - java中没有输入一个字符的方法，如果想输入一个字符就需要用到charAt（）方法

```java
Scanner read = new Scanner(System.in);
char key1 = read.next().charAt(0);
把字符串的第一个char值赋值给key1，类似于数组的查找
charAt（int index）方法是一个能够用来检索字符串特定下标的方法
str.charAt(str.length()-1)检索字符串的最后一个字符。
```

### 2.基本数据类型

> - 逻辑类型：boolean
> - 整数类型：byte（一个字节）、short（两个）、int（四个）、long（八个）
> - 字符类型：char（两个字节）因为java中汉字是两个字节，为了方便使用，将字母和汉字都改为两个字节，对应的是unicode表
> - 浮点类型：float（四个字节）、double（八个字节）

- java中变量可以用中文表示，其中float型常量必须加f / F，与double区分开
- 我们平时所说的字符串类型（String），它不是基本类型，而是一个对象类型，Java是将字符串作为对象实现的.
- java中的标识符：由一个字母或者一串以字母开头由字母、数字或符号组成的字符串（符号只允许下划线_和美元$符号）
- java中true、false、null都是小写，C++中大写，无 sizeof 运算符，goto和const是Java编程语言中保留的没有意义的关键字。

## 3.复合数据类型

> - 用户定义的、由一系列简单数据类型及其运算符合而成。是一种引用模型

```java
public class Hello 
{
	public static void main(String[] args) 
	{
		Point p = new Point(1,1);
		p.show();
		p.move(2, 3);
		p.show();
	}
}
class Point
{
    static String color;
    int x, y;
    Point(int x, int y)
    {
    	this.color = "blue";
    	this.x = x ;
    	this.y = y ;
    }
    public void move(int dx,int dy)
    {
    	x+=dx;
    	y+=dy;
    }
    public void show()
    {
    	System.out.println("color = " +color );
    	System.out.println("x = " + x );
    	System.out.println("y = " + y);
    }
}/*
>>color = blue
>>x = 1
>>y = 1
>>color = blue
>>x = 3
>>y = 4*/
```

### 4.程序流程语句

```java
break 可以跳出指定循环
outer:  for(int i=0;i<3;i++) 
		{
				System.out.print("Pass "+i+": ");
				for (int j=0;j<100;j++) 
				{
					if (j==10) 
					break outer;
					System.out.print(j+" ");
				}
				System.out.println("This will not print");
        }
		System.out.println("\nLoops complete.");
/*
>>Pass 0: 0 1 2 3 4 5 6 7 8 9 
>>Loops complete.
>>continue可以跳过指定循环*/
```

## 5.数组

> - 声明一个数组仅为数组指定了数组名和元素的数据类型，并未指定数组元素的个数，系统无法为数组分配存储空间。声明后的数组由初始化来完成上述工作，经过初始化new操作符完成，也可以通过给元素赋初值完成。
> - Java中不允许在声明数组的方括号内指定元素个数

```java
数组元素类型  数组名字 []；
数组元素类型  [] 数组名字；
数组名字 = new 数组元素类型[元素的个数]；
类型标识符  数组名[ ] [ ]=new 类型标识符[行数][列数] ；
类型标识符 [ ] [ ] 数组名= new 类型标识符[行数][列数]；
获得行数     数组名.length 
获得列数     数组名[行标].length



int a[]={1,2,3,4}; 
float [] b = {84.124F, 78.2F, 61.5F};
boolean[] c = {true, false, false, true};
String[] d = {"Zhang", "Li", "Wang"};
char s[] = new char[10];

String s[ ][ ]=new String[2][ ];
s[0] = new String[2];
s[1] = new String[3];
s[0][0] = new String(“Good”);
s[0][1] = new String(“Luck”);
//非矩阵数组
int twoDim[ ][ ] = new int [4][ ];
twoDim[0] = new int[2];
twoDim[1] = new int[4];
twoDim[2] = new int[6];
twoDim[3] = new int[8]; 

12345678910111213141516171819202122232425262728
char b[] = {'A','B','C'};
System.out.println(b);
System.out.println("数组b" + b);

ABC
数组b[C@3b192d32        

*对于char型数组System.out.println(b)不会输出数组b的引用，而是输出数组b的所有元素的值
*而要输出引用需要让数组b和字符串做并置运算。
```

> - 对于java 复制数组是把元素的值复制到另一个数组中去，如果执行a = b ，两个数组的引用相同，那么指向的同一内存空间，如果a[0]的值发生改变，那么b[0]的值也发生改变，这样就违背了复制数组的概念了。

```java
//1.arraycopy()方法
System.arraycopy(a, 0, b, 0, 6);// 原数组，要开始复制的索引值，复制数组，从第几个复制，复制到第几个的索引值
System.out.println(Arrays.toString(b));//打印数组
//2.Arrays.copyOf方法
int d [];
d = Arrays.copyOf(a, 7);//原数组，新数组的长度，返回的是新数组
System.out.println(Arrays.toString(d));
//3.Arrays.copyOfRange()方法
int e [];
e = Arrays.copyOfRange(a, 2, 4);//原数组，要复制原数组的起点，要复制原数组的终点，返回的是新数组
System.out.println(Arrays.toString(e));
Arrays.sort(a);//对数组升序排序方法
```

## 6.字符串

> - 声明 ： String 字符串变量；
>    初始化： 字符串变量 = new String（）；
>    合并使用 String 字符串变量 = new String（）；
>    *length() 返回字符串长度
>    char charAt(int index)返回字符串中第index个字符
>    int indexOf(int ch)返回字符串中字符ch第一次出现的位置
>    int indexOf(String str,int index)返回值为，从字符串的第index位置开始，子串str第一次出现的位置
>    subString(int index1 ,int index2)返回的是从字符串的第index1位置开始到index2位置结束的子串

```java
String s=new  String();
s=“I am a student.”;
s.length()的值为15
s.charAt(7)的值为s
s.indexOf(‘a’) 其值为2
注意字符串从0计数
找不到其值为-1
s.indexOf(“stu”,0)的值为7，
s.indexOf(“stu”,9)的值为-1
s.subString(7,13)的值为“studen”
```

> - 字符串的比较
>    字符在计算机中是按照Unicode编码存储的，两个字符串的比较实际上是字符串中对应字符编码的比较。从首字符开始逐个向后比较对应字符，当发现了一对不同的字符或到字符串末尾，两个字符串比较结束。
> - 常用的成员方法
>    equals (Object obj)本字符串与obj字符串比较，相等返回true,不等返回false
>    equalsIgnoreCase(String str)字符串比较，忽略大小写
>    compareTo(String str)返回值为整型，本字符串大于str取正值，小于取负值，相等取0值。

```java
String s=new String(“student”);
s.equals(“Student”)的值为false
s.equalsIgnoreCase(“Student”)
的值为true
s.compareTo(“five student”)的值为正
s.compareTo(“two student”)的值为负
```

> - 字符串与其他数据类型的转化
>   
>    | 方法                            | 返回类型 | 返回值   |
>    | ------------------------------- | -------- | -------- |
>    | Boolean.getBlooean("false")     | bloolean | false    |
>    | Integer.parselnt("123")         | int      | 123      |
>    | Long.parseLong("375")           | long     | 375      |
>    | Float.parseFloat("345.23")      | float    | 345.23   |
>    | Double.parse Double("67892.34") | double   | 67892.34 |
>    
> - String.valueOf(基本数据类型）
>    如 StringvalueOf（123）的值为“123”
>    StringvalueOf（0.34）的值为“0.34”

## 7.面向对象

### * 类的基本知识

> 默认构造函数：
>
> - 默认构造函数是与类名相同不带参数的没有返回值的函数，如果不写系统会自动隐含一个内容为空的构造函数。
> - 构造函数是在new 一个对象时调用的。

> static关键字：
>
> - 在变量和方法中被static修饰的成为类变量或类方法，这些时属于类的，在没有声明对象前，系统已经为其分配内存，这个类的所有对象都的这个变量都公用这一段内存，可以说是对象的共享变量。
> - 类方法只能调用类变量和类方法，不能调用其他方法（因为其他变量和方法在对象没被申请前没有分配内存），而其他方法可以调用类方法和类变量。
>    类方法是属于类的可以用类名直接调用。

> this关键字:
>
> - 当this关键字出现在方法中时，他代表正在调用该方法的对象，this. 可以调用该类的实例方法和对象，所以一般可以省略。
> - this不能出现在类方法中，因为类方法通过类名直接调用，这时可能还没有任何对象产生。

> super关键字：
>
> - 当子类与父类的变量或方法同名时，子类可以覆盖父类的方法，但是如果想在子类中调用父类的同名方法，就需要用到super关键字，super . 可以操作被隐藏的成员变量和方法

> final关键字：
>
> - final顾名思义就是最终的，final类不能被继承，即不能有子类。
> - 如果用final修饰一个方法，则这个方法不能被子类重写。
> - 常量：如果成员变量被修饰为final，则就是常量，常量在声明时没有默认值，所以在声明常量时必须指定该常量的值，而且不能发生变化

### * 封装性

> 在类的定义中设置对对象中的成员变量和方法进行访问的权限。
>  提供一个统一供其它类引用的方法。
>  其它对象不能直接修改本对象所拥有的属性和方法。
>
> - 对象变量的四种访问权限
>    public protected private 默认

> 默认：
>
> - 假如类或者类成员不含有一个明确的访问说明，说明它具有默认的访问控制特性。默认的访问控制权规定类或者类成员只能被同一个包中的其他代码所访问，在包外不可见。这种访问特性称为包访问性。

> private：
>
> - 用private修饰的类成员只能被该类中的其他成员所访问，在该类外不可见。

> protected:
>
> - 使用protected定义的成员变量或方法具有二重性，类本身、子类或包中的方法可以访问它们，而其它类没有访问权限

| 比较项目       | private | 默认   | protected | public |
| -------------- | ------- | ------ | --------- | ------ |
| 同一类         | 可见    | 可见   | 可见      | 可见   |
| 同一包的子类   | 不可见  | 可见   | 可见      | 可见   |
| 同一包的非子类 | 不可见  | 可见   | 可见      | 可见   |
| 不同包的子类   | 不可见  | 不可见 | 可见      | 可见   |
| 不同包的非子类 | 不可见  | 不可见 | 不可见    | 可见   |

------

> - 包：一些类可以封装成一个包，其他类可以import这个包使用其中的类
>    未设定public或private访问权限, 包内的所有类可以访问它们，包外的无法访问。
>    一个Java程序文件只能定义一个public类，而且程序文件必须与它同名。为其它程序共享的类须经过编译进行打包，形成一个包文件，然后用import语句加以引用。

### * 继承性

> 子类可以沿用父类（被继承类）的某些特征。子类也可以具有自己独立的属性和操作。但java中子类只能有一个父类
>
> - 用关键字 extends + 父类名,如果字类和父类在同一个包内，那么子类继承父类的 除 private的所有属性和操作，如果不在同一个包内，那么子类继承父类的protected和public的成员变量和方法，继承之后的访问权限保持不变

> 构造方法的继承：
>
> - 子类可以无条件的继承父类不含参数的构造方法
> - 如果子类没有构造方法，则它继承父类无参数的构造方法作为自己的构造方法；如果子类有构造方法，那么在创建子类对象时，则将先执行继承下来的父类的构造方法，然后再执行自己的构造方法
> - 对于父类中包含有参数的构造方法，子类可以通过在自己的构造方法中使用super关键字来引用，而且必须是子类构造方法中的第一条语句。
> - 如果父类中没有无参的构造函数，则子类不能调用父类的隐含的构造函数，系统不会自动生成，会报错，这时只能用super调用父类的带参数的构造函数。
> - 当用子类的构造方法创建一个对象时，子类的构造方法总是先调用父类的，因此在创建对象时不仅子类声明的成员变量分配了内存，而且父类的所有成员变量也分配了内存，但只将其中一部分（子类继承的）作为分配给子类的变量

> 成员变量的隐藏
>
> - 子类可以隐藏继承的成员变量，只要子类中声明的成员变量和父类中的重名，子类就隐藏了继承的成员变量，但是子类可以通过第哦调用从父类继承的方法来操作隐藏的成员变量。

> 成员方法的重写
>
> - 子类可以通过重写来隐藏已经继承的父类的方法，但是要求子类的类型与父类的方法类型一致，并且这个方法的名字、参数个数、参数类型和父类的必须完全相同。
>    *重写时要注意不能降低父类原来的访问权限。

### * 多态性

> 对象的上转型对象：
>
> - 把子类对象的引用放到父类的对象中，那么称父类的对象是子类对象的上转型对象。
> - 上转型对象不能操作子类新增的成员变量或新增的操作方法，但可以访问子类继承或隐藏的成员变量，也可以调用子类继承的方法或子类重写的方法

> 多态

> - 当一个类有很多子类，并且这些子类都重写了父类中的某个方法，把这些对象的引用付给父类的对象，就得到了这些对象的上转型对象，那么父类对象就可以调用不同子类的同一方法而产生不同的行为。
> - 多态性指的是父类的某个方法被子类重写时，可以用父类对象各自产生自己的行为功能。

> abstract类和方法
>
> - 抽象类是专门设计为子类继承的类，抽象类通常都包括一个或多个抽象方法（只有方法说明，没有方法体），抽象方法体中内容，根据继承抽象类的子类的实际情况，有子类完成其抽象方法的代码。
> - abstract类可以有abstract方法，也可以有非abstract方法，如果有abstract方法，则一定是抽象类，不是抽象类不能有abstract方法。
> - final和abstract不能同时使用，因为final所修饰的方法不能被重写，而abstract修饰的必须在子类中被重写，所以矛盾，不能同时使用。
> - abstract类不能用new运算符创建对象，如果一个abstract类是一个abstract类的子类，它可以重写父类的abstract方法，也可以继承这个abstract方法。
>    \####* 接口
> - java不支持多继承性，一个类只能继承一个父类，所以为了克服单继承的缺点，java使用了接口，一个类可以有多个接口，用关键字interface来定义一个接口。

> 接口体
>
> - 接口体中只有抽象方法，而且接口体中所有常量的访问权限一定都是public（允许省略public和final）所有抽象方法的访问权限一定是public（允许省略public，abstract）

> 接口的使用：

```java
//A 实现了B，C两个接口
class A implements B,C
//B继承A类并且实现C接口
class B extends A implements C
```

> - 如果一个类实现了某个接口，那么这个类就必须重写该接口的所有方法，重写接口的方法时，接口中的方法一定是public  abstract方法，所以类在重写的时候不仅要去掉abstract修饰符，而且方法的访问权限一定要明显的使用public来修饰，否则就是默认访问权限，这就降低了该方法的访问权限，这时不允许的。
> - 常在接口中定义常用的变量，作为全局变量使用，接口中的变量，本质上都是static，而且是final的 ，无论是否用static修饰，必须以常量值初始化。
> - 一个接口不能继承其它的类，但是可以继承别的接口
> - 类重写的接口方法以及接口中的常量可以被类的对象调用，而且常量也可以通过类名或接口名直接调用。
> - 声明接口是时，如果在关键字interface前加上public关键字，则这个接口可以被任何一个类声明实现，如果不加public，则是默认接口，只能被同一个包内的类所实现。
> - 如果父类实现了某个接口，那么子类也就自然实现了该接口，子类不必用implements声明这个接口。
> - 接口也可以被继承，可以通过关键字extends声明一个接口是另一个接口的子接口，由于接口中的常量和方法都是public的所以子接口将继承父接口中的所有常量和方法。
> - 如果一个类声明实现一个接口，但是没有重写接口中的方法，那么这个类必须是abstract类。

> 接口回调
>  接口回调是指把实现某一接口的类创建的对象的引用赋给该接口声明的接口变量中，那么该接口变量就可以调用被类重写的接口方法。（当接口变量调用被类重写的接口方法时，就是通知相应的对象调用这个方法）