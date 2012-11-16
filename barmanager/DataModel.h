//
//  DataModel.h
//  barmanager
//
//  Created by Joshua Jansen on 22-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
    NSString *auth_token;
    NSNumber *user_id;
    NSNumber *city_id;
    NSString *city_name;
}

@property (strong, nonatomic) NSString *auth_token;
@property (strong, nonatomic) NSNumber *user_id;
@property (strong, nonatomic) NSNumber *city_id;
@property (strong, nonatomic) NSString *city_name;

+ (id)sharedManager;
- (void)writeSettings;
- (void)resetValues;

@end
