//
//  ViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "Bar.h"

@interface ViewController : UIViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic) UINavigationController *navController;

- (IBAction)loadBars:(id)sender;

- (void)showLoginView;

@end
