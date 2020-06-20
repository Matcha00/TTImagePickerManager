//
//  TTAssetsGroup.h
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import "TTPhotoManager.h"
@class TTAsset;
//NS_ASSUME_NONNULL_BEGIN

@interface TTAssetsGroup : NSObject
- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection;

- (instancetype)initWithPHCollection:(PHAssetCollection *)phAssetCollection fetchAssetsOptions:(PHFetchOptions *)pHFetchOptions;

/// 仅能通过 initWithPHCollection 和 initWithPHCollection:fetchAssetsOption 方法修改 phAssetCollection 的值
@property(nonatomic, strong, readonly) PHAssetCollection *phAssetCollection;

/// 仅能通过 initWithPHCollection 和 initWithPHCollection:fetchAssetsOption 方法修改 phAssetCollection 后，产生一个对应的 PHAssetsFetchResults 保存到 phFetchResult 中
@property(nonatomic, strong, readonly) PHFetchResult *phFetchResult;

/// 相册的名称
- (NSString *)name;

/// 相册内的资源数量，包括视频、图片、音频（如果支持）这些类型的所有资源
- (NSInteger)numberOfAssets;

/**
 *  相册的缩略图，即系统接口中的相册海报（Poster Image）
 *
 *  @return 相册的缩略图
 */
- (UIImage *)posterImageWithSize:(CGSize)size;

- (void)enumerateAssetsWithOptions:(TTAlbumSortType)albumSortType usingBlock:(void (^)(TTAsset *resultAsset))enumerationBlock;

- (void)enumerateAssetsUsingBlock:(void (^)(TTAsset *resultAsset))enumerationBlock;
@end

//NS_ASSUME_NONNULL_END
