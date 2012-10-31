//
//  Bar.m
//  barmanager
//
//  Created by Youri van der Lans on 10/19/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "Bar.h"
#import "City.h"
#import "Feature.h"
#import "Expansion.h"
#import "Enlargement.h"

@implementation Bar

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *mapping = [super objectMapping];
    
    RKObjectMapping* cityMapping = [RKObjectMapping mappingForClass:[City class] ];
    [cityMapping mapAttributes:@"name", nil];
    
    RKObjectMapping* featuresMapping = [Feature objectMapping];
    RKObjectMapping* expansionsMapping = [Expansion objectMapping];
    RKObjectMapping* enlargementsMapping = [Enlargement objectMapping];
    
    [mapping mapKeyPath:@"city" toRelationship:@"city" withMapping:cityMapping];
    
    [mapping mapKeyPath:@"current_features" toRelationship:@"current_features" withMapping:featuresMapping];
    [mapping mapKeyPath:@"available_features" toRelationship:@"available_features" withMapping:featuresMapping];
    
    [mapping mapKeyPath:@"current_expansions" toRelationship:@"current_expansions" withMapping:expansionsMapping];
    [mapping mapKeyPath:@"available_expansions" toRelationship:@"available_expansions" withMapping:expansionsMapping];
    
    [mapping mapKeyPath:@"current_enlargements" toRelationship:@"current_enlargements" withMapping:enlargementsMapping];
    [mapping mapKeyPath:@"available_enlargements" toRelationship:@"available_enlargements" withMapping:enlargementsMapping];
    
    return mapping;
}

@end
