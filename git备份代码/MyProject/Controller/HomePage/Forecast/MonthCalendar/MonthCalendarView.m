//
//  MonthCalendarView.m
//  ClubProject
//
//  Created by jiaming yan on 2017/5/2.
//  Copyright © 2017年 Reneve. All rights reserved.
//

#import "MonthCalendarView.h"
#import "MonthCalendarOwner.h"
#import "MonthCalendarCommon.h"

@interface MonthCalendarView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *weekNameView;
@end
@implementation MonthCalendarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat calendarDayWidth = self.mj_w/7.0;
        NSArray *weekSymbol = [[NSArray alloc] initWithObjects: @"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",  nil];
        for (int i = 0; i < weekSymbol.count; i++)
        {
            NSString *daySymbol = (NSString *)[weekSymbol objectAtIndex: i];
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(calendarDayWidth * i, 8, calendarDayWidth, WeekNameHeight-8)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize: 15.0];;
            label.text = daySymbol;
            label.textColor = kWhiteColor;
            label.textAlignment = NSTextAlignmentCenter;
            [self.weekNameView addSubview: label];
        }
        [self addSubview:self.weekNameView];
        [self addSubview:self.collectionView];
        [_collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:12 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
    }
    return self;
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.itemSize = CGSizeMake(self.mj_w , 38*6);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, WeekNameHeight, self.mj_w, 38*6) collectionViewLayout:flowLayout ];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MonthCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MonthCalendarCollectionViewCell"];
    }
    return _collectionView;
}
-(UIView *)weekNameView{
    if (!_weekNameView) {
        _weekNameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 30)];
        _weekNameView.backgroundColor = UIColorFromRGB(0xFFC849);
    }
    return _weekNameView;
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  12*2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MonthCalendarCollectionViewCell";
    
    MonthCalendarCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kClearColor;
    if (!self.firstDate) {
        self.firstDate = [NSDate date];
    }
    NSDate *date = [self.firstDate dateByAddingMonths:(indexPath.row - 12 )];
    cell.beginDate = date;
    __weak typeof(self) weakSelf = self;
    cell.daySelect = ^(NSDate *date){
        if ([weakSelf.monthCalendarDelete respondsToSelector:@selector(MonthCalendarView:didSelectDate:)]) {
            [weakSelf.monthCalendarDelete MonthCalendarView:weakSelf didSelectDate:date];
        }
    };
    return cell;
    
}
-(void)setFirstDate:(NSDate *)firstDate{
    _firstDate = firstDate;
    [MonthCalendarOwner sharedMonthCalendarOwner].selectedDate = firstDate;
    [_collectionView reloadData];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    NSDate *date = [self.firstDate dateByAddingMonths:(index - 12)];
    if ([self.monthCalendarDelete respondsToSelector:@selector(MonthCalendarView:scrollToMonthDate:)]) {
        [self.monthCalendarDelete MonthCalendarView:self scrollToMonthDate:date];
    }
}
- (void)jumpToToday{
    NSDate *todayDate = [NSDate date];
    self.firstDate = [todayDate dateMonday];
    [MonthCalendarOwner sharedMonthCalendarOwner].selectedDate = todayDate;
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}
- (void)jumpToDate:(NSDate *)date{
    NSDate *todayDate = date;
    self.firstDate = date;
    [MonthCalendarOwner sharedMonthCalendarOwner].selectedDate = todayDate;
    [_collectionView reloadData];
    
    NSInteger month = [self.firstDate totalMonthWithDate:[NSDate date]];
    [_collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:(11 - month) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
