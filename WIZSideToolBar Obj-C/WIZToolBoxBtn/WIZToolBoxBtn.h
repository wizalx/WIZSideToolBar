//
//  WIZToolBoxBtn.h
//  customElementh
//
//  Created by a.vorozhishchev on 02/05/2019.
//  Copyright © 2019 a.vorozhishchev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WIZToolBoxBtnTap)(void);
@interface WIZToolBoxBtn : UIView

@property (nonatomic) WIZToolBoxBtnTap tapBlock;
@property (nonatomic) NSString *titleStr;
@property (nonatomic) UIImage *image;

@end

NS_ASSUME_NONNULL_END
