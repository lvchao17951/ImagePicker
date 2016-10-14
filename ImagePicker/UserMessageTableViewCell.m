//
//  UserMessageTableViewCell.m
//  ImagePicker
//
//  Created by 吕超 on 16/10/12.
//  Copyright © 2016年 吕超. All rights reserved.
//

#import "UserMessageTableViewCell.h"
#import <Masonry.h>

@implementation UserMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createMyCell];
    }
    return self;
}

- (void)createMyCell
{
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.detialLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.detialLabel];
}

- (void)layoutSubviews
{
    
    /*
     *   @ 核心理念: 约束、参照
     *
     *   @ Masonry 中的语法问题:
     *
     *   @ mas_equalTo 和 equalTo 区别:
     *   @ mas_equalTo 后面往往是具体的"数值"
     *   @ equalTo     后面往往是"控件", "视图"
     *
     */
    
    [super layoutSubviews];
    
//    self.nameLabel.frame = CGRectMake(20, 8, 100, 30);
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(8);
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:16 weight:0];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = 0;
    
//    self.detialLabel.frame = CGRectMake(285, 12, 50, 20);
    [self.detialLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(12);
    }];
    self.detialLabel.font = [UIFont systemFontOfSize:14 weight:0];
    self.detialLabel.textColor = [UIColor lightGrayColor];
    self.detialLabel.textAlignment = 2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
