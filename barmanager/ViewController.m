//
//  ViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize navController = _navController, dataModel;

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

- (IBAction)loadBars:(id)sender
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/bars" delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    if ([objectLoader wasSentToResourcePath:@"/request_token.json"]) {
        User *user = [objects objectAtIndex:0];
        
        NSLog(@"Loaded user: %@", user.name);
        
        self.dataModel.auth_token = user.authenticationToken;
        
        NSLog(@"%@", user.authenticationToken);
        
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate setAuthTokenWithinHTTPHeaders];
    } else if ([objectLoader wasSentToResourcePath:@"/bars"]) {
        Bar *bar = [objects objectAtIndex:0];
        NSLog(@"Loaded Bar ID #%@ -> Name: %@, Capacity: %@", bar.barId, bar.name, bar.capacity);
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

- (void)sessionStateChanged:(NSNotification*)notification {
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
