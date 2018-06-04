//
//  GroupView.m
//  GCDTest-C
//
//  Created by Slava on 6/1/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "GroupView.h"

@implementation GroupView


- (void) createSubviewsInView:(NSArray<UIImage* >*) arrayView {
    
    CGFloat widht = CGRectGetWidth(self.bounds) / arrayView.count ;
    
    for (int i = 0; i < arrayView.count; i++) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * widht,
                                                                  self.bounds.origin.y,
                                                                  widht,
                                                                  self.bounds.size.height)];
        imageView.image = arrayView[i];
        imageView.layer.borderColor = [UIColor brownColor].CGColor;
        imageView.layer.borderWidth = 1;
        [self addSubview:imageView];
        [imageView release];
    }
}



@end
