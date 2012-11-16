//
//  BaseFeature.m
//  barmanager
//
//  Created by Joshua Jansen on 30-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BaseFeature.h"
#import "Feature.h"

@implementation BaseFeature

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Feature class]];
    [mapping mapKeyPathsToAttributes:
     @"id", @"featureId",
     @"name", @"name",
     @"investment", @"investment",
     @"icon", @"icon",
     nil];
    
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.featureId = [coder decodeObjectForKey:@"featureId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.investment = [coder decodeObjectForKey:@"investment"];
        self.icon = [coder decodeObjectForKey:@"icon"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.featureId forKey:@"featureId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.investment forKey:@"investment"];
    [coder encodeObject:self.icon forKey:@"icon"];
}

@end
