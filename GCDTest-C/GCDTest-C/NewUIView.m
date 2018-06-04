//
//  NewUIView.m
//  GCDTest-C
//
//  Created by Slava on 5/31/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "NewUIView.h"

@implementation NewUIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect frameImageView = CGRectMake(10,
                                           10,
                                           CGRectGetHeight(self.bounds) + 20,
                                           CGRectGetHeight(self.bounds) -20);
        _imageView = [[UIImageView alloc] initWithFrame:frameImageView];
        _imageView.layer.borderColor = [UIColor brownColor].CGColor;
        _imageView.layer.borderWidth = 1;
        [self addSubview:_imageView];
        [_imageView release];
    }
    return self;
}



@end
