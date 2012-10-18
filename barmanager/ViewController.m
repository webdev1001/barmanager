//
//  ViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize navController = _navController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoginView
{
    UIViewController *topViewController = [self.navController topViewController];
    UIViewController *modalViewController = [topViewController presentedViewController];
    
    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![modalViewController isKindOfClass:[LoginViewController class]]) {
        [self.navController performSegueWithIdentifier:@"Show Login" sender:nil];
    } else {
        LoginViewController* loginViewController = (LoginViewController*)modalViewController;
        [loginViewController loginFailed];
    }
}

@end
