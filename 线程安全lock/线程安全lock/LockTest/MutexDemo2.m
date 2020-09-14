//
//  MutexDemo2.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "MutexDemo2.h"
#import <pthread.h>

@interface MutexDemo2 ()

@property (nonatomic, assign) pthread_mutex_t mutexLock;


@end

@implementation MutexDemo2

-(void)__initLock:(pthread_mutex_t *)mutex{
    pthread_mutexattr_t attr ;
    
    pthread_mutexattr_init(&attr);
    
    // 允许同一个线程对同一把锁进行加锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);//递归锁
    
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
            [self __initLock:&_mutexLock];

        });

    }
    return self;
}

-(void)otherTest{
    static int order = 10;
    
    pthread_mutex_lock(&_mutexLock);
    order -- ;
    NSLog(@"%@ --- %d----",[self class],order);
    if (order != 0) {
        [self otherTest];
    }
    pthread_mutex_unlock(&_mutexLock);
}

-(void)moneyTest{}

-(void)ticketTest{}
-(void)dealloc{
    //销毁锁
    pthread_mutex_destroy(&_mutexLock);

}

@end
