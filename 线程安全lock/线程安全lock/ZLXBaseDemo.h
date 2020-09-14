//
//  ZLXBaseDemo.h
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLXBaseDemo : NSObject
/**
 买票演示
 */
-(void)ticketTest;
/**
 存钱演示
 */
-(void)moneyTest;


-(void)otherTest;

#pragma -mark  私有方法
-(void)__saleTicket;
-(void)__drawMoney;
-(void)__saveMoney;

@end

NS_ASSUME_NONNULL_END
