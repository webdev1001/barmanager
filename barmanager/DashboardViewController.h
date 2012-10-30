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

@interface DashboardViewController : UIViewController
{
    DataModel *dataModel;
    
    UILabel *cityname;
    IBOutlet UIButton *addBarButton;
}

@property (nonatomic, retain) DataModel *dataModel;

@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, retain) IBOutlet UILabel *cityname;
@property (strong, nonatomic) IBOutlet UIButton *addBarButton;

- (void)displayBarsForCity:(City *) city;

@end
