//
//  IOSSignUpInViewController.h
//  Sign Up In Animation Example
//
//  Created by Brian Fontenot on 1/12/14.
//  Copyright (c) 2014 Brian Fontenot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOSSignUpInViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *passwordField;

- (void)registrationAction:(id)sender;
- (void)loginAction:(id)sender;

@end
