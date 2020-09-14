//
//  OSSpinLock.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>


/*
 自旋锁：存在优先级反转，不安全，不推荐使用
 */

static OSSpinLock moneyLock_;

@interface OSSpinLockDemo ()

@end

@implementation OSSpinLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            moneyLock_ = OS_SPINLOCK_INIT;
        });

    }
    return self;
}

- (void)__saleTicket{
    //#define    OS_SPINLOCK_INIT    0
    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;
    
    OSSpinLockLock(&ticketLock);
    
    [super __saleTicket];
    
    OSSpinLockUnlock(&ticketLock);
}



-(void)__drawMoney{
    OSSpinLockLock(&moneyLock_);
    
    [super __drawMoney];
    
    OSSpinLockUnlock(&moneyLock_);

}

-(void)__saveMoney{
    OSSpinLockLock(&moneyLock_);
    
    [super __saveMoney];
    
    OSSpinLockUnlock(&moneyLock_);

}

@end
