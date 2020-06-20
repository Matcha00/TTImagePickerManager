//
//  TTImagePickerVC.h
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTAssetsGroup,TTAsset,TTImagePickerVC;
NS_ASSUME_NONNULL_BEGIN
typedef void(^TTImagePickerVCBlock)(TTImagePickerVC *imagePickerVC,TTAsset *asset,TTAssetsGroup *assetsGroup);
@interface TTImagePickerVC : UICollectionViewController
@property (nonatomic, strong)TTAssetsGroup *assetsGroup;
@property (nonatomic, assign) NSInteger maxImagesCount; // 选择图片数量默认1
@property (nonatomic, copy) TTImagePickerVCBlock didClick;
@end

NS_ASSUME_NONNULL_END
