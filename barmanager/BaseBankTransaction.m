//
//  BaseBankTransactions.m
//

#import "BaseBankTransaction.h"

@implementation BaseBankTransaction

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:
    @"id", @"banktransactionId",
    @"user_id", @"userId",
    @"bar_id", @"barId",
    @"description", @"description",
    @"amount", @"amount",
    nil];
    return mapping;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [[[self class] alloc] init];
    if (self) {
        self.banktransactionId = [coder decodeObjectForKey:@"banktransactionId"];
        self.userId = [coder decodeObjectForKey:@"userId"];
        self.barId = [coder decodeObjectForKey:@"barId"];
        self.description = [coder decodeObjectForKey:@"description"];
        self.amount = [coder decodeObjectForKey:@"amount"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.banktransactionId forKey:@"banktransactionId"];
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.barId forKey:@"barId"];
    [coder encodeObject:self.description forKey:@"description"];
    [coder encodeObject:self.amount forKey:@"amount"];
}

@end