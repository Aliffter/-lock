//
//  NSLockDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property (nonatomic, strong) NSLock *ticketLock; // 互斥锁
@property (nonatomic, strong) NSLock *moneyLock;
@property (nonatomic, strong) NSRecursiveLock *recLock; // 递归锁
@property (nonatomic, strong) NSConditionLock *condLock;// 条件锁

@end

@implementation NSLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.ticketLock = [[NSLock alloc] init];
            self.moneyLock = [[NSLock alloc] init];
            self.recLock = [[NSRecursiveLock alloc] init];
        });

    }
    return self;
}

- (void)__saleTicket{
    
//    if ([_ticketLock tryLock]) {
        [_ticketLock lock];
        
        [super __saleTicket];
        
        [_ticketLock unlock];

//    }

}



-(void)__drawMoney{
    [_moneyLock lock];

    [super __drawMoney];
    
    [_moneyLock unlock];

}

-(void)__saveMoney{
    [_moneyLock lock];

    [super __saveMoney];
    
    [_moneyLock unlock];

}


-(void)otherTest{
    
    static int order = 10;
    [_recLock lock];
    order -- ;
    NSLog(@"%@_递归调用 --- %d----",[self class],order);
    if (order != 0) {
        [self otherTest];
    }
    [_recLock unlock];
}

@end
