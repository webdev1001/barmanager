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
}

@property (strong, nonatomic) NSString *auth_token;

+ (id)sharedManager;
- (void)writeSettings;

@end
