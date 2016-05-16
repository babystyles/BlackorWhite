//
//  MainTableViewCell.m
//  BlackorWhite
//
//  Created by 林泽琛 on 16/1/7.
//  Copyright © 2016年 林泽琛. All rights reserved.
//

#import "MainTableViewCell.h"
#import "AppDelegate.h"
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        AppDelegate * app = [[UIApplication sharedApplication] delegate];
        self.headview =[[UIImageView alloc]initWithFrame:MYCGRect(15, 5, 50, 50)];
        [self.headview.layer setMasksToBounds:YES];
        self.headview.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self.headview.layer setBorderWidth:1];
        [self.headview.layer setCornerRadius:25*app.autoSizeScaleX];
        [self.headview setImage:[UIImage imageNamed:@"head"]];
        [self addSubview:self.headview];
        
        self.username =[[UILabel alloc]initWithFrame:MYCGRect(75, 8, 200, 20)];
        [self.username setText:@"懒猪"];
        [self.username setFont:[UIFont boldSystemFontOfSize:17]];
        [self.username setTextColor:[UIColor blackColor]];
        [self addSubview:self.username];
        
        self.content =[[UILabel alloc]initWithFrame:MYCGRect(75, 30, 200, 20)];
        [self.content setText:@"查看今日数据"];
        [self.content setFont:[UIFont systemFontOfSize:15]];
        [self.content setTextColor:[UIColor grayColor]];
        [self addSubview:self.content];
        
        self.time =[[UILabel alloc]initWithFrame:MYCGRect(275, 15, 40, 20)];
        [self.time setText:@"21:22"];
        [self.time setFont:[UIFont systemFontOfSize:12]];
        [self.time setTextColor:[UIColor grayColor]];
        [self addSubview:self.time];
        
    }
    return self;
}


CG_INLINE CGRect
MYCGRect(CGFloat x,CGFloat y,CGFloat width,CGFloat height){
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    
    CGRect rect;
    rect.origin.x = x * app.autoSizeScaleX;
    rect.origin.y = y * app.autoSizeScaleY;
    rect.size.width = width * app.autoSizeScaleX;
    
    rect.size.height = height * app.autoSizeScaleY;
    
    return rect;
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
