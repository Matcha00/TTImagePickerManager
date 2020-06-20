//
//  TTAlbumVC.h
//  TTImagePicker
//
//  Created by 陈欢 on 2020/5/1.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTAssetsGroup,TTAlbumVC;
NS_ASSUME_NONNULL_BEGIN
typedef void(^TTAlbumVCBlock)(TTAlbumVC *albumVC, TTAssetsGroup *assetsGroup);
@interface TTAlbumVC : UITableViewController
@property (nonatomic, copy) TTAlbumVCBlock didClickAlbum;
@end

NS_ASSUME_NONNULL_END
