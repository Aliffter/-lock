//
//  NSConditionLockDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "NSConditionLockDemo.h"
@interface NSConditionLockDemo()
@property (nonatomic, strong) NSConditionLock *condLock;// 条件锁

@end
@implementation NSConditionLockDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        //[[NSConditionLock alloc] init] 默认为 0
        self.condLock = [[NSConditionLock alloc] initWithCondition:1];
    }
    return self;
}

-(void)otherTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];

}

-(void)__one{
    // [self.condLock lock] 直接解锁，不管条件值
    [self.condLock lockWhenCondition:1];// 当符合condition为1条件时，进行加锁
    NSLog(@"__one");
    sleep(1);
    [self.condLock unlockWithCondition:2];//解锁，并设置condition 为 2
}

-(void)__two{
    [self.condLock lockWhenCondition:2];
    NSLog(@"__two");
    sleep(1);
    [self.condLock unlockWithCondition:5];

}

-(void)__three{
    [self.condLock lockWhenCondition:5];
    NSLog(@"__three");
    sleep(1);
    [self.condLock unlock];

}

-(void)moneyTest{}

-(void)ticketTest{}
@end
