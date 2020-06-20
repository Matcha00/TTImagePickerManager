//
//  TTImagePickerVC.m
//  TTImagePicker
//
//  Created by 陈欢 on 2020/4/25.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import "TTImagePickerVC.h"
#import "TTImagePickerCell.h"
#import "UIView+TTImagePicker.h"
#import "TTAlbumVC.h"
#define WKC_WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface TTImagePickerVC ()
@property (nonatomic, strong) NSMutableArray<TTAsset *> *assetsArray;
@property (nonatomic, strong) NSMutableArray<TTAsset *> *selecteAssetsArray;
@property (nonatomic, assign) CGRect previousPreheatRect;
@property (nonatomic, strong) UIButton *titleView;
@property (nonatomic, strong) TTAlbumVC *albumVC;
@end

@implementation TTImagePickerVC

static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(103, 103);
    // 设置最小行间距
    layout.minimumLineSpacing = 0;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[TTImagePickerCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleView;
}

- (void)setAssetsGroup:(TTAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    [self.assetsArray removeAllObjects];
    [self.titleView setTitle:assetsGroup.name forState:UIControlStateNormal];
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [assetsGroup enumerateAssetsUsingBlock:^(TTAsset *resultAsset) {
            if (resultAsset) {
                [self.assetsArray addObject:resultAsset];
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }
        }];
    });
}
- (NSMutableArray<TTAsset *> *)assetsArray {
    if (!_assetsArray) {
        _assetsArray = [[NSMutableArray alloc]init];
    }
    return _assetsArray;
}

- (UIButton *)titleView {
    if (!_titleView) {
        _titleView = [[UIButton alloc]init];
        _titleView.width = 150;
        [_titleView sizeToFit];
        [_titleView setImage:[UIImage imageNamed:@"icon_full"] forState:UIControlStateNormal];
        [_titleView addTarget:self action:@selector(didClickAlbum:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _titleView;
}

- (TTAlbumVC *)albumVC {
    if (!_albumVC) {
        _albumVC = [[TTAlbumVC alloc]init];
        [self addChildViewController:_albumVC];
        [self.view addSubview:_albumVC.view];
        _albumVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
        _albumVC.view.hidden = YES;
        @weakify(self)
        _albumVC.didClickAlbum = ^(TTAlbumVC * _Nonnull albumVC, TTAssetsGroup * _Nonnull assetsGroup) {
            @strongify(self)
            albumVC.view.hidden = YES;
            [self buttonAnimation];
            self.assetsGroup = assetsGroup;
        };
    }
    return _albumVC;
}

- (void)didClickAlbum:(UIButton *)button {
    self.albumVC.view.hidden = !self.albumVC.view.hidden;
    
    [self buttonAnimation];
    
}

- (void)buttonAnimation {
    [UIView animateWithDuration:0.3 animations:^{
       self.titleView.imageView.transform = self.albumVC.view.hidden ? CGAffineTransformMakeRotation(2 *M_PI) :CGAffineTransformMakeRotation(M_PI) ;
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.asset = self.assetsArray[indexPath.row];
    cell.selecteAssetsArray = self.selecteAssetsArray;
    cell.selectedImageMode = self.selecteAssetsArray.count > 0 ? YES : NO;
    if ([self.selecteAssetsArray containsObject:self.assetsArray[indexPath.row]]) {
        cell.isSelected = YES;
    }else {
        cell.isSelected = NO;
    }
    @weakify(self)
    cell.didSelected = ^(TTImagePickerCell * _Nonnull imagePickerCell, TTAsset * _Nonnull asset) {
        @strongify(self)
        if ([self.selecteAssetsArray containsObject:asset]) {
            [self.selecteAssetsArray removeObject:asset];
            imagePickerCell.isSelected = NO;
        }else {
            if (self.selecteAssetsArray.count == self.maxImagesCount) {
                NSLog(@"选择图片不能超过%ld",(long)self.maxImagesCount);
            }else {
                [self.selecteAssetsArray addObject:asset];
                imagePickerCell.isSelected = YES;
            }
            
        }
        [self.collectionView reloadData];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    !self.didClick ?: self.didClick(self,self.assetsArray[indexPath.row],self.assetsGroup);
}

- (NSMutableArray<TTAsset *> *)selecteAssetsArray {
    if (!_selecteAssetsArray) {
        _selecteAssetsArray = [NSMutableArray new];
    }
    return _selecteAssetsArray;
}
- (NSInteger)maxImagesCount {
    if (!_maxImagesCount) {
        _maxImagesCount = 1;
    }
    return _maxImagesCount;
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.width / 3);
}
- (void)updateCachedAssets {
    if (!self.isViewLoaded && self.view.window == nil) {
        return;
    }
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.width, self.collectionView.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0, -0.5 * visibleRect.size.height);

    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));

    if (delta <= (self.view.height / 3.0)) {
        return;
    }
    WKC_WeakSelf(ws)
    [self differencesBetweenRectsOld:self.previousPreheatRect new:preheatRect result:^(NSArray<NSValue *> *added, NSArray<NSValue *> *removed) {
        PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
        phImageRequestOptions.networkAccessAllowed = YES;
        phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[[TTPhotoManager manager]phCachingImageManager] startCachingImagesForAssets:[ws getPHAssetWith:added] targetSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.width / 3) contentMode:PHImageContentModeAspectFill options:phImageRequestOptions];
       [[[TTPhotoManager manager]phCachingImageManager] stopCachingImagesForAssets:[ws getPHAssetWith:removed] targetSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 3, [UIScreen mainScreen].bounds.size.width / 3) contentMode:PHImageContentModeAspectFill options:phImageRequestOptions];
        ws.previousPreheatRect = preheatRect;
    }];
    
    
    NSLog(@"%@", NSStringFromCGRect(self.previousPreheatRect));
}

- (NSMutableArray<PHAsset *>*)getPHAssetWith:(NSArray<NSValue *> *)rectArray {
    NSMutableArray<PHAsset *>* pHAssetArray = [[NSMutableArray alloc]init];
    NSMutableArray<NSIndexPath *>  *indexPathArray = [[NSMutableArray alloc]init];
    for (NSValue *value in rectArray) {
        CGRect tempRect = [value CGRectValue];
        NSArray<NSIndexPath *>  *tempIndexPathArray = [self indexPathsForElements:tempRect];
        [indexPathArray addObjectsFromArray:tempIndexPathArray];
    }
    for (NSIndexPath *indexpath in indexPathArray) {
        TTAsset *data = self.assetsArray[indexpath.row];
        [pHAssetArray addObject:data.phAsset];
    }
    return pHAssetArray;
}

- (NSArray<NSIndexPath *> *)indexPathsForElements:(CGRect)rect {
    NSArray<UICollectionViewLayoutAttributes *> *allLayoutAttributes = [self.collectionViewLayout layoutAttributesForElementsInRect:rect];
    NSMutableArray<NSIndexPath *> *indexMutableArray = [[NSMutableArray alloc]init];
    for (UICollectionViewLayoutAttributes *layoutAttribute in allLayoutAttributes) {
        [indexMutableArray addObject:layoutAttribute.indexPath];
    }
    return [indexMutableArray copy];
}



- (void)differencesBetweenRectsOld:(CGRect)old new:(CGRect)new result:(void(^)(NSArray<NSValue *> *added,NSArray<NSValue *> *removed))result {
    if (CGRectIntersectsRect(old, new)) {
        NSMutableArray *added = [[NSMutableArray alloc]init];
        if (CGRectGetMaxY(new) > CGRectGetMaxY(old)) {
            [added addObject:[NSValue valueWithCGRect:CGRectMake(new.origin.x, CGRectGetMaxY(old), new.size.width, CGRectGetMaxY(new) - CGRectGetMaxY(old))]];
        }
        
        if (CGRectGetMinY(old) > CGRectGetMinY(new)) {
            [added addObject:[NSValue valueWithCGRect:CGRectMake(new.origin.x, CGRectGetMinY(new), new.size.width, CGRectGetMinY(old) - CGRectGetMinY(new))]];
        }
        
        NSMutableArray *removed = [[NSMutableArray alloc]init];
        
        if (CGRectGetMaxY(new) < CGRectGetMaxY(old)) {
            [removed addObject:[NSValue valueWithCGRect:CGRectMake(new.origin.x, CGRectGetMaxY(new), new.size.width, CGRectGetMaxY(old) - CGRectGetMaxY(new))]];
        }
        
        if (CGRectGetMinY(old) < CGRectGetMinY(new)) {
            [removed addObject:[NSValue valueWithCGRect:CGRectMake(new.origin.x, CGRectGetMinY(old), new.size.width, CGRectGetMinY(new) - CGRectGetMinY(old))]];
        }
        result(added,removed);
    }else {
        result(@[[NSValue valueWithCGRect:new]],@[[NSValue valueWithCGRect:old]]);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}
@end
