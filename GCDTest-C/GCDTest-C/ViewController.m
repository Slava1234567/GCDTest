//
//  ViewController.m
//  GCDTest-C
//
//  Created by Slava on 5/31/18.
//  Copyright © 2018 Slava. All rights reserved.
//

#import "ViewController.h"
#import "NewUIView.h"
#import "GroupView.h"

@interface ViewController ()

@property (copy, nonatomic) NSMutableArray* arrayString;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger offSetY;
@property (strong, nonatomic) NSMutableArray* arrayViews;
@end



@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 0;
    self.offSetY = CGRectGetWidth(self.view.frame) / 4;
    self.arrayViews = [NSMutableArray array];
    
    NSString* firstImageName = @"https://static3.depositphotos.com/thumbs/1007080/image/229/2298750/api_thumb_450.jpg";
    NSString* secondImageName = @"https://st.depositphotos.com/thumbs/1002489/image/1991/19915825/api_thumb_450.jpg";
    NSString* threesImageName = @"https://static3.depositphotos.com/thumbs/1002874/image/152/1526802/api_thumb_450.jpg";
    NSString* foursImageName = @"https://static8.depositphotos.com/thumbs/1317509/image/900/9000334/api_thumb_450.jpg";
    
    self.arrayString = [NSMutableArray arrayWithObjects:firstImageName,secondImageName,threesImageName,foursImageName, nil];
    
    UIButton* butonReset = [[self newButtonReset] retain];
    
    [self.view addSubview:butonReset];
    
    //add Task
    for (int i = 0; i < self.arrayString.count; ++i) {
        [self fetchImage:i];
    }
    [self fetchImageGroup];
    
    [butonReset release];
    
}

- (UIButton*)newButtonReset {
    CGRect frame = CGRectMake(CGRectGetMidX(self.view.bounds) -100,
                              CGRectGetMaxY(self.view.bounds) -100,
                              200, 50);
    UIButton *button = [[[UIButton alloc] initWithFrame:frame] autorelease];;
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Reset" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

- (void)clickButton: (UIButton*) sender {
    
    for (UIView *view in self.arrayViews) {
        [view removeFromSuperview];
    }
    
    [self.arrayViews removeAllObjects];
    self.count = 0;
  
        for (int i = 0; i < self.arrayString.count; ++i) {
            [self fetchImage:i];
        }
        [self fetchImageGroup];
}

- (NewUIView *)allocNewView {

        CGRect frame = CGRectMake(CGRectGetMinX(self.view.frame),
                                  self.offSetY * self.count + 65 ,
                                  CGRectGetWidth(self.view.frame),
                                  self.offSetY);
        NewUIView* newView = [[[NewUIView alloc] initWithFrame:frame] autorelease];
    newView.layer.borderWidth = 1;
    newView.layer.borderColor = [UIColor brownColor].CGColor;
    
    return newView;
}

- (void)fetchImageGroup {
    
    NSMutableArray* arrayImages = [NSMutableArray array];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t dispatcImageGroup = dispatch_group_create();
    
        
    dispatch_group_async(dispatcImageGroup, queue, ^{
        for (NSString* string in self.arrayString) {
            NSURL* url = [NSURL URLWithString:string];
            if (url) {
                NSData* data = [NSData dataWithContentsOfURL:url];
                if (data != nil) {
                    UIImage* image = [UIImage imageWithData:data];
                    [arrayImages addObject:image];
                }
            }
        }
    });
    
    dispatch_group_notify(dispatcImageGroup, dispatch_get_main_queue(), ^{

        CGRect frame =  CGRectMake(CGRectGetMinX(self.view.frame),
                                   self.offSetY * self.count + 65,
                                   CGRectGetWidth(self.view.frame),
                                   self.offSetY);
        GroupView* grupView = [[GroupView alloc] initWithFrame:frame];

        [grupView createSubviewsInView:arrayImages];
        [self.view addSubview:grupView];
        self.count += 1;
        [self.arrayViews addObject:grupView];
        [grupView release];
    });
}


- (void) fetchImage:(NSInteger)count {
    
        NSURL *urlOne = [NSURL URLWithString: self.arrayString[count]];
        if (urlOne) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:urlOne];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data != nil){
                       
                        UIImage *image = [UIImage imageWithData:data];
                        NewUIView* newView = [[self allocNewView] retain];
                        newView.imageView.image = image;
                        [self.arrayViews addObject:newView];
                        [self.view addSubview:newView];
                        self.count += 1;
                        
                        [newView release];
                    }
                });
            });
        }
}

- (void)dealloc {
    
    [_arrayString release];
    [_arrayViews release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
