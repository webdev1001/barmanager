//
//  locationManager.h
//  barmanager
//
//  Created by Joshua Jansen on 25-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <RestKit/RestKit.h>

#import "DataModel.h"
#import "City.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate, RKObjectLoaderDelegate>
{
    CLLocationManager *manager;
    CLLocation *lastLocation;
    DataModel *dataModel;
}

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, retain) DataModel *dataModel;

extern NSString *const BMLocationChange;
extern NSString *const BMCityChange;

+ (id)sharedManager;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end
