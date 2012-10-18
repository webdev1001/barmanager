//
//  ViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XMLRPC/XMLRPC.h>

@interface ViewController : UIViewController <XMLRPCConnectionDelegate>

@property (strong, nonatomic) UINavigationController *navController;

- (void)showLoginView;

@end
