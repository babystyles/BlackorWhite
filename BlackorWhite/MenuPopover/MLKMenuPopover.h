//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by 林泽琛 on 20/11/15.
//  Copyright (c) 2015 林泽琛. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLKMenuPopover;

@protocol MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex;

@end

@interface MLKMenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<MLKMenuPopoverDelegate> menuPopoverDelegate;
@property(strong,nonatomic) NSString *buttontag;
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

