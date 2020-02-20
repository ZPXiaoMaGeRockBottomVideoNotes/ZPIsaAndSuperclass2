//
//  main.m
//  isa和superclass2
//
//  Created by 赵鹏 on 2019/5/4.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//自定义类
@interface Person : NSObject <NSCopying>
{
    @public
    int _age;
}

@property (nonatomic, assign) int no;

- (void)personInstanceMethod;

+ (void)personClassMethod;

@end

@implementation Person

- (void)personInstanceMethod
{
    NSLog(@"personInstanceMethod");
}

+ (void)personClassMethod
{
    NSLog(@"personClassMethod");
}

@end

//自定义类
@interface Student : Person <NSCoding>
{
    @public
    int _weight;
}

@property (nonatomic, assign) int height;

- (void)studentInstanceMethod;

+ (void)studentClassMethod;

@end

@implementation Student

- (void)studentInstanceMethod
{
    NSLog(@"studentInstanceMethod");
}

+ (void)studentClassMethod
{
    NSLog(@"studentClassMethod");
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /**
         获取Person类的instance对象（实例对象）： ·因为Person类的instance对象的实质是一个结构体，又因为Person类继承于NSObject，所以instance对象中包含一个isa指针。
         ·想要知道这个instance对象里面的isa指针的值就要在程序运行以后在控制台中利用lldb命令"p/x (long)person->isa"把这个isa指针的值打印出来即可。
         */
        Person *person = [[Person alloc] init];
        
        /**
         获取Person类的class对象（类对象）：
         ·想要知道Person类的class对象的地址的话，就要在程序运行以后在控制台中利用lldb命令"p/x personClass"把这个class对象的地址值打印出来；
         ·Person类的instance对象的isa指针指向这个类的class对象，所以instance对象里面的isa指针存储的应该是这个类的class对象的地址。但是，把Person类的instance对象里面的isa指针的值和这个类的class对象的地址值打印出来以后发现这两个值是不一样的，这是因为在以前32位的系统中上述的两个值是一样的，但是在64位的系统中instance对象里面的isa指针的值需要进行一次位运算才能计算出class对象的地址值了。同理，class对象里面的isa指针的值也需要进行一次位运算才能计算出meta-class对象的地址值了。
         */
        Class personClass = [Person class];
        
        //获取某个类的meta-class对象（元类对象）：
        Class personMetaClass = object_getClass(personClass);
        
        NSLog(@"%p, %p, %p", person, personClass, personMetaClass);
    }
    
    return 0;
}
