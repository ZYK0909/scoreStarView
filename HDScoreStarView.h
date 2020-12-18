//
//  HDScoreStarView.h
//  zykTools
//
//  Created by ZYK on 2020/12/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDScoreStarView : UIView
/*
 *@pramas  spacing 星星之间的间距
 */
@property (nonatomic, assign, readwrite) CGFloat spacing;

/*
 *@pramas  starCount 星星需要设置成的数量
 大小为：1～5，超过5则置为5
 默认不设置，用于评价
 设置了则表示用于展示评分
 */
@property (nonatomic, assign, readwrite) NSUInteger starCount;

/*
 *@pramas  tapEnabled 关闭星星点击手势
 */
@property (nonatomic, assign, readwrite, getter=isTapEnabled) BOOL tapEnabled;



/// 点击了几个星星
@property(nonatomic,strong) void(^indexCount)(NSUInteger indexCount);

@end

NS_ASSUME_NONNULL_END
