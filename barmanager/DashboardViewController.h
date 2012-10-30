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

#import "DataModel.h"
#import "Bar.h"
#import "City.h"

@interface DashboardViewController : UIViewController <CLLocationManagerDelegate, RKObjectLoaderDelegate>
{
    CLLocationManager *manager;
    DataModel *dataModel;
    
    UILabel *cityname;
    IBOutlet UIButton *addBarButton;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (nonatomic, retain) CLLocationManager *manager;

@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UILabel *cityname;
@property (strong, nonatomic) IBOutlet UIButton *addBarButton;

- (void)displayBarsForCity:(City *) city;
- (IBAction)addBarForCityButton:(id)sender;

@end
