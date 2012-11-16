//
//  BaseUser.m
//

#import "BaseUser.h"

@implementation BaseUser

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:
    @"id", @"userId",
    @"email", @"email",
    @"name", @"name",
    @"authentication_token", @"authenticationToken",
    @"uid", @"uid",
    @"balance", @"balance",
    nil];
    
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.userId = [coder decodeObjectForKey:@"userId"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.authenticationToken = [coder decodeObjectForKey:@"authenticationToken"];
        self.uid = [coder decodeObjectForKey:@"uid"];
        self.balance = [coder decodeObjectForKey:@"balance"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.email forKey:@"email"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.authenticationToken forKey:@"authenticationToken"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.balance forKey:@"balance"];
}

@end