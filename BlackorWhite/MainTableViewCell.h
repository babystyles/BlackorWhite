//
//  MainTableViewCell.h
//  BlackorWhite
//
//  Created by 林泽琛 on 16/1/7.
//  Copyright © 2016年 林泽琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView * headview;
@property(strong,nonatomic)UILabel *username;
@property(strong,nonatomic)UILabel *content;
@property(strong,nonatomic)UILabel *time;
@end
