//
//  UIViewController+WIZSideToolBar.m
//  customElementh
//
//  Created by a.vorozhishchev on 02/05/2019.
//  Copyright © 2019 a.vorozhishchev. All rights reserved.
//

#import "UIViewController+WIZSideToolBar.h"
#import "WIZToolBoxBtn/WIZToolBoxBtn.h"
#import <objc/runtime.h>

#pragma mark - WIZToolBarButton Object
#pragma mark -

@interface WIZToolBarButton()
{
    UIImage *localIcon;
    NSString *localTitle;
}

@end

@implementation WIZToolBarButton

-(id)initWithIcon:(UIImage *)icon title:(NSString *)title
{
    self = [super init];
    localIcon = icon;
    localTitle = title;
    
    return self;
}

-(UIImage*)icon
{
    return localIcon;
}

-(NSString*)title
{
    return localTitle;
}

@end

#pragma mark - view controller category
#pragma mark -

static char const * const delegateKey = "delegateKey";

@implementation UIViewController (WIZSideToolBar)

#pragma mark - delegate set get

- (void)setDelegate:(id<WIZSideToolBarDelegate>)delegate
{
    objc_setAssociatedObject(self, delegateKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<WIZSideToolBarDelegate>)delegate
{
    return objc_getAssociatedObject(self, delegateKey);
}

#pragma mark - barView set get

-(UIView*)barView
{
    return [self.view viewWithTag:8951];
}

#pragma mark - tongueView set get

-(UIView*)tongueView
{
    return [self.view viewWithTag:7805];
}

#pragma mark - calculate positions

-(CGRect)hiddenToolBarFrame
{
    CGRect frame = self.barView.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    return frame;
}

-(CGRect)showenToolBarFrame
{
    CGRect frame = self.barView.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width - 50;
    return frame;
}

-(CGRect)hiddenTongueViewFrame
{
    CGRect frame = self.tongueView.frame;
    frame.origin.x = 10*([UIScreen mainScreen].bounds.size.width/11);
    return frame;
}

-(CGRect)showenTongueViewFrame
{
    CGRect frame = self.tongueView.frame;
    frame.origin.x = (10*([UIScreen mainScreen].bounds.size.width/11)) - 50;
    return frame;
}

#pragma mark - add bar

-(void)addWIZSideToolBar
{
    //    NSArray <WIZToolBarButton*> *toolBarButtons = [self.delegate WIZSideToolBarButtonImages];
    [self.view addSubview:[self createTongueView]];
    [self.view addSubview:[self toolBoxView]];
}

-(UIView*)createTongueView
{
    float widthScreen = [UIScreen mainScreen].bounds.size.width;
    float heightScreen = [UIScreen mainScreen].bounds.size.height;
    
    UIView *tongueView = [[UIView alloc] initWithFrame:CGRectMake(10*(widthScreen/11), self.navigationController ? heightScreen/2 - 110 : heightScreen/2 - 50, widthScreen/11, 100)];
    tongueView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    
    tongueView.tag = 7805;
    
    tongueView.layer.zPosition = 1000;
    
    //create corner radius
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tongueView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft) cornerRadii:CGSizeMake(widthScreen/22, widthScreen/22)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = tongueView.bounds;
    maskLayer.path  = maskPath.CGPath;
    tongueView.layer.mask = maskLayer;
    
    //add lines
    int countLine = 3;
    for (int i = 1; i < countLine+1; i++) {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        float x = ((tongueView.bounds.size.width/(countLine+1))*i)+2;
        [linePath moveToPoint:CGPointMake(x, 10)];
        [linePath addLineToPoint:CGPointMake(x, tongueView.bounds.size.height - 10)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [linePath CGPath];
        shapeLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
        shapeLayer.lineWidth = 1.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        
        [tongueView.layer addSublayer:shapeLayer];
    }
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolBar)];
    [tongueView addGestureRecognizer:tapGesture];
    
    return tongueView;
    
}

-(UIView*)toolBoxView
{
    NSArray <WIZToolBarButton*> *toolBarButtons = [self.delegate WIZSideToolBarButtonImages];
    float widthScreen = [UIScreen mainScreen].bounds.size.width;
    float heightScreen = [UIScreen mainScreen].bounds.size.height;
    
    float calculateHeightBarView = 5 + toolBarButtons.count * 55;
    
    calculateHeightBarView = calculateHeightBarView >= 100 ? calculateHeightBarView : 100;
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(widthScreen,  self.navigationController ? heightScreen/2 - calculateHeightBarView/2 - 60 : heightScreen/2 - calculateHeightBarView/2, 55, calculateHeightBarView)];
    barView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    barView.tag = 8951;
    
    barView.layer.zPosition = 1000;
    
    for (int i = 0; i < toolBarButtons.count; i++) {
        WIZToolBarButton *barButton = toolBarButtons[i];
        WIZToolBoxBtn *btnView = [[WIZToolBoxBtn alloc] initWithFrame:CGRectMake(2.5, 5*(i+1) + 50*i , 50, 50)];
        btnView.titleStr = barButton.title;
        btnView.image = barButton.icon;
        [barView addSubview:btnView];
        
        btnView.tapBlock = ^{
            [self.delegate WIZSideToolBarTapButton:i];
        };
    }
    
    //create corner radius
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:barView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft) cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = barView.bounds;
    maskLayer.path  = maskPath.CGPath;
    barView.layer.mask = maskLayer;
    
    return barView;
    
}


-(void)showToolBar
{
    if (self.barView.frame.origin.x < [UIScreen mainScreen].bounds.size.width) {
        [UIView animateWithDuration:0.3 animations:^{
            self.barView.frame = [self hiddenToolBarFrame];
            self.tongueView.frame = [self hiddenTongueViewFrame];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.barView.frame = [self showenToolBarFrame];
            self.tongueView.frame = [self showenTongueViewFrame];
        }];
        
    }
}

@end
