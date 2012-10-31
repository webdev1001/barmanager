//
//  ViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "DataModel.h"
#import "Bar.h"
#import "City.h"

#import "AddBarViewController.h"

@interface DashboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    DataModel *dataModel;
    
    UILabel *cityname;
    IBOutlet UIButton *addBarButton;
    IBOutlet UIButton *userBarButton;
    IBOutlet UITableView *otherBarsTableView;
    NSArray *otherBars;
}

@property (nonatomic, retain) DataModel *dataModel;

@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UILabel *cityname;
@property (strong, nonatomic) IBOutlet UIButton *addBarButton;
@property (strong, nonatomic) IBOutlet UIButton *userBarButton;
@property (strong, nonatomic) IBOutlet UITableView *otherBarsTableView;

- (void)displayBarsForCity:(City *) city;

@end
