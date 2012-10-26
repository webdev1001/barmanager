//
//  locationManager.m
//  barmanager
//
//  Created by Joshua Jansen on 25-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "LocationManager.h"

static LocationManager *sharedLocationManager = nil;

@implementation LocationManager

@synthesize lastLocation, dataModel;

+ (id)sharedLocationManager
{
    @synchronized(self) {
        if(sharedLocationManager == nil)
            sharedLocationManager = [[super allocWithZone:NULL] init];
    }
    
    return sharedLocationManager;
}

- (id)init
{
    if (self = [super init])
    {
        self.dataModel = [DataModel sharedManager];
        
        manager = [[CLLocationManager alloc] init];
        manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        manager.delegate = self;
        manager.distanceFilter = 100.0f;
        
        [manager startUpdatingLocation];
        NSLog(@"locationManager initialized");
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    lastLocation = [locations lastObject];
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", lastLocation.coordinate.latitude],@"latitude",[NSString stringWithFormat:@"%f", lastLocation.coordinate.longitude],@"longitude", nil];
    NSString *resourcePath = [@"/cities.json" stringByAppendingQueryParameters:queryParams];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    
    NSArray * resource_path_array = [[objectLoader resourcePath] componentsSeparatedByString:@"?"];
    objectLoader.resourcePath = [resource_path_array objectAtIndex:0];
    
    if ([objectLoader wasSentToResourcePath:@"/cities.json"]) {
        City *city = [objects objectAtIndex:0];
        self.dataModel.city_id = city.cityId;
        self.dataModel.city_name = city.name;
        NSLog(@"Loaded City ID #%@ -> Name: %@, Population: %@", city.cityId, city.name, city.population);
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}

@end
