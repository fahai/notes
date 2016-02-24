TestNG
=====


## HelloWorld  
```  
package org.testng.helloworld;

import org.testng.annotations.*;

public class SimpleTest {

 @BeforeClass
 public void setUp() {
   // code that will be invoked when this test is instantiated
 }

 @Test(groups = { "fast" })
 public void aFastTest() {
   System.out.println("Fast test");
 }

 @Test(groups = { "slow" })
 public void aSlowTest() {
    System.out.println("Slow test");
 }

}  
```  


## Introduction   
写一个单元测试一般包括三个步骤：  
1. 编写测试方法的业务逻辑并添加TestNG的注解  
2. 在testng.xml配置文件添加该单元测试的信息  
3. 启动单元测试  

The concepts used in this documentation are as follows:
A suite is represented by one XML file. It can contain one or more tests and is defined by the <suite> tag.
A test is represented by <test> and can contain one or more TestNG classes.
A TestNG class is a Java class that contains at least one TestNG annotation. It is represented by the <class> tag and can contain one or more test methods.
A test method is a Java method annotated by @Test in your source.  


## 注解  

testng.xml文件怎么让程序读取  
The difference of include and exclude


## Java Web 中如何使用JUnit

如何写好单元测试

http://wiki.jikexueyuan.com/project/junit/extensions.html


//在所有测试方法前执行一次
@BeforeClass    

//在所有测试方法后执行一次
@AfterClass  

//在每个测试方法前执行
@Before   

//在每个测试方法后执行
@After    

// 测试方法执行超过1000毫秒后算超时，测试将失败
@Test(timeout = 1000)   

// 测试方法期望得到的异常类
@Test(expected = Exception.class)    

// 执行测试时将忽略掉此方法，如果用于修饰类，则忽略整个类
@Ignore(“not ready yet”)  


http://ju.outofmemory.cn/entry/135429

Aa@3638821

## TODO  
如何让gradle到指定目录读取jar  
如何写好单元测试
  一个方法写多个单元测试如何写？写多个assert  
  void方法如何写assert？
