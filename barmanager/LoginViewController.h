//
//  LoginViewController.h
//  barmanager
//
//  Created by Youri van der Lans on 10/16/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController
{
    UIButton *button;
}

@property (nonatomic, retain) IBOutlet UIButton *button;

- (void)loginFailed;

@end
