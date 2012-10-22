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

@synthesize auth_token;

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
        
        NSLog(@"%@", plistPath);
        
        auth_token = [user_settings objectForKey:@"auth_token"];
        
        NSLog(@"Auth token:%@", auth_token);
    }
    
    return self;
}

@end
