//
//  BaseBar.h
//  Command: restkit-generate model Bar id:NSNumber name:NSString capacity:NSNumber
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseBar : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *barId;
@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *capacity;
@property (nonatomic, strong) NSNumber *popularity;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

+ (RKObjectMapping *)objectMapping;

@end