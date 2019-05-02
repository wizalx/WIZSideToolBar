//
//  WIZToolBoxBtn.m
//  customElementh
//
//  Created by a.vorozhishchev on 02/05/2019.
//  Copyright © 2019 a.vorozhishchev. All rights reserved.
//

#import "WIZToolBoxBtn.h"

@interface WIZToolBoxBtn()
@property (strong, nonatomic) IBOutlet UIView *contentVIew;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation WIZToolBoxBtn

#pragma mark - init

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

-(void)customInit
{
    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"WIZToolBoxBtn" owner:self options:nil];
    
    [self addSubview:self.contentVIew];
    self.contentVIew.backgroundColor = [UIColor clearColor];
    
    self.contentVIew.layer.cornerRadius = 10.0;
    self.contentVIew.clipsToBounds = YES;
    
    self.title.textColor = [UIColor whiteColor];
    
    self.contentVIew.frame = self.bounds;
    
}

#pragma mark - setters

-(void)setTitleStr:(NSString *)titleStr
{
    self.title.text = titleStr;
}

-(void)setImage:(UIImage *)image
{
    self.icon.image = image;
}

#pragma mark - tap on view

//- (IBAction)tapOnView:(id)sender {

//}

- (IBAction)tapDown:(id)sender {
    self.contentVIew.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
}

- (IBAction)tapUp:(id)sender {
    self.contentVIew.backgroundColor = [UIColor clearColor];
    if (_tapBlock)
        _tapBlock();
}

- (IBAction)tapCancel:(id)sender {
    self.contentVIew.backgroundColor = [UIColor clearColor];
}
- (IBAction)tapUpOutside:(id)sender {
    self.contentVIew.backgroundColor = [UIColor clearColor];
}

@end
