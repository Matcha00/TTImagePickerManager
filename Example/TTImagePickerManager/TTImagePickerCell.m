//
//  TTImagePickerCell.m
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import "TTImagePickerCell.h"
#import "TTAsset.h"
@implementation TTImagePickerCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (UIImageView *)assetImageView {
    if (!_assetImageView) {
        _assetImageView = [[UIImageView alloc]init];
        _assetImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_assetImageView];
        [_assetImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
        _assetImageView.clipsToBounds = YES;
    }
    return _assetImageView;
}

- (UIImageView *)maskVideoImageView {
    if (!_maskVideoImageView) {
        _maskVideoImageView = [[UIImageView alloc]init];
        _maskVideoImageView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.assetImageView addSubview:_maskVideoImageView];
        [self.assetImageView bringSubviewToFront:_maskVideoImageView];
        [_maskVideoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.assetImageView);
        }];
    }
    return _maskVideoImageView;
}

- (UIImageView *)videoIconImageView {
    if (!_videoIconImageView) {
        _videoIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"VideoSendIcon"]];
        [self.assetImageView addSubview:_videoIconImageView];
        [_videoIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(16);
            make.bottom.mas_equalTo(self.assetImageView.mas_bottom).offset(-5);
            make.left.mas_equalTo(self.assetImageView.mas_left).offset(5);
        }];
    }
    return _videoIconImageView;
}

- (UILabel *)videoTimeLabel {
    if (!_videoTimeLabel) {
        _videoTimeLabel = [[UILabel alloc]init];
        _videoTimeLabel.textColor = [UIColor whiteColor];
        [self.assetImageView addSubview:_videoTimeLabel];
        [_videoTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.centerY.mas_equalTo(self.videoIconImageView.mas_centerY);
            make.left.mas_equalTo(self.videoIconImageView.mas_right).offset(5);
            make.right.mas_equalTo(self.assetImageView.mas_right);
        }];
    }
    return _videoTimeLabel;
}

- (UIButton *)selecteButton {
    if (!_selecteButton) {
        _selecteButton = [[UIButton alloc]init];
        [_selecteButton setBackgroundImage:[UIImage imageNamed:@"photo_def_photoPickerVc"] forState:UIControlStateNormal];
        [_selecteButton setBackgroundImage:[UIImage imageNamed:@"photo_number_icon"] forState:UIControlStateSelected];
        _selecteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_selecteButton addTarget:self action:@selector(selectedAsset:) forControlEvents:UIControlEventTouchUpInside];
        [self.assetImageView addSubview:_selecteButton];
        [_selecteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(26);
            make.top.mas_equalTo(self.assetImageView.mas_top).offset(5);
            make.right.mas_equalTo(self.assetImageView.mas_right).offset(-5);
        }];
    }
    return _selecteButton;
}

- (void)setAsset:(TTAsset *)asset {
    _asset = asset;
    self.assetIdentifier = asset.identifier;
    [asset requestThumbnailImageWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.width / 3) completion:^(UIImage * _Nonnull result, NSDictionary<NSString *,id> * _Nonnull info) {
        if ([self.assetIdentifier isEqualToString:asset.identifier]) {
            self.assetImageView.image = result;
        } else {
            self.assetImageView.image = nil;
        }
    }];
    
    switch (asset.assetType) {
        case TTAssetTypeImage:
            self.videoIconImageView.hidden = YES;
            self.videoTimeLabel.hidden = YES;
            self.selecteButton.hidden = NO;
            break;
        case TTAssetTypeVideo:
            self.videoIconImageView.hidden = NO;
            self.videoTimeLabel.hidden = NO;
            self.selecteButton.hidden = YES;
            break;
            
        default:
            self.videoIconImageView.hidden = YES;
            self.videoTimeLabel.hidden = YES;
            break;
    }
    self.videoTimeLabel.text = [self timeStringWithMinsAndSecsFromSecs:asset.duration];
}
- (NSString *)timeStringWithMinsAndSecsFromSecs:(double)seconds {
    NSUInteger min = floor(seconds / 60);
    NSUInteger sec = floor(seconds - min * 60);
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)min, (long)sec];
}
- (void)selectedAsset:(UIButton *)button{
    !self.didSelected ?: self.didSelected(self,self.asset);
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selecteButton.selected = isSelected;
    if (isSelected) {
        [self.selecteButton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)[self.selecteAssetsArray indexOfObject:self.asset]+1] forState:UIControlStateSelected];
    }else {
        [self.selecteButton setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)setSelectedImageMode:(BOOL)selectedImageMode {
    _selectedImageMode = selectedImageMode;
    
    if (self.asset.assetType == TTAssetTypeImage) {
        self.maskVideoImageView.hidden = YES;
    }else {
        if (selectedImageMode) {
            self.maskVideoImageView.hidden = NO;
        }
    }
}
                                                    
@end
