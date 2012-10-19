//
//  BaseBar.h
//  Command: restkit-generate model Bar id:NSNumber name:NSString capacity:NSNumber
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseBar : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *barId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *capacity;

+ (RKObjectMapping *)objectMapping;

@end