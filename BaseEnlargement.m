//
//  BaseEnlargement.m
//  barmanager
//
//  Created by Joshua Jansen on 30-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BaseEnlargement.h"

@implementation BaseEnlargement

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:
     @"id", @"enlargementId",
     @"name", @"name",
     @"icon", @"icon",
     nil];
    
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.enlargementId = [coder decodeObjectForKey:@"enlargementId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.icon = [coder decodeObjectForKey:@"icon"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.enlargementId forKey:@"enlarementId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.icon forKey:@"icon"];
}

@end