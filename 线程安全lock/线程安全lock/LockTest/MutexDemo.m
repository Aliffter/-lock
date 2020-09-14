//
//  MutexDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>
@interface MutexDemo ()

@property (nonatomic, assign) pthread_mutex_t ticketLock;

@property (nonatomic, assign) pthread_mutex_t moneyLock;

@end

@implementation MutexDemo

-(void)__initLock:(pthread_mutex_t *)mutex{
    pthread_mutexattr_t attr ;
    
    pthread_mutexattr_init(&attr);
    
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);//默认 互斥锁
    
    pthread_mutex_init(mutex, &attr);
    // 销毁 attr
    pthread_mutexattr_destroy(&attr);
//    pthread_mutex_init(mutex, NULL);


}

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self __initLock:&_ticketLock];
            [self __initLock:&_moneyLock];

        });

    }
    return self;
}

- (void)__saleTicket{
    
    pthread_mutex_lock(&_ticketLock);
    
    [super __saleTicket];
    
    pthread_mutex_unlock(&_ticketLock);

}



-(void)__drawMoney{
    pthread_mutex_lock(&_ticketLock);

    [super __drawMoney];
    
    pthread_mutex_unlock(&_ticketLock);

}

-(void)__saveMoney{
    pthread_mutex_lock(&_ticketLock);

    [super __saveMoney];
    
    pthread_mutex_unlock(&_ticketLock);

}

-(void)dealloc{
    //销毁锁
    pthread_mutex_destroy(&_ticketLock);
    pthread_mutex_destroy(&_moneyLock);

}
@end
