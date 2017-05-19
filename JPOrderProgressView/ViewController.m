//
//  ViewController.m
//  HXDOrderProgressView.h HXDOrderProgressView
//
//  Created by 鞠鹏 on 2017/4/24.
//  Copyright © 2017年 JuPeng. All rights reserved.
//

#import "ViewController.h"
#import "HXDOrderProgressView.h"

@interface ViewController ()
{
    HXDOrderProgressView *_progressView;
    NSInteger  _roundIndex;
    NSInteger _lineIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HXDOrderProgressView *progressView = [[HXDOrderProgressView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100) titlesArr:@[@"收藏商品",@"支付订金",@"支付尾款",@"商家发货",@"确认收货"] highlightColor:[UIColor redColor] normalColor:[UIColor lightGrayColor] radius:12.0f roundIndex:2 lineIndex:-1];
    
    [self.view addSubview:progressView];
    _progressView = progressView;
}
- (IBAction)roundIndex:(UIButton *)sender {
    
    _roundIndex= arc4random()%5;
    [sender setTitle:[NSString stringWithFormat:@"RoundIndex %ld",_roundIndex] forState:UIControlStateNormal];
    [_progressView setCurrentRoundIndex:_roundIndex lineIndex:_lineIndex];
}

- (IBAction)lineIndex:(UIButton *)sender {
    _lineIndex = arc4random()%10;
    [_progressView setCurrentRoundIndex:_roundIndex lineIndex:_lineIndex];
    [sender setTitle:[NSString stringWithFormat:@"LineIndex %ld",_lineIndex] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
