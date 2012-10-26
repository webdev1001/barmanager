//
//  BaseCity.h
//  Command: restkit-generate model City id:NSNumber name:NSString population:NSNumber
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Bar.h"

@interface BaseCity : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *population;
@property (nonatomic, retain) NSArray *user_bars;
@property (nonatomic, retain) NSArray *other_bars;

+ (RKObjectMapping *)objectMapping;

@end