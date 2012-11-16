//
//  City.m
//  barmanager
//
//  Created by Joshua Jansen on 24-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "City.h"

@implementation City

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *mapping = [super objectMapping];
    
    RKObjectMapping *barMapping = [RKObjectMapping mappingForClass:[Bar class]];
    [barMapping mapKeyPathsToAttributes:
     @"id", @"barId",
     @"city_id", @"cityId",
     @"name", @"name",
     @"capacity", @"capacity",
     @"latitude", @"latitude",
     @"longitude", @"longitude",
     nil];
    
    [mapping mapKeyPath:@"user_bars" toRelationship:@"user_bars" withMapping:barMapping];
    [mapping mapKeyPath:@"other_bars" toRelationship:@"other_bars" withMapping:barMapping];
    
    return mapping;
}

+ (void)findCityForLocation:(CLLocation *)location WithDelegate:(id<RKObjectLoaderDelegate>)delegate
{
    NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", location.coordinate.latitude],@"latitude", [NSString stringWithFormat:@"%f", location.coordinate.longitude],@"longitude", nil];
    NSString *resourcePath = [@"/api/cities.json" stringByAppendingQueryParameters:queryParams];
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath delegate:delegate];
}

@end
