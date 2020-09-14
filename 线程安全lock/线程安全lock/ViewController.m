//
//  ViewController.m
//  线程安全lock
//
//  Created by 赵隆晓 on 2020/9/13.
//  Copyright © 2020 赵隆晓. All rights reserved.
//

#import "ViewController.h"
#import "OSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "MutexDemo.h"
#import "MutexDemo2.h"
#import "NSLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueueDemo.h"
#import "GCDSemaphoreDemo.h"
#import "SynchronizedDemo.h"
#import <pthread.h>
#import "PThread_rw_lockDemo.h"
static NSString * const cellID = @"tempCellID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"SpinLock",@"os_unfair_lock",@"pthread_mutex_t(default)",@"pthread_mutex_t(递归锁)",@"NSLock",@"NSCondition",@"NSConditionLock",@"SerialQueue",@"GCDSemaphore",@"@synchronized",@"pthread_rw_lock"];
    
    [self.view addSubview:self.tableView];
//    [self test];
}

-(void)test{
    dispatch_queue_t  queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [[[NSThread alloc] initWithBlock:^{
            for (int i = 0; i < 10; i ++) {
                
                NSLog(@"- A - %d  - %@",i,[NSThread currentThread]);
                 sleep(1);
            }
            dispatch_group_leave(group);
        }] start];
       
    });
    dispatch_group_enter(group);

    dispatch_group_async(group, queue, ^{
           for (int i = 0; i < 10; i ++) {
               NSLog(@"-- B ---- %d",i);
           }
       });
    dispatch_group_async(group, queue, ^{
           for (int i = 0; i < 10; i ++) {
               NSLog(@"--- C ------- %d",i);
           }
       });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"刷新UI");
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:{
            [self testLock:[OSSpinLockDemo class]];
        }
            break;
        case 1:{
            [self testLock:[OSUnfairLockDemo class]];
        }
            break;
        case 2:{
            [self testLock:[MutexDemo class]];
        }
            break;
        case 3:{
            [self testLock:[MutexDemo2 class]];
        }
            break;
        case 4:{
            [self testLock:[NSLockDemo class]];
        }
            break;
        case 5:{
            [self testLock:[NSConditionDemo class]];
        }
            break;
        case 6:{
            [self testLock:[NSConditionLockDemo class]];
        }
            break;
        case 7:{
            [self testLock:[SerialQueueDemo class]];
       }
           break;
        case 8:{
            [self testLock:[GCDSemaphoreDemo class]];
        }
            break;
        case 9:{
           [self testLock:[SynchronizedDemo class]];
       }
           break;
        case 10:{
            [self testLock:[PThread_rw_lockDemo class]];
        }
            break;
        default:
            break;
    }
}

-(void)testLock:(Class)cls{
    ZLXBaseDemo *lock = [[cls alloc] init];
    
    
    [lock ticketTest];
    [lock moneyTest];
    [lock otherTest];

}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end
