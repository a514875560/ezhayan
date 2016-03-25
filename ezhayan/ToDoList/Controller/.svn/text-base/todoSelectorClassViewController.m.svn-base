//
//  todoSelectorClassViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 16/2/23.
//  Copyright © 2016年 ChenFengbo. All rights reserved.
//

#import "todoSelectorClassViewController.h"
#import "todoClassCollectionViewCell.h"
#import "todoClassModel.h"

@interface todoSelectorClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UIView *footView;

@end

@implementation todoSelectorClassViewController

@synthesize rowDescriptor = _rowDescriptor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置分类";
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.footView];
    
    if (self.rowDescriptor.value) {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getClassListData];
}

#pragma mark - getClassListData

- (void)getClassListData
{
    [WXDataServer requestURL:@"TodoEvent/getTodoCategoryList"
                  httpMethod:@"GET"
                      params:[@{@"md5getTodoCategoryList":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]]}mutableCopy]
                        file:nil
                     success:^(id data) {
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             NSMutableArray *issueArr = [NSMutableArray array];
                             for (NSDictionary *dic in data[@"data"]) {
                                 todoClassModel *model = [[todoClassModel alloc] initWithJSONDic:dic];
                                 [issueArr addObject:model];
                             }
                             _dataSource = issueArr;
                             [_collectionView reloadData];
                         }
                         else
                         {
                             [SVProgressHUD showInfoWithStatus:data[@"message"]];
                         }
                     }
                        fail:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:@"链接错误"];
                            
                        }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    todoClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todoClassSelectCell" forIndexPath:indexPath];
    todoClassModel *model = _dataSource[indexPath.row];
    cell.title = model.name;
    cell.didSelectClass = ^{
        self.rowDescriptor.value = [XLFormOptionsObject formOptionsObjectWithValue:model.categoryId displayText:model.name];
        [self.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(32, 15, 32, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 16;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 16;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kDeviceWidth - 62) / 3, 40);
}


#pragma mark - getter

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight - 134) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[todoClassCollectionViewCell class] forCellWithReuseIdentifier:@"todoClassSelectCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

- (UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, KDeviceHeight - 134, kDeviceWidth, 134)];
        _footView.backgroundColor = [UIUtils colorWithHexString:@"#f5f5f5"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 41, kDeviceWidth - 30, 52);
        button.backgroundColor = [UIUtils colorWithHexString:@"#40b49c"];
        [button setTitle:@"自定义添加" forState:0];
        [button setImage:[UIImage imageNamed:@"classify_jia"] forState:0];
        button.titleLabel.textColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:21];
        
        [_footView addSubview:button];
    }
    return _footView;
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
