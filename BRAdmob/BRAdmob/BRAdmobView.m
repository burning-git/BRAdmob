//
//  BRAdmobView.m
//  BRAdmob
//
//  Created by gitBurning on 15/4/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "BRAdmobView.h"
#import "AdmobCollectionViewCell.h"
#define kIndexCell @"AdmobCollectionViewCell"
#define kAdmobScreenWidth [UIScreen mainScreen].bounds.size.width

#import "UIImageView+WebCache.h"
#define kDefaultTime 5

@implementation BRAdmobView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data andInViewe:(UIView *)view{
    
    
    if ([super initWithFrame:frame]) {
        self.dataArray=data;
        [self addColletionViewInView:view];
        
        self.backgroundColor=[UIColor whiteColor];
    }
    
    return self;
}

-(void)addColletionViewInView:(UIView*)view{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing=0.f;//左右间隔
    flowLayout.minimumLineSpacing=0.f;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0,kAdmobScreenWidth,self.frame.size.height) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    self.collectionView.showsHorizontalScrollIndicator=NO;
    UINib *nib=[UINib nibWithNibName:kIndexCell bundle:nil];
    
    [self.collectionView registerNib: nib forCellWithReuseIdentifier:kIndexCell];

    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled=YES;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    
    
    self.titileView=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-32, self.frame.size.width, 32)];
    [self addSubview:self.titileView];
    self.titileView.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _titileLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, 192, self.titileView.frame.size.height-6*2)];
    [_titileView addSubview:_titileLabel];
    _titileLabel.textAlignment=NSTextAlignmentCenter;
    //0,6,192,21;
}
-(void)addPageControlViewWithSize:(CGSize)size
{
   
    
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    float margin=10;
    float witdth=size.width* self.dataArray.count + margin*(self.dataArray.count-1);
    float height=size.height;
    
    self.pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width-witdth, self.frame.size.height-height-(32-height)/2, witdth, height)];
    self.pageControl.numberOfPages=self.dataArray.count;
    self.pageControl.currentPage=0;

    self.pageControl.currentPageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    [self addSubview:self.pageControl];
    
    self.pageControl.selected=NO;
}

//-(void)setIsBounces:(BOOL)isBounces{
//    _isBounces=isBounces;
//    self.collectionView.bounces=isBounces;
//}
-(void)setIsPagingEnabled:(BOOL)isPagingEnabled{
    _isPagingEnabled=isPagingEnabled;
    self.collectionView.pagingEnabled=isPagingEnabled;
}
-(void)reloadDataAndReloadPageControl:(BOOL)pageControl{
    [self.collectionView reloadData];
}



#pragma mark---顶部的滑动试图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // return allSpaces.count;
    return self.dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (!self.allowSelect) {
        return;
    }
    AdmobInfo *info=self.dataArray[indexPath.row];

    if (self.admobSelect) {
        self.admobSelect(info,indexPath.row);
    }
    else{
        
        if (self.selectDelegate) {
            [self.selectDelegate admobView:self SelectIndex:indexPath.row andOther:info];
        }
    }
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AdmobCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kIndexCell forIndexPath:indexPath];
//    UILabel * line=[[UILabel alloc] initWithFrame:CGRectMake(self.topWidth-0.5, 0,0.5 ,CGRectGetHeight(cell.frame)-0.5)];
//    line.backgroundColor=[UIColor lightGrayColor];
//    
//    if (!_isNeedCustomWidth) {
//        [cell insertSubview:line atIndex:cell.subviews.count-1];
//        
//    }
    AdmobInfo *info=self.dataArray[indexPath.row];
    if (info.admobName.length<=0) {
        self.titileView.hidden=YES;
    }else{
        self.titileLabel.text=info.admobName;
        
        self.titileView.hidden=NO;

    }
    
    
    [cell.admobImage sd_setImageWithURL:[NSURL URLWithString:info.url] placeholderImage:info.defultImage];
      return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kAdmobScreenWidth, self.frame.size.height);
}



#pragma mark--计算 pageConrtoll
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    [self stopTimer:YES];
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    [self stopTimer:YES];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
NSInteger index=scrollView.contentOffset.x/self.frame.size.width;
    
    self.pageControl.currentPage=index;
    indexScoller=index+1;
    [self performSelector:@selector(deleyTime) withObject:nil afterDelay:self.autoTime];
}
/**
 *  延迟 定时器
 */
-(void)deleyTime{
    [self stopTimer:NO];

}

-(void)setIsAutoScoller:(BOOL)isAutoScoller{
    if (isAutoScoller) {
        
        self.timer=[NSTimer timerWithTimeInterval:self.autoTime target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.timer fire];
        
        
    }
}

/**
 *  是否暂停
 *
 *  @param isStop <#isStop description#>
 */
-(void)stopTimer:(BOOL)isStop{
    if (!isStop) {
        [self.timer setFireDate:[NSDate distantPast]];

    }
    else{
        [self.timer setFireDate:[NSDate distantFuture]];

    }
}
-(void)autoScrollView{
    
    BOOL isAnmiation=YES;
    if (indexScoller>=self.dataArray.count) {
        indexScoller=1;
        isAnmiation=NO;
    }
    else{
        indexScoller++;

    }
    NSLog(@"idnex%ld",indexScoller);
    
     [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexScoller-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:isAnmiation];
    
    self.pageControl.currentPage=indexScoller-1;
    
}

-(NSInteger)autoTime{
    
    if (_autoTime<=0) {
        _autoTime=kDefaultTime;
    }
    return _autoTime;
}

-(void)dealloc{
    [self.timer invalidate];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

}
@end



@implementation AdmobInfo



@end
