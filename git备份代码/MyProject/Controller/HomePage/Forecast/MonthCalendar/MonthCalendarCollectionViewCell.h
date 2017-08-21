//
//  MonthCalendarCollectionViewCell.h
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthCalendarCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSDate *beginDate;
@property(nonatomic,strong) void(^daySelect)(NSDate *date);
@end
