//
//  customTextField.m
//  test
//
//  Created by leolevy on 15/10/4.
//  Copyright (c) 2015年 leolevy. All rights reserved.
//

#import "customTextField.h"
#import "Masonry.h"
@interface customTextField()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView * lineView;

@end
@implementation customTextField
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    self.titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    
  //  [_titleLabel setBackgroundColor:[UIColor purpleColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_titleLabel setText:@"test"];
    [_titleLabel setHidden:YES];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@15);
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.mas_left);
    }];

    
    
    self.textField = [[UITextField alloc]init];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.placeholder = @"test";
    _textField.delegate = self;
    [_textField setFont:[UIFont systemFontOfSize:14]];
    //[_textField setBackgroundColor:[UIColor redColor]];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    self.lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithRed:0.4863 green:0.4863 blue:0.4863 alpha:1.0]];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.mas_bottom);
    }];
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
    _titleLabel.text = placeholder;
}
-(NSString *)getText{
    return  _textField.text;
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
         [self.delegate textFieldDidBeginEditing:textField];
    }
   
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
         [self.delegate textFieldDidEndEditing:textField];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (!textField.text || [textField.text isEqualToString:@""]) {
        [_titleLabel setHidden:NO];
    
        [_titleLabel setTextColor: _highlightedColor ? _highlightedColor : [UIColor colorWithRed:0.2784 green:0.5373 blue:0.5059 alpha:1.0]];
        [_lineView setBackgroundColor: _highlightedColor ? _highlightedColor : [UIColor colorWithRed:0.2784 green:0.5373 blue:0.5059 alpha:1.0]];
    }
    
    if( textField.text.length == 1&& NSEqualRanges(range, NSMakeRange(0, 1))){
        [_titleLabel setHidden:YES];
        [_titleLabel setTextColor:[UIColor colorWithRed:0.4108 green:0.4107 blue:0.4107 alpha:1.0]];
        [_lineView setBackgroundColor:[UIColor colorWithRed:0.4108 green:0.4107 blue:0.4107 alpha:1.0]];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end
