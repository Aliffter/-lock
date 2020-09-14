//
//  OSUnfairLock.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>
@interface OSUnfairLockDemo ()
@property (nonatomic, assign) os_unfair_lock ticketLock;

@property (nonatomic, assign) os_unfair_lock moneyLock;

@end

@implementation OSUnfairLockDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.ticketLock = OS_UNFAIR_LOCK_INIT;
            self.moneyLock = OS_UNFAIR_LOCK_INIT;

        });

    }
    return self;
}

- (void)__saleTicket{
    
    os_unfair_lock_lock(&_ticketLock);
    
    [super __saleTicket];
    
    os_unfair_lock_unlock(&_ticketLock);
}



-(void)__drawMoney{
    os_unfair_lock_lock(&_moneyLock);

    [super __drawMoney];
    
    os_unfair_lock_unlock(&_moneyLock);

}

-(void)__saveMoney{
    os_unfair_lock_lock(&_moneyLock);

    [super __saveMoney];
    
    os_unfair_lock_unlock(&_moneyLock);

}

@end
