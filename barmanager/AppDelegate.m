//
//  AppDelegate.m
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "AppDelegate.h"
#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>
#import <RestKit/RKErrorMessage.h>

@implementation AppDelegate

@synthesize dataModel;

NSString *const FBSessionStateChangedNotification = @"ITflows.barmanager.Login:FBSessionStateChangedNotification";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.dataModel = [DataModel sharedManager];
    
    self.navController = (UINavigationController *)self.window.rootViewController;
    self.mainController = (RootTabBarController *)self.navController.topViewController;
    self.mainController.navController = self.navController;
    
    [self setRestKitMappingAndRoutes];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.dataModel writeSettings];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to SSO
    // (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
    [self setAuthTokenWithinHTTPHeaders];
    
    [LocationManager sharedManager];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [FBSession.activeSession close];
}

- (void)setRestKitMappingAndRoutes
{
    RKObjectManager *manager = [RKObjectManager objectManagerWithBaseURL:[NSURL URLWithString:API_URL]];
    RKObjectRouter *router = manager.router;
    
    manager.acceptMIMEType = RKMIMETypeJSON;
    manager.serializationMIMEType = RKMIMETypeJSON;
    
    [router routeClass:[Bar class] toResourcePathPattern:@"/api/bars/:barId\\.json"];
    [router routeClass:[Bar class] toResourcePath:@"/api/bars.json" forMethod:RKRequestMethodPOST];
    [router routeClass:[City class] toResourcePath:@"/api/cities.json"];
    [router routeClass:[User class] toResourcePathPattern:@"/api/users/:userId\\.json"];
    [router routeClass:[User class] toResourcePath:@"/api/users/request_token.json" forMethod:RKRequestMethodPOST];
    
    RKObjectMapping *barMapping = [Bar objectMapping];
    RKObjectMapping *userMapping = [User objectMapping];
    
    [manager.mappingProvider setMapping:barMapping forKeyPath:@"bar"];
    [manager.mappingProvider setMapping:userMapping forKeyPath:@"user"];
    [manager.mappingProvider setMapping:[City objectMapping] forKeyPath:@"city"];
    [manager.mappingProvider setMapping:[Expansion objectMapping] forKeyPath:@"expansions"];
    [manager.mappingProvider setMapping:[Feature objectMapping] forKeyPath:@"features"];
    [manager.mappingProvider setMapping:[Enlargement objectMapping] forKeyPath:@"enlargements"];
    
    RKObjectMapping *barSerializationMapping = [barMapping inverseMapping];
    RKObjectMapping *userSerializationMapping = [userMapping inverseMapping];
    
    [barSerializationMapping removeMappingForKeyPath:@"barId"];
    [userSerializationMapping removeMappingForKeyPath:@"userId"];
    
    [manager.mappingProvider setSerializationMapping:barSerializationMapping forClass:[Bar class]];
    [manager.mappingProvider setSerializationMapping:userSerializationMapping forClass:[User class]];
    
    [[manager.mappingProvider errorMapping] setRootKeyPath:@"error"];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            UIViewController *topViewController = [self.navController topViewController];
            if ([[topViewController presentedViewController]
                 isKindOfClass:[LoginViewController class]]) {
                [topViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self.mainController showLoginView];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)setAuthTokenWithinHTTPHeaders {
    if ( [self.dataModel.auth_token length] != 0 ) {
        [[[RKObjectManager sharedManager] client] setValue:self.dataModel.auth_token forHTTPHeaderField:@"X-BARMANAGER-AUTH-TOKEN"];
        NSLog(@"Set %@ to http headers", self.dataModel.auth_token);
    }
}

@end
