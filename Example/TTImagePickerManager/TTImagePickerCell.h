//
//  TTImagePickerCell.h
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTAsset,TTImagePickerCell;
NS_ASSUME_NONNULL_BEGIN
typedef void(^TTImagePickerCellBlock)(TTImagePickerCell *imagePickerCell,TTAsset *asset);
@interface TTImagePickerCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *assetImageView;
@property (nonatomic, strong) TTAsset *asset;
@property(nonatomic, copy) NSString *assetIdentifier;// 当前这个 cell 正在展示的 QMUIAsset 的 identifier
@property(nonatomic, strong) UIButton *selecteButton;
@property(nonatomic, assign) BOOL isSelected; // 图片选中
@property(nonatomic, assign) BOOL selectedImageMode; // 图片选中
@property(nonatomic, strong) UIImageView *videoIconImageView;
@property(nonatomic, strong) UILabel *videoTimeLabel;
@property(nonatomic, strong) UIImageView *maskVideoImageView;
@property (nonatomic, copy) TTImagePickerCellBlock didSelected;
@property (nonatomic, strong) NSMutableArray<TTAsset *> *selecteAssetsArray;
@end

NS_ASSUME_NONNULL_END
