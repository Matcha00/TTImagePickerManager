//
//  TTAlbumTableViewCell.m
//  TTImagePicker
//
//  Created by 陈欢 on 2020/5/1.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import "TTAlbumTableViewCell.h"

@implementation TTAlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (UIImageView *)ablbumImageView {
    if (!_ablbumImageView) {
        _ablbumImageView = [[UIImageView alloc]init];
        _ablbumImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_ablbumImageView];
        [_ablbumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(60);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return _ablbumImageView;
}
- (UILabel *)albumNamel {
    if (!_albumNamel) {
        _albumNamel = [[UILabel alloc]init];
        [self.contentView addSubview:_albumNamel];
        [_albumNamel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.ablbumImageView.mas_right).offset(10);
        }];
    }
    return _albumNamel;
}
- (UILabel *)albumCount {
    if (!_albumCount) {
        _albumCount = [[UILabel alloc]init];
        [self.contentView addSubview:_albumCount];
        [_albumCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.albumNamel.mas_right).offset(10);
        }];
    }
    return _albumCount;
}
@end
