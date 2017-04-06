//
//  LQPhoneViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/16.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQPhoneViewController.h"
#import <Photos/Photos.h>


static NSString *listCellName = @"listCellName";

@interface LQPhoneViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) NSMutableArray *photosArr;
@property (nonatomic, strong) UITableView *listTable;

@end

@implementation LQPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupForController];
}

- (void)setupForController
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listTable];
    [self getPhotoFromAlbum];
}

- (void)getPhotoFromAlbum
{
//    PHCachingImageManager
    
    
    PHFetchResult *list =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    for (PHAssetCollection *collect in list) {
        PHFetchResult *asset = [PHAsset fetchAssetsInAssetCollection:collect options:nil];
        for (PHAsset *ass in asset) {
            [self.photosArr addObject:ass];
        }
    }
    [[[PHCachingImageManager alloc] init] startCachingImagesForAssets:self.photosArr targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeDefault options:nil];
    [self.listTable reloadData];
}


#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photosArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellName];
    PHAsset *asset = self.photosArr[indexPath.row];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(40, 40) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            NSLog(@"%@",result);
            cell.imageView.image = result;
            [cell setNeedsLayout];
        }
    }];
    return cell;
    
}


- (NSMutableArray *)photosArr
{
    if (_photosArr == nil) {
        _photosArr = [NSMutableArray array];
    }
    return _photosArr;
}

- (UITableView *)listTable
{
    if (_listTable == nil) {
        _listTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        [_listTable registerClass:[UITableViewCell class] forCellReuseIdentifier:listCellName];
    }
    return _listTable;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
