//
//  ViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Bar.h"
#import "DataModel.h"
#import "City.h"

@interface ViewController : UIViewController <RKObjectLoaderDelegate, CLLocationManagerDelegate>
{
    DataModel *dataModel;
    CLLocationManager *locationManager;
    UILabel *cityname;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UILabel *cityname;

- (void)showLoginView;
- (void)getAuthenticationTokenWithUid:(id)uid AndName:(NSString*)name AndEmail:(NSString*)email;
- (void)displayBarsForCity:(City *) city;

@end
