//
//  SynchronizedDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

/*
    以一个对象作为锁，进行加锁。不推荐使用，效率较低
 */
#import "SynchronizedDemo.h"

@interface SynchronizedDemo ()
@property (nonatomic, strong) NSObject *obj;

@end
@implementation SynchronizedDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.obj = [[NSObject alloc] init];
    }
    return self;
}

- (void)__saleTicket{
    //objc_sync_enter
    @synchronized (_obj) {
        [super __saleTicket];
    }//objc_sync_exit
}



-(void)__drawMoney{
    @synchronized (self) {
        [super __drawMoney];
    }
    

}

-(void)__saveMoney{
    @synchronized (self) {
        [super __saveMoney];
    }
}
@end
