//
//  ComboBox.h
//  test
//
//  Created by leolevy on 15/10/5.
//  Copyright (c) 2015年 leolevy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComboBox : UIView
@property (nonatomic, strong) NSArray *comboBoxArray;
@property (nonatomic, getter=getComboBoxResults) NSString *text;
@property (nonatomic,copy)   NSString *placeholder;
@end
