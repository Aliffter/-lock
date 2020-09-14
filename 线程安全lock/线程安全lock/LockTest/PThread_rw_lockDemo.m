//
//  PThread_rw_lockDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/14.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "PThread_rw_lockDemo.h"
#import <pthread.h>

@interface PThread_rw_lockDemo ()
@property (nonatomic, assign) pthread_rwlock_t lock;

@end


@implementation PThread_rw_lockDemo

-(void)initlock:(pthread_rwlock_t *)lock{
    pthread_rwlockattr_t attr ;
    pthread_rwlockattr_init(&attr);
    pthread_rwlock_init(lock, &attr);

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initlock:&_lock];
    }
    return self;
}

-(void)otherTest{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self readFile];
            [self readFile];
            [self readFile];
        });
         dispatch_async(queue, ^{
            [self writeFile];
            [self writeFile];
        });

    }
}

-(void)readFile{
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"read ...");

    pthread_rwlock_unlock(&_lock);
}

-(void)writeFile{
    pthread_rwlock_wrlock(&_lock);
    
    NSLog(@"write ...");
    sleep(2);
    pthread_rwlock_unlock(&_lock);
    NSLog(@"write ... end");
}


-(void)ticketTest{}
-(void)moneyTest{}

-(void)dealloc{
    pthread_rwlock_destroy(&_lock);
}
@end
