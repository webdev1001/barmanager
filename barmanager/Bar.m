//
//  Bar.m
//  barmanager
//
//  Created by Youri van der Lans on 10/19/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "Bar.h"
#import "City.h"

@implementation Bar

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *mapping = [super objectMapping];
    RKObjectMapping* cityMapping = [RKObjectMapping mappingForClass:[City class] ];
    [cityMapping mapAttributes:@"name", nil];
    
    [mapping mapKeyPath:@"city" toRelationship:@"city" withMapping:cityMapping];
    
    return mapping;
}

@end
