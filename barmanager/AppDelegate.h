//
//  AppDelegate.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RootTabBarController.h"
#import "LocationManager.h"

#import <RestKit/RestKit.h>

#import "DataModel.h"

#import "Bar.h"
#import "User.h"
#import "City.h"
#import "Error.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    DataModel *dataModel;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) RootTabBarController *mainController;
@property (retain, nonatomic) DataModel *dataModel;

extern NSString *const FBSessionStateChangedNotification;

- (void)openSession;
- (void)setAuthTokenWithinHTTPHeaders;

@end
