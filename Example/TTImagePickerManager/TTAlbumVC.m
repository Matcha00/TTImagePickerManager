//
//  TTAlbumVC.m
//  TTImagePicker
//
//  Created by 陈欢 on 2020/5/1.
//  Copyright © 2020 Matcha00. All rights reserved.
//

#import "TTAlbumVC.h"
#import "TTAlbumTableViewCell.h"
@interface TTAlbumVC ()
@property (nonatomic, strong) NSMutableArray<TTAssetsGroup *> *assetsArray;
@end

@implementation TTAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:TTAlbumTableViewCell.class forCellReuseIdentifier:NSStringFromClass(TTAlbumTableViewCell.class)];
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [[TTPhotoManager manager]enumerateAllAlbumsUsingBlock:^(TTAssetsGroup * _Nullable resultAssetsGroup) {
           
            if (resultAssetsGroup) {
                [self.assetsArray addObject:resultAssetsGroup];
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                     [self.tableView reloadData];
                });
            }
           
        }];
    });
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.assetsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TTAlbumTableViewCell.class) forIndexPath:indexPath];
    cell.ablbumImageView.image = [self.assetsArray[indexPath.row] posterImageWithSize:CGSizeMake(60, 60)];
    cell.albumNamel.text = self.assetsArray[indexPath.row].name;
    cell.albumCount.text = [NSString stringWithFormat:@"(%lu)",(unsigned long)self.assetsArray[indexPath.row].phFetchResult.count];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    !self.didClickAlbum ?: self.didClickAlbum(self,self.assetsArray[indexPath.row]);
}

- (NSMutableArray<TTAssetsGroup *> *)assetsArray {
    if (!_assetsArray) {
        _assetsArray = [NSMutableArray new];
    }
    return _assetsArray;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
