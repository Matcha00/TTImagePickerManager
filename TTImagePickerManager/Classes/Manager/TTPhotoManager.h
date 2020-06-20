//
//  TTPhotoManager.h
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//
#import <Photos/Photos.h>
@class TTAssetsGroup,TTAsset;
//NS_ASSUME_NONNULL_BEGIN
/// Asset 授权的状态
typedef NS_ENUM(NSUInteger, TTAssetAuthorizationStatus) {
    TTAssetAuthorizationStatusNotDetermined,      // 还不确定有没有授权
    TTAssetAuthorizationStatusAuthorized,         // 已经授权
    TTAssetAuthorizationStatusNotAuthorized       // 手动禁止了授权
};
/// 相册展示内容的类型
typedef NS_ENUM(NSUInteger, TTAlbumContentType) {
    TTAlbumContentTypeAll,                                  // 展示所有资源
    TTAlbumContentTypeOnlyPhoto,                            // 只展示照片
    TTAlbumContentTypeOnlyVideo,                            // 只展示视频
    TTAlbumContentTypeOnlyAudio                             // 只展示音频
};

/// 相册展示内容按日期排序的方式
typedef NS_ENUM(NSUInteger, TTAlbumSortType) {
    TTAlbumSortTypePositive,  // 日期最新的内容排在后面
    TTAlbumSortTypeReverse  // 日期最新的内容排在前面
};

@interface TTPhotoManager : NSObject

+ (instancetype)manager;
@property (nonatomic, assign) TTAlbumContentType contentType;
@property (nonatomic, assign) BOOL showEmptyAlbum;
/// 获取一个 PHCachingImageManager 的实例
- (PHCachingImageManager *)phCachingImageManager;
/// 获取当前应用的“照片”访问授权状态
+ (TTAssetAuthorizationStatus)authorizationStatus;

/**
 *  调起系统询问是否授权访问“照片”的 UIAlertView
 *  @param handler 授权结束后调用的 block，默认不在主线程上执行，如果需要在 block 中修改 UI，记得 dispatch 到 mainqueue
 */
+ (void)requestAuthorization:(void(^)(TTAssetAuthorizationStatus status))handler;



/**
 *  获取所有的相册，包括个人收藏，最近添加，自拍这类“智能相册”
 *
 *  @param enumerationBlock          参数 resultAssetsGroup 表示每次枚举时对应的相册。枚举所有相册结束后，enumerationBlock 会被再调用一次，
 *                                   这时 resultAssetsGroup 的值为 nil。可以以此作为判断枚举结束的标记。
 */
//- (void)enumerateAllAlbumsUsingBlock:(void(^)(TTAssetsGroup * _Nullable resultAssetsGroup))enumerationBlock;
- (void)enumerateAllAlbumsUsingBlock:(void(^)(TTAssetsGroup * _Nullable resultAssetsGroup))enumerationBlock;
@end

//NS_ASSUME_NONNULL_END
