//
//  Error.h
//  barmanager
//
//  Created by Youri van der Lans on 10/26/12.
//  Copyright (c) 2012 ITflows. All rights reserved.
//

#import "BaseError.h"

@interface Error : BaseError <UIAlertViewDelegate>

- (void)showError;

@end