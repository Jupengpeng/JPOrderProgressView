//
//  HXDOrderProgressView.h
//  HaoXiaDan_iOS_2.0
//
//  Created by 鞠鹏 on 2017/4/24.
//  Copyright © 2017年 JuPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/*好下单订单状态流程图*/

@interface HXDOrderProgressView : UIView

- (instancetype)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr highlightColor:(UIColor *)highlightColor normalColor:(UIColor *)normalColor radius:(CGFloat)radius roundIndex:(NSInteger)roundIndex lineIndex:(NSInteger)lineIndex;

- (void)setCurrentRoundIndex:(NSInteger)roundIndex lineIndex:(NSInteger)lineIndex;

@end
