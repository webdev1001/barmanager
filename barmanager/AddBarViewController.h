//
//  AddBarViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/30/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "LocationManager.h"
#import "DashboardViewController.h"

#import "Bar.h"
#import "City.h"

@interface AddBarViewController : UIViewController <CLLocationManagerDelegate, RKObjectLoaderDelegate, UITextFieldDelegate>
{
    CLLocationManager *manager;
    CLLocation *lastLocation;
    UITextField *barTextField;
    UIBarButtonItem *barButtonItem;
}

@property (nonatomic, retain) CLLocationManager *manager;
@property (nonatomic, retain) CLLocation *lastLocation;
@property (nonatomic, retain) IBOutlet UITextField *barTextField;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButtonItem;

- (void)dismissKeyboard;
- (IBAction)addBar:(id)sender;

@end
