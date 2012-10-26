//
//  BaseError.h
//  Command: restkit-generate model Error message:NSString
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseError : NSObject <NSCoding>

@property (nonatomic, copy) NSString *message;

+ (RKObjectMapping *)objectMapping;

@end