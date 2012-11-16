//
//  User.m
//  barmanager
//
//  Created by Youri van der Lans on 10/19/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "User.h"

@implementation User

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping *mapping = [super objectMapping];
    
    RKObjectMapping* bankTransactionMapping = [RKObjectMapping mappingForClass:[BankTransaction class] ];
    [bankTransactionMapping mapAttributes:@"description", @"amount", nil];
    
    [mapping mapKeyPath:@"bank_transactions" toRelationship:@"bank_transactions" withMapping:bankTransactionMapping];
    
    return mapping;
}

@end
