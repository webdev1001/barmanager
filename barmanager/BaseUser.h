//
//  BaseUser.h
//  Command: restkit-generate model User id:NSNumber email:NSString name:NSString authentication_token:NSString
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseUser : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *authenticationToken;
@property (nonatomic, strong) NSNumber *uid;

+ (RKObjectMapping *)objectMapping;

@end