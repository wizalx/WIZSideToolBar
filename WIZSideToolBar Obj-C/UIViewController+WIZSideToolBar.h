//
//  UIViewController+WIZSideToolBar.h
//  customElementh
//
//  Created by a.vorozhishchev on 02/05/2019.
//  Copyright © 2019 a.vorozhishchev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WIZToolBarButton : NSObject

@property (nonatomic, readonly) UIImage *icon;
@property (nonatomic, readonly) NSString *title;

-(id)initWithIcon:(UIImage*)icon title:(NSString*)title;

@end

@protocol WIZSideToolBarDelegate <NSObject>

-(NSArray <WIZToolBarButton*>*)WIZSideToolBarButtonImages;
-(void)WIZSideToolBarTapButton:(int)index;

@end

@interface UIViewController (WIZSideToolBar)

-(void)addWIZSideToolBar;
@property (nonatomic) id <WIZSideToolBarDelegate> delegate;

//@property (nonatomic, readonly) UIView *barView;
//@property (nonatomic, readonly) UIView *tongueView;

@end



NS_ASSUME_NONNULL_END
