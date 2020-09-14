//
//  NSConditionDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "NSConditionDemo.h"
@interface NSConditionDemo ()

//@property (nonatomic, strong) NSConditionLock *condLock;// 条件锁
@property (nonatomic, strong) NSCondition *condition ;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
@implementation NSConditionDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.condition = [[NSCondition alloc] init];
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
-(void)moneyTest{
    
}

-(void)ticketTest{
    
}

-(void)otherTest{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__deleteObj) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__addObj) object:nil] start];
}

-(void)__addObj{
    [self.condition lock];
    static int order = 0;
    order ++ ;

    sleep(1);

    NSString *msg = [NSString stringWithFormat:@"test: %d",order];
    [self.dataArray addObject:msg];
    NSLog(@"添加 _ %@",msg);
    // 信号
    [self.condition signal];// 唤醒等待的线程
    
    //广播
//    [self.condition broadcast];
    [self.condition unlock];
}

-(void)__deleteObj{
    [self.condition lock];
    NSLog(@"-- 准备删除 --");

    if (self.dataArray.count == 0) {
        NSLog(@"--无数据 wait --");
        [self.condition wait];// 进入wait,堵住线程，放开锁，别人就可以进行加锁
    }
    NSLog(@"删除了元素:%@",[self.dataArray lastObject]);
    [self.dataArray removeLastObject];
    [self.condition unlock];
}
@end
