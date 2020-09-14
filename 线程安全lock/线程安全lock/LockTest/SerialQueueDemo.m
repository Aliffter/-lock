//
//  SerialQueueDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

/*
 串行队列
 */

#import "SerialQueueDemo.h"


@interface SerialQueueDemo()
@property (nonatomic, strong) dispatch_queue_t ticketQueue;// 串行队列
@property (nonatomic, strong) dispatch_queue_t moneyQueue;// 串行队列


@end
@implementation SerialQueueDemo
- (instancetype)init
{
    self = [super init];
    if (self) {

        self.ticketQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
        self.moneyQueue = dispatch_queue_create("moneyQueue", DISPATCH_QUEUE_SERIAL);

    }
    return self;
}


-(void)__drawMoney{
    dispatch_async(self.moneyQueue, ^{
        [super __drawMoney];
    });
}

-(void)__saveMoney{
    dispatch_async(self.moneyQueue, ^{
        [super __saveMoney];
    });
}

-(void)__saleTicket{
    dispatch_async(self.ticketQueue, ^{
        [super __saleTicket];
    });
}

@end
