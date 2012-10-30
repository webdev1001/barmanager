//
//  City.m
//  barmanager
//
//  Created by Joshua Jansen on 24-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "City.h"

@implementation City

+ (void)findCityForLocation:(CLLocation *)location WithDelegate:(id<RKObjectLoaderDelegate>)delegate
{
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", location.coordinate.latitude],@"latitude", [NSString stringWithFormat:@"%f", location.coordinate.longitude],@"longitude", nil];
    NSString *resourcePath = [@"/cities.json" stringByAppendingQueryParameters:queryParams];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath delegate:delegate];
}

@end
