//
//  ViewController.m
//  test
//
//  Created by leolevy on 15/10/4.
//  Copyright (c) 2015年 leolevy. All rights reserved.
//

#import "ViewController.h"
#import "customTextField.h"
#import "ComboBox.h"
@interface ViewController ()<customTextFieldDelegate>
@property (strong, nonatomic) IBOutlet ComboBox *boxView;
@property (strong, nonatomic) IBOutlet customTextField *customTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // [_customTextField initSubViews];
    _customTextField.delegate = self;
    _boxView.comboBoxArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
