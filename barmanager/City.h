//
//  City.h
//  barmanager
//
//  Created by Joshua Jansen on 24-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BaseCity.h"
#import <CoreLocation/CoreLocation.h>

@interface City : BaseCity

+ (void)findCityForLocation:(CLLocation *)location WithDelegate:(id<RKObjectLoaderDelegate>)delegate;

@end
