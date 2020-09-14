//
//  GCDSemaphoreDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "GCDSemaphoreDemo.h"

#define SemaphoreBegin \
static dispatch_semaphore_t semaphore ; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{\
    semaphore = dispatch_semaphore_create(1);\
});\

#define SemaphoreWait \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

#define SemaphoreSignal \
dispatch_semaphore_signal(semaphore);


@interface GCDSemaphoreDemo()
@property (nonatomic, strong) dispatch_semaphore_t ticketSemaphore;// 信号量
@property (nonatomic, strong) dispatch_semaphore_t moneySemaphore;
@end

@implementation GCDSemaphoreDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticketSemaphore = dispatch_semaphore_create(1);
        self.moneySemaphore = dispatch_semaphore_create(1);
    }
    return self;
}
#if 1
-(void)otherTest{


    [self tt1];

    [self tt2];
    [self tt3];

}

-(void)tt1{
    SemaphoreBegin

    SemaphoreWait

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i< 10; i++) {
            NSLog(@"tt1 -- %d",i);
        }
    });
    SemaphoreSignal

}

-(void)tt2{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i< 10; i++) {
            NSLog(@"-- tt2 -- %d",i);
        }
    });
}
-(void)tt3{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i< 10; i++) {
            NSLog(@"---- tt3 -- %d",i);
        }
    });
}
-(void)moneyTest{
    
}

-(void)ticketTest{
    
}

#endif

- (void)__saleTicket{
    
    dispatch_semaphore_wait(_ticketSemaphore, DISPATCH_TIME_FOREVER);
    [super __saleTicket];
    dispatch_semaphore_signal(_ticketSemaphore);

}



-(void)__drawMoney{
    dispatch_semaphore_wait(_moneySemaphore, DISPATCH_TIME_FOREVER);

    [super __drawMoney];
    
    dispatch_semaphore_signal(_moneySemaphore);

}

-(void)__saveMoney{
    dispatch_semaphore_wait(_moneySemaphore, DISPATCH_TIME_FOREVER);

    [super __saveMoney];
    
    dispatch_semaphore_signal(_moneySemaphore);

 
}


@end
