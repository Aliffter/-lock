//
//  ZLXBaseDemo.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "ZLXBaseDemo.h"

@interface ZLXBaseDemo()
@property (nonatomic, assign) int ticketsCount;
@property (nonatomic, assign) int money;


@end
@implementation ZLXBaseDemo
-(void)otherTest{}


-(void)ticketTest{
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            [self __saleTicket];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            [self __saleTicket];
        }
    });

    
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            [self __saleTicket];
        }
    });
}

-(void)__saleTicket{
        int oldCount = self.ticketsCount;
        sleep(.2);
        oldCount -- ;
        self.ticketsCount = oldCount;
        NSLog(@"%@ - 还剩 【%d】 张票 ",[self class],self.ticketsCount);
}


-(void)moneyTest{
    self.money = 100;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            [self __drawMoney];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            [self __saveMoney];
        }
    });

}

-(void)__drawMoney{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20 ;
    self.money = oldMoney;
    NSLog(@"%@ - 取 20 余额: %d ",[self class],self.money);
}

-(void)__saveMoney{
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50 ;
    self.money = oldMoney;
    NSLog(@"%@ - 存 50 余额: %d ",[self class],self.money);

}

@end
