//
//  GCDViewController.m
//  JHW_timer
//
//  Created by JHW on 17/3/13.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "GCDViewController.h"

NSInteger count = 0;
@interface GCDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shoTime;

@property (weak, nonatomic) IBOutlet UIButton *startTime;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;


@property (nonatomic, strong)dispatch_source_t time;

@end

@implementation GCDViewController

- (void)dealloc{
    dispatch_cancel(self.time);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self startTimer];
    [[_startTime rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self loadTimer];
    }];
    
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            dispatch_cancel(self.time);
        }];
    }];
}
- (void)loadTimer{

    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(self.time, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(self.time, ^{
        [self startTimer];
        //设置当执行取消定时器
        //dispatch_cancel(self.time);
        // }
    });
    //由于定时器默认是暂停的所以我们启动一下
    //启动定时器
    dispatch_resume(self.time);
}
- (void)startTimer{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    self.shoTime.text = DateTime;
    NSLog(@"-----%@",DateTime);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
