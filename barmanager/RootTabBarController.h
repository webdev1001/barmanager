//
//  RootTabBarController.h
//  barmanager
//
//  Created by Joshua Jansen on 25-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "Bar.h"
#import "DataModel.h"
#import "City.h"

@interface RootTabBarController : UITabBarController <RKObjectLoaderDelegate>
{
    DataModel *dataModel;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (strong, nonatomic) UINavigationController *navController;

- (void)showLoginView;
- (void)getAuthenticationTokenWithUid:(id)uid AndName:(NSString*)name AndEmail:(NSString*)email;

@end
