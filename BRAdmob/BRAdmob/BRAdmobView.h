//
//  BRAdmobView.h
//  BRAdmob
//
//  Created by gitBurning on 15/4/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRAdmobView;
@protocol BRAdmobSelectDelegate <NSObject>

@required
-(void)admobView:(BRAdmobView*)admobview SelectIndex:(NSInteger)index andOther:(id)other;

@end


typedef void(^admobSelectBlcok)(id info,NSInteger index);

typedef NS_ENUM(NSUInteger, KPageControlPostion) {
    KPageControlPostion_Left=1,
    KPageControlPostion_Middle,
    KPageControlPostion_right
};

@interface BRAdmobView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSInteger indexScoller;
}

/**
 *  UI
 */
@property(strong,nonatomic) UICollectionView * collectionView;
@property(strong,nonatomic) UIPageControl * pageControl;
/**
 *  存放广告title 
 */
@property(strong,nonatomic) UIView * titileView;
@property(strong,nonatomic) UILabel * titileLabel;
/**
 *  数据
 */
@property(strong,nonatomic) NSArray * dataArray;


/**
 *  属性
 */
@property(assign,nonatomic) BOOL isPagingEnabled;
@property(assign,nonatomic) BOOL isBounces;
/**
 *  允许点击事件
 */
@property(assign,nonatomic) BOOL allowSelect;
/**
 *  自动滚动
 */
@property(assign,nonatomic) BOOL isAutoScoller;
@property(assign,nonatomic) NSInteger autoTime;
@property(strong,nonatomic) NSTimer * timer;


/**
 *  广告点击事件的block 回调
 */
@property(copy,nonatomic) admobSelectBlcok admobSelect;

/**
 *  广告点击事件的代理
 */
@property(assign,nonatomic) id<BRAdmobSelectDelegate>selectDelegate;

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray*)data andInViewe:(UIView*)view;




/**
 *  增加 UIPageControl
 *
 *  @param size <#size description#>
 */
-(void)addPageControlViewWithSize:(CGSize)size WithPostion:(KPageControlPostion)postion;
/**
 *  刷新数据，并且刷新PageControl
 *
 *  @param pageControl <#pageControl description#>
 */
-(void)reloadDataAndReloadPageControl:(BOOL)pageControl;
@end

@interface AdmobInfo : NSObject

@property(copy,nonatomic) NSString * admobId;
@property(copy,nonatomic) NSString * admobName;

@property(copy,nonatomic) NSString * url;
@property(strong,nonatomic) UIImage * defultImage;
@end
