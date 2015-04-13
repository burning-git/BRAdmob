//
//  AdmobCollectionViewCell.h
//  BRAdmob
//
//  Created by gitBurning on 15/4/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdmobCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *admobImage;

@property (weak, nonatomic) IBOutlet UIView *titileView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@end
