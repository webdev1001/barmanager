//
//  BankViewController.m
//  barmanager
//
//  Created by Joshua Jansen on 26-10-12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BankViewController.h"

@interface BankViewController ()
    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation BankViewController

@synthesize dataModel, bankTransactionsTableView, balanceLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    balance = 0.00;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBank];
}

- (void)loadBank
{
    User *user = [User new];
    user.userId = self.dataModel.user_id;
    
    [[RKObjectManager sharedManager] getObject:user delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSArray * resource_path_array = [[objectLoader resourcePath] componentsSeparatedByString:@"?"];
    objectLoader.resourcePath = [resource_path_array objectAtIndex:0];
    
    if ([[objectLoader.URL path] isEqualToString:[NSString stringWithFormat:@"/api/users/%@.json", self.dataModel.user_id]]) {
        User *user = [objects objectAtIndex:0];
        NSLog(@"Loaded User ID #%@ -> Name: %@, Balance: %@", user.userId, user.name, user.balance);
        
        balance = [user.balance doubleValue];
        balanceLabel.text = [ NSString stringWithFormat:@"%.2f", balance];
        transaction_count = [ user.bank_transactions count ];
        bank_transactions = user.bank_transactions;
        

        [self.bankTransactionsTableView reloadData];
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fout"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return transaction_count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIFont *textFont = [ UIFont fontWithName: @"Arial" size: 10.0 ];
    cell.textLabel.font  = textFont;
    cell.detailTextLabel.font = textFont;
    
    BankTransaction *transaction = [bank_transactions objectAtIndex:[indexPath row]];
    cell.textLabel.text = transaction.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"€ %.2f", [transaction.amount doubleValue]];
}

@end
