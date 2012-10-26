//
//  RootTabBarController.m
//  barmanager
//
//  Created by Joshua Jansen on 25-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>

#import "RootTabBarController.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

@synthesize navController = _navController, dataModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.dataModel = [DataModel sharedManager];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(logoutButtonWasPressed:)];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ( [item tag] == 0 ) {
        NSLog(@"item tag is 0");
        //DashboardViewController *dashboardViewController = [DashboardViewController alloc];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSArray * resource_path_array = [[objectLoader resourcePath] componentsSeparatedByString:@"?"];
    objectLoader.resourcePath = [resource_path_array objectAtIndex:0];
    
    // After requesting token, set auth token to datamodel singleton
    if ([objectLoader wasSentToResourcePath:@"/users/request_token.json"]) {
        User *user = [objects objectAtIndex:0];
        
        NSLog(@"Loaded user: %@", user.name);
        
        self.dataModel.auth_token = user.authenticationToken;
        
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate setAuthTokenWithinHTTPHeaders];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Encountered an error: %@", error);
}

- (void)sessionStateChanged:(NSNotification*)notification
{
    if (FBSession.activeSession.isOpen) {
        NSLog(@"Logged in!");
        
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (!error) {
                 [self getAuthenticationTokenWithUid:user.id AndName:user.name AndEmail:[user objectForKey:@"email"]];
             }
         }];
    } else {
        NSLog(@"Logged out!");
    }
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

-(void)logoutButtonWasPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAuthenticationTokenWithUid:(id)uid AndName:(NSString*)name AndEmail:(NSString*)email
{
    RKObjectMapping* userSerializationMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [userSerializationMapping mapAttributes:@"name", @"email", @"uid", nil];
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:userSerializationMapping forClass:[User class]];
    
    User* user = [User new];
    user.name = name;
    user.email = email;
    user.uid = uid;
    
    // POST to /request_token
    [[RKObjectManager sharedManager] postObject:user delegate:self];
}

@end
