//
//  HDScoreStarView.m
//  zykTools
//
//  Created by ZYK on 2020/12/3.
//

#import "HDScoreStarView.h"
@interface HDScoreStarView()
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, copy) NSString *imageNameNor;
@property (nonatomic, copy) NSString *imageNameSel;
@end
@implementation HDScoreStarView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //初始化 用于评价
        self.imageNameNor = @"common_icon_star64_sel";
        self.imageNameSel = @"common_icon_star64_nor";
    };
    return self;
}
- (void)setStarCount:(NSUInteger)starCount {
    if (starCount == 0) {
        return;
    }
    if (_starCount != starCount) {
        _starCount = starCount;
        if (starCount > 5) {
            starCount = 5;
        }
        self.index = starCount;
        [self setNeedsDisplay];
        //设置了startCount  则不能点击 只做展示用
        self.tapEnabled = NO;
        self.imageNameNor = @"common_icon_star32_sel";
        self.imageNameSel = @"common_icon_star32_nor";
    }
}

- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    self.userInteractionEnabled = tapEnabled;
}

#pragma mark - 绘制
- (void)drawRect:(CGRect)rect {
    UIImage *norImage = [UIImage imageNamed:self.imageNameNor];
    UIImage *selImage = [UIImage imageNamed:self.imageNameSel];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat spacing = self.spacing;
    CGFloat starWidth = (self.frame.size.width - (spacing *4)) / 5;
    for (NSInteger i = 0; i < 5; i ++) {
        UIImage *drawImage = i < self.index ? selImage : norImage;
        [self drawImage:context CGImageRef:drawImage.CGImage CGRect:CGRectMake((starWidth + spacing) * i, 0, starWidth, self.frame.size.height)];
    }
}

- (void)drawImage:(CGContextRef)context
       CGImageRef:(CGImageRef)image
           CGRect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image);
    
    CGContextRestoreGState(context);
}


#pragma mark - touch

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.index = point.x / (self.frame.size.width / 5) + 1;
    if (self.index == 6) {
        self.index --;
    }
    [self setNeedsDisplay];
    if (self.indexCount) {
        self.indexCount(self.index);
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

@end
