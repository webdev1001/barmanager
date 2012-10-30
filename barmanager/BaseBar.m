//
//  BaseBar.m
//

#import "BaseBar.h"

@implementation BaseBar

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:
    @"id", @"barId",
    @"city_id", @"cityId",
    @"name", @"name",
    @"capacity", @"capacity",
    @"latitude", @"latitude",
    @"longitude", @"longitude",
    nil];
    
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.barId = [coder decodeObjectForKey:@"barId"];
        self.cityId = [coder decodeObjectForKey:@"cityId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.capacity = [coder decodeObjectForKey:@"capacity"];
        self.latitude = [coder decodeObjectForKey:@"latitude"];
        self.longitude = [coder decodeObjectForKey:@"longitude"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.barId forKey:@"barId"];
    [coder encodeObject:self.cityId forKey:@"cityId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.capacity forKey:@"capacity"];
    [coder encodeObject:self.capacity forKey:@"latitude"];
    [coder encodeObject:self.capacity forKey:@"longitude"];
}

@end