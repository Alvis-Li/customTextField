//
//  ComboBox.m
//  test
//
//  Created by leolevy on 15/10/5.
//  Copyright (c) 2015年 leolevy. All rights reserved.
//

#import "ComboBox.h"
#import "Masonry.h"
@interface ComboBox()<UITableViewDelegate,UITableViewDataSource>
{
    CGPoint originalPoint;
    CGRect originalRect;
    CGSize originalSize;
    UITableView *locaTableView;
    UITapGestureRecognizer *tapGestureRecognizer;
    UIImageView *imageView;
}
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) NSMutableArray *comboBoxCellArray;
@property (nonatomic, assign) BOOL showDetails;

@end
@implementation ComboBox

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

-(void)setComboBoxArray:(NSArray *)comboBoxArray{

    _comboBoxArray = comboBoxArray;
    if (!locaTableView) {
        locaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, originalSize.height, originalSize.width, 0) style:UITableViewStylePlain];
        locaTableView.dataSource = self;
        locaTableView.delegate = self;
        [locaTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self addSubview:locaTableView];
    }

    
}
-(NSString *)getComboBoxResults{
    return _contentLabel.text;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _contentLabel.text = placeholder;
}

-(void)initSubViews{
    
    self.comboBoxCellArray = [NSMutableArray array];
    self.showDetails = NO;
    originalPoint = self.frame.origin;
    originalRect = self.frame;
    originalSize = self.frame.size;
    
    imageView = [UIImageView new];
    [imageView setImage:[UIImage imageNamed:@"triangle"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@15);
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    self.contentLabel = [UILabel new];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(imageView.mas_left);
    }];
    [_contentLabel setText:@"test"];
    [_contentLabel setFont:[UIFont systemFontOfSize:13]];
    
    UIView *bottom = [UIView new];
    [self insertSubview:bottom atIndex:0];
    [bottom setUserInteractionEnabled:YES];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comboBoxClick:)];
    [bottom addGestureRecognizer:tapGestureRecognizer];
}

-(void)comboBoxClick:(UITapGestureRecognizer *)tap{

    originalPoint = self.frame.origin;
    
    if (_comboBoxArray.count >0) {
        if (_showDetails) {
            _showDetails = NO;
            
            [UIView animateWithDuration:0.2 animations:^{
                imageView.transform = CGAffineTransformMakeRotation(0*M_PI/180);
                self.frame = CGRectMake(originalPoint.x, originalPoint.y, originalSize.width, originalSize.height);
                locaTableView.frame = CGRectMake(0, originalSize.height, originalSize.width, 0);
            } completion:^(BOOL finished) {
                [_comboBoxCellArray removeAllObjects];
                [locaTableView reloadData];
            }];
            
        }else{
            _showDetails = YES;
            [_comboBoxCellArray addObjectsFromArray:_comboBoxArray];
            [locaTableView reloadData];
            
            CGRect rect;
            if (_comboBoxArray.count <= 3) {
                rect = CGRectMake(0, originalSize.height, originalSize.width, originalSize.height*_comboBoxArray.count);
            }else if(_comboBoxArray.count > 3){
                 rect = CGRectMake(0, originalSize.height, originalSize.width, originalSize.height*3);
            }
            
            [UIView animateWithDuration:0.2 animations:^{
                imageView.transform = CGAffineTransformMakeRotation(179*M_PI/180);
                self.frame = CGRectMake(originalPoint.x, originalPoint.y, originalSize.width, rect.size.height+originalSize.height);
                locaTableView.frame = rect;
            } completion:^(BOOL finished) {
            }];
        }
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comboBoxCellArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return originalSize.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
    }
    [cell setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.textLabel setText:_comboBoxArray[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _showDetails = NO;
    [_contentLabel setText:_comboBoxArray[indexPath.row]];
    [UIView animateWithDuration:0.2 animations:^{
        imageView.transform = CGAffineTransformMakeRotation(0*M_PI/180);
        self.frame = CGRectMake(originalPoint.x, originalPoint.y, originalSize.width, originalSize.height);
        locaTableView.frame = CGRectMake(0, originalSize.height, originalSize.width, 0);
    } completion:^(BOOL finished) {
        [_comboBoxCellArray removeAllObjects];
        [locaTableView reloadData];
    }];
}
@end
