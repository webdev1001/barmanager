//
//  Error.m
//  barmanager
//
//  Created by Youri van der Lans on 10/26/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "Error.h"

@implementation Error

- (void)showError
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:self.message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
