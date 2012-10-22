//
//  ViewController.m
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>
#import <RestKit/RKJSONParserJSONKit.h>

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
    NSDictionary *queryParams = [NSDictionary dictionaryWithObject:dataModel.auth_token forKey:@"auth_token"];
    NSString *resourcePath = [@"/bars" stringByAppendingQueryParameters:queryParams];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath delegate:self];
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
    Bar *bar = [objects objectAtIndex:0];
    NSLog(@"Loaded Bar ID #%@ -> Name: %@, Capacity: %@", bar.barId, bar.name, bar.capacity);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    if( [response isOK] )
    {
        if( [request wasSentToResourcePath:@"/request_token.json"] )
        {
            NSString* parsedResponse = [response bodyAsString];
            NSLog(@"ParsedResponse: %@", parsedResponse);
        }
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        NSLog(@"Logged in!");
        
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (!error) {
                 NSString *userInfo = @"";
                 // Example: typed access (name)
                 // - no special permissions required
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Name: %@\n\n",
                              user.name]];
                 
                 // Example: access via key (locale)
                 // - no special permissions required
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"Email: %@\n\n",
                              [user objectForKey:@"email"]]];
                 
                 
                 // Display the user info
                 NSLog(@"%@", userInfo);
                 [self getAuthenticationTokenWithUid:user.id AndName:user.name AndEmail:[user objectForKey:@"email"]];
             }
         }];
    } else {
        NSLog(@"Logged out!");
    }
}

- (void)getAuthenticationTokenWithUid:(id)uid AndName:(NSString*)name AndEmail:(NSString*)email
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    [params setValue:uid forKey:@"uid"];
    [params setValue:name forKey:@"name"];
    [params setValue:email forKey:@"email"];

    [[RKClient sharedClient] post:@"/request_token.json" params:params delegate:self];
}

@end
