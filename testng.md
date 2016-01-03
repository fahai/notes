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
The difference   of include and exclude




7558335425
