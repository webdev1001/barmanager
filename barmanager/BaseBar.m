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
    @"name", @"name",
    @"capacity", @"capacity",
    nil];
    
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.barId = [coder decodeObjectForKey:@"barId"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.capacity = [coder decodeObjectForKey:@"capacity"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.barId forKey:@"barId"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.capacity forKey:@"capacity"];
}

@end