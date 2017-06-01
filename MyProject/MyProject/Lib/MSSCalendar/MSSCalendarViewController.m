//
//  MSSCalendarViewController.m
//  MSSCalendar
//
//  Created by 于威 on 16/4/3.
//  Copyright © 2016年 于威. All rights reserved.
//

#import "MSSCalendarViewController.h"
#import "MSSCalendarCollectionViewCell.h"
#import "MSSCalendarHeaderModel.h"
#import "MSSCalendarManager.h"
#import "MSSCalendarCollectionReusableView.h"
#import "MSSCalendarPopView.h"
#import "MSSCalendarDefine.h"

@interface MSSCalendarViewController ()
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *tempPriceArray;
@property (nonatomic,strong)MSSCalendarPopView *popView;
@property (nonatomic,assign)BOOL isShowTop;

@end

@implementation MSSCalendarViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _afterTodayCanTouch = YES;
        _beforeTodayCanTouch = YES;
        _dataArray = [[NSMutableArray alloc]init];
        _showChineseCalendar = NO;
        _showChineseHoliday = NO;
        _showHolidayDifferentColor = NO;
        _showAlertView = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Choose Date", nil);;
    __weak typeof(self) weakSelf = self;
    [self showProgressWithView:self.view animated:YES];
    [SendRequest requestCalendarHeatWithOrigin:self.originStr dest:self.destStr  result:^(id result, NSError *error){
        /**本次旅行的最低票价*/
        [weakSelf hideProgress:self.view animated:YES];
        if ([result[@"result"] integerValue] == 1) {
            weakSelf.isShowTop = YES;
            weakSelf.priceArr = [NSMutableArray arrayWithArray:result[@"data"][@"fareinfo"]];
            weakSelf.tempPriceArray = [NSMutableArray array];
            for (int  i =0; i<[self.priceArr count]-1; i++) {
                
                for (int j = i+1; j<[self.priceArr count]; j++) {
                    
                    if ([weakSelf.priceArr[i][@"avgfare"] floatValue]>[weakSelf.priceArr[j][@"avgfare"] floatValue]) {
                        
                        //交换
                        
                        [weakSelf.priceArr exchangeObjectAtIndex:i withObjectAtIndex:j];
                        
                    }
                    
                }
                
            }
            if (weakSelf.priceArr.count > 0) {
                CGFloat  lowestPrice = [weakSelf.priceArr.firstObject[@"avgfare"] floatValue];
                CGFloat  highestPrice = [weakSelf.priceArr.lastObject[@"avgfare"] floatValue];
                
                CGFloat temp = highestPrice - lowestPrice;
                NSInteger rang = 0;
                
                for (NSInteger i = 50; (temp/4) > i; i = i + 50) {
                    NSLog(@"%zd",i);
                    rang = i;
                }
                if (rang == 0) {
                    rang = 50;
                }
                NSInteger wanwei = (((NSInteger )lowestPrice)/10000);
                NSInteger qianwei = (((NSInteger )lowestPrice)%10000/1000);
                NSInteger baiwei = (((NSInteger )lowestPrice)%1000/100);
                NSInteger shiwei = (((NSInteger )lowestPrice)%100/10);
                NSString *strLow = nil;
                if (shiwei < 5) {
                    strLow = [NSString stringWithFormat:@"%zd%zd%zd00",wanwei,qianwei,baiwei];
                    NSLog(@"%@",strLow);
                }else{
                    strLow = [NSString stringWithFormat:@"%zd%zd%zd50",wanwei,qianwei,baiwei];
                    NSLog(@"%@",strLow);
                }
                
                
                NSInteger wanweiH = (((NSInteger )highestPrice)/10000);
                NSInteger qianweiH = (((NSInteger )highestPrice)%10000/1000);
                NSInteger baiweiH = (((NSInteger )highestPrice)%1000/100);
                NSInteger shiweiH = (((NSInteger )highestPrice)%100/10);
                NSString *strH  = nil;
                if (shiweiH < 5) {
                    strH = [NSString stringWithFormat:@"%zd%zd%zd50",wanweiH,qianweiH,baiweiH];
                    NSLog(@"%@",strH);
                }else{
                    strH = [NSString stringWithFormat:@"%zd%zd%zd00",wanweiH,qianweiH,baiweiH+1];
                    NSLog(@"%@",strH);
                }
                for (NSInteger i = 0; i < 4; i++) {
                    NSInteger price = rang*i + [strLow integerValue];
                    [weakSelf.tempPriceArray addObject:[NSString stringWithFormat:@"%zd",price]];
                    
                    UILabel *lab = [CommonUtils createLabelWithText:[NSString stringWithFormat:@"$%zd+",price] frame:CGRectMake(kScreenWidth/4*i + 15, 8, (kScreenWidth/4-30), 25)];
                    lab.clipsToBounds = YES;
                    lab.layer.cornerRadius = 4;
                    if (i == 0) {
                        lab.backgroundColor = UIColorFromRGB(0x6DC28A);
                        
                    }else if (i == 1) {
                        lab.backgroundColor = UIColorFromRGB(0xF09F2B);
                    }else if (i == 2) {
                        lab.backgroundColor = UIColorFromRGB(0xE46524);
                    }else if (i == 3) {
                        lab.backgroundColor = UIColorFromRGB(0xC2091E);
                    }
                    
                    lab.textAlignment = NSTextAlignmentCenter;
                    [self.view addSubview:lab];
                }

                
            }
            
            
            
            [self initDataSource];
            [self createUI];
        }else{
            weakSelf.isShowTop = NO;
            [self initDataSource];
            [self createUI];
            [CommonUtils showToast:NSLocalizedString(@"The airline not opened, please be waite", nil)];
        }
        
    }];
   
}
-(void)doBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(_popView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
    }
}

- (void)initDataSource
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MSSCalendarManager *manager = [[MSSCalendarManager alloc]initWithShowChineseHoliday:_showChineseHoliday showChineseCalendar:_showChineseCalendar startDate:_startDate];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:_limitMonth type:_type];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataArray addObjectsFromArray:tempDataArray];
            [self showCollectionViewWithStartIndexPath:manager.startIndexPath];
        });
    });
}

- (void)addWeakView
{
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, MSS_SCREEN_WIDTH, MSS_WeekViewHeight)];
    if (!self.isShowTop) {
        weekView.frame = CGRectMake(0, 0, MSS_SCREEN_WIDTH, MSS_WeekViewHeight);
    }
    weekView.backgroundColor = UIColorFromRGB(0xE8EDF1);
    [self.view addSubview:weekView];
    
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    int i = 0;
    NSInteger width = MSS_Iphone6Scale(54);
    for(i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, MSS_WeekViewHeight)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        if(i == 0 || i == 6)
        {
            weekLabel.textColor = MSS_WeekEndTextColor;
        }
        else
        {
            weekLabel.textColor = MSS_WeekTitleTextColor;
        }
        [weekView addSubview:weekLabel];
    }
}

- (void)showCollectionViewWithStartIndexPath:(NSIndexPath *)startIndexPath
{
    [self addWeakView];
    [_collectionView reloadData];
    // 滚动到上次选中的位置
    if(startIndexPath)
    {
        [_collectionView scrollToItemAtIndexPath:startIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - MSS_HeaderViewHeight);
    }
    else
    {
        if(_type == MSSCalendarViewControllerLastType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }
        }
        else if(_type == MSSCalendarViewControllerMiddleType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(_dataArray.count - 1) / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - MSS_HeaderViewHeight);
            }
        }
    }
}

- (void)createUI
{
    NSInteger width = MSS_Iphone6Scale(54);
    NSInteger height = MSS_Iphone6Scale(60);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.headerReferenceSize = CGSizeMake(MSS_SCREEN_WIDTH, MSS_HeaderViewHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MSS_WeekViewHeight + 40, width * 7, MSS_SCREEN_HEIGHT - 64 - MSS_WeekViewHeight - 40) collectionViewLayout:flowLayout];
    if (!self.isShowTop) {
        _collectionView.frame = CGRectMake(0, MSS_WeekViewHeight, width * 7, MSS_SCREEN_HEIGHT - 64 - MSS_WeekViewHeight);
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[MSSCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell"];
    [_collectionView registerClass:[MSSCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MSSCalendarCollectionReusableView"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MSSCalendarHeaderModel *headerItem = _dataArray[section];
    return headerItem.calendarItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSSCalendarCollectionViewCell" forIndexPath:indexPath];
    cell.backView.hidden = YES;
    if(cell)
    {
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        MSSCalendarModel *calendarItem = headerItem.calendarItemArray[indexPath.row];
        
//        if (cell.subLabel.text.length == 0) {
//            cell.backView.hidden = YES;
//        }else{
//            cell.backView.hidden = NO;
//        }
        cell.dateLabel.text = @"";
        cell.dateLabel.textColor = MSS_TextColor;
        cell.subLabel.text = @"";
        cell.subLabel.textColor = MSS_SelectSubLabelTextColor;
        cell.isSelected = NO;
        cell.subLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        cell.userInteractionEnabled = NO;
        if(calendarItem.day > 0)
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
            cell.backView.hidden = NO;
            cell.userInteractionEnabled = YES;
            NSString *strDay = [NSString stringWithFormat:@"%04zd-%02zd-%02zd",calendarItem.year,calendarItem.month,calendarItem.day];
            for (NSInteger i = 0; i < self.priceArr.count; i ++) {
                if ([self.priceArr[i][@"dept_date"] isEqualToString:strDay]) {
                    if ([self.priceArr[i][@"avgfare"] floatValue] >= [self.tempPriceArray[0] floatValue] &&[self.priceArr[i][@"avgfare"] floatValue] < [self.tempPriceArray[1] floatValue]) {
                        cell.backView.backgroundColor = UIColorFromRGB(0x6DC28A);
                    }else if ([self.priceArr[i][@"avgfare"] floatValue] >= [self.tempPriceArray[1] floatValue] &&[self.priceArr[i][@"avgfare"] floatValue] < [self.tempPriceArray[2] floatValue]) {
                        cell.backView.backgroundColor = UIColorFromRGB(0xF09F2B);
                    }else if ([self.priceArr[i][@"avgfare"] floatValue] >= [self.tempPriceArray[2] floatValue] &&[self.priceArr[i][@"avgfare"] floatValue] < [self.tempPriceArray[3] floatValue]) {
                        cell.backView.backgroundColor = UIColorFromRGB(0xE46524);
                    }else if ([self.priceArr[i][@"avgfare"] floatValue] >= [self.tempPriceArray[0] floatValue]) {
                        cell.backView.backgroundColor = UIColorFromRGB(0xC2091E);
                    }
                    
//                    if ([self.priceArr[i][@"avgfare"] floatValue] > [self.tempPriceArray[3] floatValue]) {
//                        cell.backView.backgroundColor = UIColorFromRGB(0xC2091E);
//                    }else if ([self.priceArr[i][@"avgfare"] floatValue] > [self.tempPriceArray[2] floatValue]) {
//                        cell.backView.backgroundColor = UIColorFromRGB(0xE46524);
//                    }else if ([self.priceArr[i][@"avgfare"] floatValue] > [self.tempPriceArray[1] floatValue]) {
//                        cell.backView.backgroundColor = UIColorFromRGB(0xF09F2B);
//                    }else if ([self.priceArr[i][@"avgfare"] floatValue] > [self.tempPriceArray[0] floatValue]) {
//                        cell.backView.backgroundColor = UIColorFromRGB(0x6DC28A);
//                    }
                    cell.backView.hidden = NO;
                    cell.dateLabel.textColor = kWhiteColor;
//                    cell.subLabel.textColor = kWhiteColor;
                    break;
                }else{
                    cell.backView.hidden = YES;
                }
                
            }
            if (self.priceArr.count == 0) {
                cell.backView.hidden = YES;
            }
        }
        if(_showChineseCalendar)
        {
            cell.subLabel.text = calendarItem.chineseCalendar;
        }
        
        // 开始日期
        if(calendarItem.dateInterval == _startDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = kWhiteColor;
            cell.subLabel.text = MSS_SelectBeginText;
            cell.subLabel.textColor = MSS_SelectEndTextColor;
            cell.subLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        }
        // 结束日期
        else if (calendarItem.dateInterval == _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = kWhiteColor;
            cell.subLabel.text = MSS_SelectEndText;
            cell.subLabel.textColor = MSS_SelectEndTextColor;
            cell.subLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        }
        // 开始和结束之间的日期
        else if(calendarItem.dateInterval > _startDate && calendarItem.dateInterval < _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = kWhiteColor;
        }
        else
        {
            if(calendarItem.week == 0 || calendarItem.week == 6)
            {
                cell.dateLabel.textColor = MSS_WeekEndTextColor;
                cell.subLabel.textColor = MSS_WeekEndTextColor;
                if (cell.backView.hidden == NO) {
                    cell.dateLabel.textColor = kWhiteColor;
//                    cell.subLabel.textColor = kWhiteColor;
                }
                
            }
            if(calendarItem.holiday.length > 0)
            {
                cell.dateLabel.text = calendarItem.holiday;
                if(_showHolidayDifferentColor)
                {
                    cell.dateLabel.textColor = MSS_HolidayTextColor;
                    cell.subLabel.textColor = MSS_HolidayTextColor;
                    if (cell.backView.hidden == NO) {
                        cell.dateLabel.textColor = kWhiteColor;
//                        cell.subLabel.textColor = kWhiteColor;
                    }
                }
            }
        }
        
        if(!_afterTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarNextType)
            {
                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
                cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
        if(!_beforeTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarLastType)
            {
                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
                cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
        
//        cell.dateLabel.textColor = kWhiteColor;
////        cell.subLabel.text = @"";
//        cell.subLabel.textColor = kWhiteColor;
    }
    return cell;
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MSSCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MSSCalendarCollectionReusableView" forIndexPath:indexPath];
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.headerLabel.text = headerItem.headerText;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    MSSCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
    if (self.oneWay) {
        _startDate = calendaItem.dateInterval;
        _endDate = calendaItem.dateInterval;
        if([_delegate respondsToSelector:@selector(calendarViewConfirmClickWithStartDate:endDate:vc:)])
        {
            [_delegate calendarViewConfirmClickWithStartDate:_startDate endDate:_endDate vc:self];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    // 当开始日期为空时
    if(_startDate == 0)
    {
        _startDate = calendaItem.dateInterval;
        [self showPopViewWithIndexPath:indexPath];
    }
    // 当开始日期和结束日期同时存在时(点击为重新选时间段)
    else if(_startDate > 0 && _endDate > 0)
    {
        _startDate = calendaItem.dateInterval;
        _endDate = 0;
        [self showPopViewWithIndexPath:indexPath];
    }
    else
    {
        // 判断第二个选择日期是否比现在开始日期大
        if(_startDate < calendaItem.dateInterval)
        {
            _endDate = calendaItem.dateInterval;
            if([_delegate respondsToSelector:@selector(calendarViewConfirmClickWithStartDate:endDate:vc:)])
            {
                [_delegate calendarViewConfirmClickWithStartDate:_startDate endDate:_endDate vc:self];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            _startDate = calendaItem.dateInterval;
            [self showPopViewWithIndexPath:indexPath];
        }
    }
    [_collectionView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(_popView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
    }
}

- (void)showPopViewWithIndexPath:(NSIndexPath *)indexPath;
{
    if(_showAlertView)
    {
        [_popView removeFromSuperview];
        _popView = nil;
        
        MSSCalendarPopViewArrowPosition arrowPostion = MSSCalendarPopViewArrowPositionMiddle;
        NSInteger position = indexPath.row % 7;
        if(position == 0)
        {
            arrowPostion = MSSCalendarPopViewArrowPositionLeft;
        }
        else if(position == 6)
        {
            arrowPostion = MSSCalendarPopViewArrowPositionRight;
        }
        
        MSSCalendarCollectionViewCell *cell = (MSSCalendarCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        _popView = [[MSSCalendarPopView alloc]initWithSideView:cell.dateLabel arrowPosition:arrowPostion];
        _popView.topLabelText = [NSString stringWithFormat:@"请选择%@日期",MSS_SelectEndText];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM月dd日"MSS_SelectBeginText];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        _popView.bottomLabelText = startDateString;
        [_popView showWithAnimation];
    }
}

@end
