//
//  MLKMenuPopover.m
//  MLKMenuPopover
//
//  Created by 林泽琛 on 20/11/15.
//  Copyright (c) 2015 林泽琛. All rights reserved.
//

#import "MLKMenuPopover.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define MENU_ITEM_HEIGHT        40
#define FONT_SIZE               15
#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define MENU_TABLE_VIEW_FRAME   MYCGRect(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     MYCGRect(10, MENU_ITEM_HEIGHT - 1, self.frame.size.width - 20, 1)
#define MENU_POINTER_RECT       MYCGRect(280, 0, 25, 22)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.05f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

@interface MLKMenuPopover ()

@property(nonatomic,retain) NSArray *menuItems;
@property(nonatomic,retain) UIButton *containerButton;

- (void)hide;
- (void)addSeparatorImageToCell:(UITableViewCell *)cell;

@end

@implementation MLKMenuPopover

@synthesize menuPopoverDelegate;
@synthesize menuItems;
@synthesize containerButton;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.menuItems = aMenuItems;
        self.buttontag=@"1";
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
        [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        // Adding Menu Options Pointer
        UIImageView *menuPointerView = [[UIImageView alloc] initWithFrame:MENU_POINTER_RECT];
        menuPointerView.image = [UIImage imageNamed:@"sanjiaoxing"];
        menuPointerView.tag = MENU_POINTER_TAG;
        [self.containerButton addSubview:menuPointerView];
        
        // Adding menu Items table
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:MYCGRect(0, 11, frame.size.width, frame.size.height)];
        
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
        menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuItemsTableView.scrollEnabled = YES;
        menuItemsTableView.backgroundColor = [UIColor clearColor];
        menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbg"]];
        bgView.layer.borderColor=[[UIColor whiteColor]CGColor];
        bgView.layer.borderWidth=0;
        bgView.layer.masksToBounds=YES;
        bgView.layer.cornerRadius=5;
        menuItemsTableView.backgroundView = bgView;
        
        [self addSubview:menuItemsTableView];
        
        [self.containerButton addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_ITEM_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    NSArray * image=@[@"right0",@"right1",@"right2",@"right3",@"right4",@"right5"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        [cell.imageView setImage:[UIImage imageNamed:@"right_menu_QR"]];

    }
    
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    if( [tableView numberOfRowsInSection:indexPath.section] > ONE && !(indexPath.row == numberOfRows - 1) )
    {
        [self addSeparatorImageToCell:cell];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:image[indexPath.row]]];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark Actions

- (void)dismissMenuPopover
{
    [self hide];
    self.buttontag=@"0";
}

- (void)showInView:(UIView *)view
{
    self.containerButton.alpha = ZERO;
    self.containerButton.frame = view.bounds;
    [view addSubview:self.containerButton];
        
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ONE;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                     }];
}

#pragma mark -
#pragma mark Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UILabel *separatorImageView = [[UILabel alloc] initWithFrame:SEPERATOR_LINE_RECT];
//    [separatorImageView setImage:[UIImage imageNamed:@"DefaultLine"]];
//    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark -
#pragma mark Orientation Methods

- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
    
    if( landscape )
    {
        menuPointerView.frame = MYCGRect(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = MYCGRect(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
    else
    {
        menuPointerView.frame = MYCGRect(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
        
        menuItemsTableView.frame = MYCGRect(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
    }
}

@end

