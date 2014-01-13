//
//  IOSSignUpInViewController.m
//  Sign Up In Animation Example
//
//  Created by Brian Fontenot on 1/12/14.
//  Copyright (c) 2014 Brian Fontenot. All rights reserved.
//

#import "IOSSignUpInViewController.h"

@interface IOSSignUpInViewController ()

- (void)toggleMode:(id)sender;
- (void)toggleModeAnimated:(BOOL)animated;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)validateTextFieldsToEnableRightBarButton;

@end

@implementation IOSSignUpInViewController
{
    UIButton *_toggleModeFooterButton;
    BOOL _registrationMode;
}

#pragma mark - NSObject

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    _toggleModeFooterButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 20.0f)];
    [_toggleModeFooterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_toggleModeFooterButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_toggleModeFooterButton addTarget:self action:@selector(toggleMode:) forControlEvents:UIControlEventTouchUpInside];
    _toggleModeFooterButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    self.tableView.tableFooterView = _toggleModeFooterButton;
    
    _registrationMode = NO;
    [self toggleModeAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (UITextField *)usernameField
{
    if (!_usernameField) {
        _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 180.0f, 30.0f)];
        _usernameField.delegate = self;
        _usernameField.placeholder = @"Your Username";
        _usernameField.keyboardType = UIKeyboardTypeEmailAddress;
        _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
        _usernameField.textColor = [UIColor blackColor];
        _usernameField.font = [UIFont systemFontOfSize:18.0f];
        _usernameField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        _usernameField.clearButtonMode = UITextFieldViewModeNever;
        _usernameField.returnKeyType = UIReturnKeyNext;
    }
    
    return _usernameField;
}

- (UITextField *)emailField
{
    if (!_emailField) {
        _emailField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 180.0f, 30.0f)];
        _emailField.delegate = self;
        _emailField.placeholder = @"Your Email Address";
        _emailField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
        _emailField.textColor = [UIColor blackColor];
        _emailField.font = [UIFont systemFontOfSize:18.0f];
        _emailField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        _emailField.clearButtonMode = UITextFieldViewModeNever;
        _emailField.returnKeyType = UIReturnKeyNext;
    }
    
    return _emailField;
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 180.0f, 30.0f)];
        _passwordField.delegate = self;
        _passwordField.placeholder = @"Choose a Password";
        _passwordField.secureTextEntry = YES;
        _passwordField.textColor = [UIColor blackColor];
        _passwordField.font = [UIFont systemFontOfSize:18.0f];
        _passwordField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        _passwordField.clearButtonMode = UITextFieldViewModeNever;
        _passwordField.returnKeyType = UIReturnKeyGo;
    }
    
    return _passwordField;
}

#pragma mark - Actions

- (void)registrationAction:(id)sender
{
    // TODO:
    NSLog(@"Registration fired");
}

- (void)loginAction:(id)sender
{
    // TODO:
    NSLog(@"Login fired");
}

#pragma mark - Private methods

- (void)toggleMode:(id)sender
{
    [self toggleModeAnimated:YES];
}

- (void)toggleModeAnimated:(BOOL)animated
{
    NSArray *username = @[[NSIndexPath indexPathForRow:1 inSection:0]];
    
    BOOL focusPassword = [self.emailField isFirstResponder];
    
    UITableViewRowAnimation animation = animated ? UITableViewRowAnimationTop : UITableViewRowAnimationNone;
    
    // toggle animation into login fields
    if (_registrationMode) {
        _registrationMode = NO;
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:username withRowAnimation:animation];
        [self.tableView endUpdates];
        
        [_toggleModeFooterButton setTitle:@"Not Registered yet? Sign up here" forState:UIControlStateNormal];
        
        self.usernameField.placeholder = @"Your Username or Email";
        self.passwordField.placeholder = @"Your Password";
        
        if (focusPassword) {
            [self.passwordField becomeFirstResponder];
        }
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStyleBordered target:self action:@selector(loginAction:)];
        
    // toggle animation into registration fields
    } else {
        _registrationMode = YES;
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:username withRowAnimation:animation];
        [self.tableView endUpdates];
        
        [_toggleModeFooterButton setTitle:@"Already have an account? Login" forState:UIControlStateNormal];
        
        self.usernameField.placeholder = @"Choose your username";
        self.passwordField.placeholder = @"Choose a password";
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStyleBordered target:self action:@selector(registrationAction:)];
    }
    
    // Right bar button is disabled when fields are blank
    [self validateTextFieldsToEnableRightBarButton];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Username";
        cell.accessoryView = self.usernameField;
        return;
    }
    
    if (_registrationMode) {
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Email";
            cell.accessoryView = self.emailField;
            return;
        }
        
    }
    
    cell.textLabel.text = @"Password";
    cell.accessoryView = self.passwordField;
}

- (void)validateTextFieldsToEnableRightBarButton
{
    BOOL valid = self.usernameField.text.length >= 1 && self.passwordField.text.length >=1;
    
    if (_registrationMode && valid) {
        valid = self.emailField.text.length >=1;
    }
    
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _registrationMode ? 3 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField) {
        if (_registrationMode) {
            [self.emailField becomeFirstResponder];
        } else {
            [self.passwordField becomeFirstResponder];
        }
    }
    else if (textField == self.emailField) {
        [self.passwordField becomeFirstResponder];
    }
    else if (textField == self.passwordField) {
        if (_registrationMode) {
            [self registrationAction:textField];
        } else {
            [self loginAction:textField];
        }
    }
    
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self validateTextFieldsToEnableRightBarButton];
        NSLog(@"validating text field");
    });
    
    return YES;
}

@end
