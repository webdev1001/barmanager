//
//  BaseCity.m
//

#import "BaseCity.h"

@implementation BaseCity

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:
    @"id", @"cityId",
    @"name", @"name",
    @"population", @"population",
    nil];
    
    RKObjectMapping* barMapping = [RKObjectMapping mappingForClass:[Bar class] ];
    [barMapping mapAttributes:@"name", @"capacity", nil];
    
    [mapping mapKeyPath:@"user_bars" toRelationship:@"user_bars" withMapping:barMapping];
    [mapping mapKeyPath:@"other_bars" toRelationship:@"other_bars" withMapping:barMapping];
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.cityId = [coder decodeObjectForKey:@"cityId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.population = [coder decodeObjectForKey:@"population"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.cityId forKey:@"cityId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.population forKey:@"population"];
}

@end