//
//  TTViewController.m
//  TTImagePickerManager
//
//  Created by woshicainiaoma on 06/20/2020.
//  Copyright (c) 2020 woshicainiaoma. All rights reserved.
//

#import "TTViewController.h"
#import "TTImagePickerVC.h"
#import "TTAlbumVC.h"
@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     NSMutableArray<TTAssetsGroup*> *tempArray = [[NSMutableArray alloc]init];
//    [[TTPhotoManager manager]enumerateAllAlbumsUsingBlock:^(TTAssetsGroup * _Nullable resultAssetsGroup) {
//
//        if (resultAssetsGroup) {
//            [tempArray addObject:resultAssetsGroup];
//             NSLog(@"%@",tempArray);
//        }else {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                TTImagePickerVC *vc = [[TTImagePickerVC alloc]init];
//                vc.assetsGroup = tempArray.firstObject;
//                [self presentViewController:vc animated:YES completion:nil];
//            });
//            NSLog(@"%@",tempArray);
//
//        }
//
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        TTAlbumVC *vc = [[TTAlbumVC alloc]init];
//        [self presentViewController:vc animated:YES completion:nil];
//    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TTAlbumVC *vc = [[TTAlbumVC alloc]init];
//    vc.didClickAlbum = ^(TTAssetsGroup * _Nonnull assetsGroup) {
//        TTImagePickerVC *vc = [[TTImagePickerVC alloc]init];
//        vc.assetsGroup = assetsGroup;
//        [vc.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>];
//    };
    vc.didClickAlbum = ^(TTAlbumVC * _Nonnull albumVC, TTAssetsGroup * _Nonnull assetsGroup) {
        TTImagePickerVC *vc = [[TTImagePickerVC alloc]init];
        vc.assetsGroup = assetsGroup;
        [albumVC.navigationController pushViewController:vc animated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
