//
//  TimerViewController.m
//  JHW_timer
//
//  Created by JHW on 17/3/13.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController (){
    NSTimer *_timer;
    NSInteger _time;
    NSInteger _num;
}

@property (weak, nonatomic) IBOutlet UILabel *showTime;

@property (weak, nonatomic) IBOutlet UIButton *startTime;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation TimerViewController

-(void)dealloc{
    [_timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startTimer];
    //    _num = 0;
    [[_startTime rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
    }];
    
    [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:^{
            [_timer invalidate];
        }];
    }];
}
- (void)startTimer{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    self.showTime.text = DateTime;
    NSLog(@"-----%@",DateTime);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
