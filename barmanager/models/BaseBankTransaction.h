//
//  BaseBankTransactions.h
//  Command: /Users/joshuajansen/.rvm/gems/ruby-1.9.3-p194@global/bin/restkit-generate model BankTransactions id:NSNumber user_id:NSNumber bar_id:NSNumber description:NSString amount:NSNumber
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BaseBankTransaction : NSObject <NSCoding>

@property (nonatomic, strong) NSNumber *banktransactionId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *barId;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSNumber *amount;

+ (RKObjectMapping *)objectMapping;

@end