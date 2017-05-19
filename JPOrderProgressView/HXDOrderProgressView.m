//
//  HXDOrderProgressView.m
//  HaoXiaDan_iOS_2.0
//
//  Created by 鞠鹏 on 2017/4/24.
//  Copyright © 2017年 JuPeng. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/*线宽*/
#define kLineWidth 2
/*间距*/
#define kSideSpace 15.0f
#define kFontSize 12.0f
#define kTitleLabelTag 600

#import "HXDOrderProgressView.h"

@interface HXDOrderProgressView()
{
    //原点间距
    CGFloat _betweenSpace;
    //圆圈总数
    NSInteger _totalRoundCount;
    //原点高亮坐标
    NSInteger _roundIndex;
    //直线坐标
    NSInteger _lineIndex;
    
    /*  直线高亮
     *  从-1开始
     *  中间段一半为坐标1
     *    - * —— —— * —— —— * —
     * -1 0   1  2    3  4   5
     */
    //直线初始坐标
    CGFloat _oriPointX;
    //圆半径
    CGFloat _roundRadius;
    //高亮颜色
    UIColor *_highlightedColor;
    //普通颜色
    UIColor *_normalColor;
    //文字和图形上下间距
    CGFloat _verticalSpace;

}

@property (nonatomic,strong) NSMutableArray *titlesArr;

@end

@implementation HXDOrderProgressView


- (instancetype)initWithFrame:(CGRect)frame titlesArr:(NSArray *)titlesArr highlightColor:(UIColor *)highlightColor normalColor:(UIColor *)normalColor radius:(CGFloat)radius roundIndex:(NSInteger)roundIndex lineIndex:(NSInteger)lineIndex{
    self = [super initWithFrame:frame];
    if (self) {
        _highlightedColor = highlightColor;
        _normalColor = normalColor;
        _roundIndex = roundIndex;
        _lineIndex = lineIndex;
        _roundRadius = radius/2.0f;
        
        _totalRoundCount = titlesArr.count;
        self.titlesArr = [NSMutableArray arrayWithArray:titlesArr];
        _verticalSpace = frame.size.height/3.0 - kFontSize;
        
        
        //开始
        CGFloat preSpace = (frame.size.width - 2*kSideSpace)/ ((_totalRoundCount - 1 )* 3 + 2.0);
        _betweenSpace = preSpace * 3.0f;
        
        
        for (NSInteger i = 0; i < titlesArr.count; i ++) {
            CGFloat highStartLineX = kSideSpace;
            CGFloat highSartLineY = self.frame.size.height/3.0f + _verticalSpace + _roundRadius*2.0f;
            CGFloat indexSpace = _betweenSpace/2.0f;

            CGPoint pointX =  CGPointMake(highStartLineX + (indexSpace * 2.0f /3.0f) + i *(indexSpace*2), highSartLineY);
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 12.0f)];
            titleLabel.font = [UIFont systemFontOfSize:kFontSize];
            titleLabel.center = pointX;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = UIColorFromRGB(0x646464);
            titleLabel.text = titlesArr[i];
            titleLabel.tag = kTitleLabelTag + i;
            [self addSubview:titleLabel];
        }
        
        [self setCurrentRoundIndex:_roundIndex lineIndex:_lineIndex];
        
    }
    return self;
}

- (void)setCurrentRoundIndex:(NSInteger)roundIndex lineIndex:(NSInteger)lineIndex{
    _roundIndex = roundIndex;
    _lineIndex  = lineIndex;
    
    for (NSInteger i = 0; i < self.titlesArr.count; i ++) {
        UILabel *titleLabel = [self viewWithTag:kTitleLabelTag + i];
       if (i<=_roundIndex) {

           titleLabel.textColor = UIColorFromRGB(0x323232);
       }else{
           titleLabel.textColor = UIColorFromRGB(0x646464);
       }
    }
    
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    // 下面两句代码的作用就是填充背景色
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    CGFloat highStartLineX = kSideSpace;
    CGFloat normalEndLineX = highStartLineX + self.frame.size.width - 2*kSideSpace;
    CGFloat highSartLineY = self.frame.size.height/3.0f;
    /*坐标增加间距 */
    CGFloat indexSpace = _betweenSpace/2.0f;
    CGFloat highEndLineX = 0;;
    if (_lineIndex == 0) {
        highEndLineX = highStartLineX  + (indexSpace * 2.0f /3.0f);
    }else if (_lineIndex == (_roundIndex * 2 - 1)) {
        highEndLineX = highStartLineX + ((_roundIndex - 1 )* 2 )*indexSpace + (indexSpace * 2.0f /3.0f);
    }else{
         highEndLineX = highStartLineX + (_lineIndex?(_lineIndex * indexSpace):0) + (indexSpace * 2.0f /3.0f);

    }

    if (_lineIndex != -1) {
        //全是灰线
        //亮线
        UIBezierPath *highPath = [UIBezierPath bezierPath];
        [highPath moveToPoint:CGPointMake(highStartLineX, highSartLineY)];
        [highPath addLineToPoint:CGPointMake(highEndLineX, highSartLineY)];
        [_highlightedColor set];
        highPath.lineWidth = kLineWidth;
        [highPath stroke];
    }

    if (_lineIndex != (_totalRoundCount * 2 - 1) ) {
        //全是亮线
        //普通
        UIBezierPath *normalPath = [UIBezierPath bezierPath];
        [normalPath moveToPoint:CGPointMake(highEndLineX, highSartLineY)];
        [normalPath addLineToPoint:CGPointMake(normalEndLineX, highSartLineY)];
        [[UIColor lightGrayColor] set ];
        normalPath.lineWidth = kLineWidth;
        [normalPath stroke];
    }
    

    
    for (NSInteger i = 0; i < _totalRoundCount; i ++) {
        CGPoint pointX =  CGPointMake(highStartLineX + (indexSpace * 2.0f /3.0f) + i *(indexSpace*2), highSartLineY);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:pointX radius:_roundRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        if (i<=_roundIndex) {
            [_highlightedColor setFill];
            [_highlightedColor setStroke];
        }else{
            [_normalColor setFill];
            [_normalColor setStroke];
        }
        [path stroke];
        [path fill];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
