//
//  BankViewController.h
//  barmanager
//
//  Created by Joshua Jansen on 26-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DataModel.h"
#import "User.h"

@interface BankViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
    DataModel *dataModel;
    double balance;
    int transaction_count;
    NSArray *bank_transactions;
    IBOutlet UITableView *bankTransactionsTableView;
    IBOutlet UILabel *balanceLabel;
}

@property (nonatomic, retain) DataModel *dataModel;
@property (strong, nonatomic) IBOutlet UITableView *bankTransactionsTableView;
@property (nonatomic, retain) IBOutlet UILabel *balanceLabel;

@end
