//
//  DataModel.m
//  barmanager
//
//  Created by Joshua Jansen on 22-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "DataModel.h"

static DataModel *dataModel = nil;

@implementation DataModel

@synthesize user_id, auth_token, city_id, city_name;

#pragma mark Singleton Methods
+ (id)sharedManager
{
    @synchronized(self) {
        if(dataModel == nil)
            dataModel = [[super allocWithZone:NULL] init];
    }
    
    return dataModel;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

- (id)init
{
    if (self = [super init])
    {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
        
        NSLog(@"%@", plistPath);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        }
        
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp)
        {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        NSDictionary *user_settings = [temp objectForKey:@"user_settings"];
        NSDictionary *city_data = [temp objectForKey:@"city_data"];
        
        NSLog(@"%@", plistPath);
        
        auth_token = [user_settings objectForKey:@"auth_token"];
        user_id = [user_settings objectForKey:@"user_id"];
        
        NSLog(@"Loaded auth_token from data.plist: %@", auth_token);
        
        city_id = [city_data objectForKey:@"city_id"];
        city_name = [city_data objectForKey:@"city_name"];
    }
    
    return self;
}

- (void)writeSettings
{
    NSLog(@"try to write data.plist");
        
    NSString *error;

    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"data.plist"];
    
    
    // User settings:
    NSNumber *tmpUserId = user_id;
    NSString *tmpAuthToken = auth_token;
    
    NSArray *userSettingsTemp = [NSArray arrayWithObjects:tmpUserId, tmpAuthToken, nil];
    
    NSDictionary *userSettingsDict = [NSDictionary dictionaryWithObjects: userSettingsTemp forKeys:[NSArray arrayWithObjects: @"user_id", @"auth_token", nil]];
    NSLog(@"User settings built");
    
    // City data:
    NSNumber *tmpCityId = city_id;
    NSString *tmpCityName = city_name;
    
    NSArray *cityDataTemp = [NSArray arrayWithObjects:tmpCityId, tmpCityName, nil];
    
    NSDictionary *cityPlistDict = [NSDictionary dictionaryWithObjects: cityDataTemp forKeys:[NSArray arrayWithObjects: @"city_id", @"city_name", nil]];
    NSLog(@"City data built");    
    
    NSDictionary *rootPlistDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userSettingsDict, cityPlistDict, nil] forKeys:[NSArray arrayWithObjects: @"user_settings", @"city_data", nil]];
    NSData *rootPlistData = [NSPropertyListSerialization dataFromPropertyList:rootPlistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(rootPlistData)
    {
        [rootPlistData writeToFile:plistPath atomically:YES];
        NSLog(@"data.plist written");
    }
    else
    {
        NSLog(@"%@", error);
    }
    
}

@end
