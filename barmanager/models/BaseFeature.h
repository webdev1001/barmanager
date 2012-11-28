//
//  BaseFeature.h
//  barmanager
//
//  Created by Joshua Jansen on 30-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseFeature : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *featureId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSNumber *investment;
@property (nonatomic, retain) NSString *icon;

+ (RKObjectMapping *)objectMapping;

@end
