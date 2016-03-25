//
//  toDoListViewController.m
//  ezhayan
//
//  Created by ChenFengbo on 15/10/21.
//  Copyright © 2015年 ChenFengbo. All rights reserved.
//

#import "toDoListViewController.h"
#import "todoCollectionViewCell.h"
#import "todoListHeadView.h"
#import "willDoViewController.h"
#import "didEndViewController.h"
#import "todoListCollectionReusableView.h"
#import "newToDoViewController.h"
#import "todoWillSendViewController.h"
#import "todoMessageListViewController.h"
#import "todoEditClassViewController.h"

#import "todoHomeListModel.h"
#import "todoClassListModel.h"

@interface toDoListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSString *flag;
@property (nonatomic,strong) todoHomeListModel *todoHomeModel;

@end

@implementation toDoListViewController

#pragma mark - life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"我的待办";
    
    [self.view addSubview:self.collectionView];

    _flag = @"1";
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"todo_nav_ico"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBut:)];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getTodoClassList];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - GetTodoClassListData
- (void)getTodoClassList
{
    [WXDataServer requestURL:@"TodoEvent/getTodoHomeData"
                  httpMethod:@"GET"
                      params:[@{@"md5getTodoHomeData":[UIUtils encodeToPercentEscapeString:[UIUtils TripleDES:[NSString stringWithFormat:@"%@",[Commtion shareCommtion].user.client_id] encryptOrDecrypt:kCCEncrypt DESKEY:KEY]],
                                @"flag":_flag}mutableCopy]
                        file:nil
                     success:^(id data) {
                         [SVProgressHUD dismiss];
                         if([[NSString stringWithFormat:@"%@",data[@"success"]] isEqualToString:@"1"]){
                             
                             for (NSDictionary *homeDict in data[@"data"]) {
                                 todoHomeListModel *model = [[todoHomeListModel alloc]initWithJSONDic:homeDict];
                                 NSMutableArray *issueArr = [NSMutableArray array];
                                 for (NSDictionary *dic in model.resultMap) {
                                     todoClassListModel *model = [[todoClassListModel alloc] initWithJSONDic:dic];
                                     [issueArr addObject:model];
                                 }
                                 model.resultMap = issueArr;
                                 _todoHomeModel = model;
                                 _dataSource = issueArr;
                             }
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

#pragma mark - EventAction
- (void)didRightBut:(UIBarButtonItem *)sender
{
    todoMessageListViewController *message = [[todoMessageListViewController alloc]init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        default:
            return _dataSource.count;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        todoListHeadView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todoListHeadCell" forIndexPath:indexPath];
        cell.didAddNewTodo = ^{
            newToDoViewController *newTodo = [[newToDoViewController alloc]init];
            newTodo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newTodo animated:YES];
        };
        return cell;
    }
    todoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todoListCell" forIndexPath:indexPath];
    todoClassListModel *model = _dataSource[indexPath.row];
    cell.model = model;
    
    cell.didEdit = ^{
        todoEditClassViewController *editClass = [[todoEditClassViewController alloc]init];
        editClass.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:editClass animated:YES];
    };
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(kDeviceWidth, 181);
            break;
        default:
        {
            CGFloat width = (kDeviceWidth - 60) / 2;
            return CGSizeMake(width, width * 1.26);
        }
            break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return CGFLOAT_MIN;
            break;
            
        default:
            return 25.0f;
            break;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return CGFLOAT_MIN;
            break;
        default:
            return 30.0f;
            break;
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        todoClassListModel *model = _dataSource[indexPath.row];
        
        NSInteger count = [_flag integerValue];
        switch (count) {
            case 1:
            {
                willDoViewController *willdo = [[willDoViewController alloc]init];
                if (model.td_id) {
                    willdo.class_id = model.td_id;
                }
                else
                {
                    willdo.class_id = @"";
                }
                willdo.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:willdo animated:YES];
            }
                break;
            case 2:
            {
                didEndViewController *enddo = [[didEndViewController alloc]init];
                if (model.td_id) {
                    enddo.class_id = model.td_id;
                }
                else
                {
                    enddo.class_id = @"";
                }
                enddo.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:enddo animated:YES];
            }
                break;
            case 3:
            {
                todoWillSendViewController *willsend = [[todoWillSendViewController alloc]init];
                if (model.td_id) {
                    willsend.class_id = model.td_id;
                }
                else
                {
                    willsend.class_id = @"";
                }
                willsend.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:willsend animated:YES];
            }
                break;
            default:
                
                break;
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return UIEdgeInsetsZero;
            break;
        default:
            return UIEdgeInsetsMake(25, 15, 25, 15);
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return CGSizeZero;
            break;
        default:
            return CGSizeMake(kDeviceWidth, 70);
            break;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    todoListCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    headView.model = self.todoHomeModel;
    headView.didWillDo = ^{
        _flag = @"1";
        [SVProgressHUD show];
        [self getTodoClassList];
    };
    headView.didFinshDo = ^{
        _flag = @"2";
        [SVProgressHUD show];
        [self getTodoClassList];
    };
    headView.didWillSend = ^{
        _flag = @"3";
        [SVProgressHUD show];
        [self getTodoClassList];
    };
    headView.didFinshSend = ^{
        _flag = @"4";
        [SVProgressHUD show];
        [self getTodoClassList];
    };
    return headView;
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    else
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
//        flowLayout.sectionHeadersPinToVisibleBounds = NO;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = appTableviewBgColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"todoCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"todoListCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"todoListHeadView" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"todoListHeadCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"todoListCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        return _collectionView;
    }
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
