//
//  ZJSpreadCell.h
//  BlackorWhite
//
//  Created by 林泽琛 on 16/2/4.
//  Copyright © 2016年 林泽琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ZJSpreadCellDelegate <NSObject>

@optional

-(void)ZJSpreadCellDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface ZJSpreadCell : UITableViewCell
@property (nonatomic,weak) id<ZJSpreadCellDelegate> delegate;
@property(nonatomic,weak)UITableView *tableView;
/**名字的label*/
@property(nonatomic,weak)UILabel *nameLable;
/**旋转的箭头图片*/
@property(nonatomic,weak)UIImageView *arrowImageView;
/**分组的数组*/
@property(strong,nonatomic)NSArray * nameArray;

/**设置图片箭头旋转*/
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold;

@end
