# C++ STL

STL中六大组件：

- 容器（Container），是一种数据结构，如list，vector，和deques ，以模板类的方法提供。为了访问容器中的数据，可以使用由容器类输出的迭代器；
- 迭代器（Iterator），提供了访问容器中对象的方法。例如，可以使用一对迭代器指定list或vector中的一定范围的对象。迭代器就如同一个指针。事实上，C++的指针也是一种迭代器。但是，迭代器也可以是那些定义了operator*()以及其他类似于指针的操作符地方法的类对象；
- 算法（Algorithm），是用来操作容器中的数据的模板函数。例如，STL用sort()来对一个vector中的数据进行排序，用find()来搜索一个list中的对象，函数本身与他们操作的数据的结构和类型无关，因此他们可以在从简单数组到高度复杂容器的任何数据结构上使用；
- 仿函数（Functor）
- 适配器（Adaptor）
- 分配器（allocator）

几乎所有的STL代码都使用了模板类和模板函数的方法，这提供了更好的代码复用。在C++标准中，STL被组织为13个头文件：

- \<algprithm>【算法】
- \<deque>【双向队列】
- \<functional>【功能】
- \<iterator>【迭代器】
- \<vector>【向量】
- \<list>【列表】
- \<map\>【映射】
- \<memory>【内存】
- \<numeric>【数值】
- \<queue>【队列】
- \<set>【设置】
- \<stack>【栈】
- \<utility>【通用】

从逻辑层次来看，在STL中体现了泛型化程序设计的思想，引入了诸多新的名词，比如像需求（requirements），概念（concept），模型（model），容器（container），算法（algorithmn），迭代子（iterator）等。与OOP（object-oriented programming）中的多态（polymorphism）一样，泛型也是一种软件的复用技术
## 模板函数和模板类

为了避免为特点类型重复编写相同实现（针对不同数据类型的数据结构等），我们使用代指的类型创建：

- 模板函数：

```c++

template <typename type> ret-type func-name(parameter list)
{
   //type并不是确实的某个类型，而是你对可能使用的类型代指
   // 函数的主体
}
```

- 类模板

```C++
template <class type> class class-name {
   //type并不是确实的某个类型，而是你对可能使用的类型代指
   // 类的内部
}
```

## 容器（Container）

STL中的容器有队列容器和关联容器，容器适配器（congtainer adapters：stack,queue，priority queue），位集（bit_set），串包(string_package)等等。

### 序列式容器

插入数据信息排列和插入顺序强相关

- **Vector：**将元素放在同一内存区块的动态数组可以随机存取使用，在尾部存取，修改，删除更加高效了。
- **Deque：**将元素放在多个内存区块的动态数组可以随机存取使用，在首部和尾部存取，修改，删除更加高效