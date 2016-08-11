//
//  MainViewController.m
//  ICGeneral
//
//  Created by Lotheve on 15/7/20.
//  Copyright (c) 2015年 Lotheve. All rights reserved.
//

#import "MainViewController.h"
//#import "ICLibrary.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *table;
@property (strong, nonatomic)NSArray *tableArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"封装列表";
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- Getter, Setter
- (UITableView*)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _table;
}

- (NSArray*)tableArray{
    if (!_tableArray) {
        _tableArray = [[NSArray alloc]initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"main" withExtension:@"plist"]];
        NSLog(@"%@", _tableArray);
    }
    return _tableArray;
}

#pragma mark- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *groupDic = [self.tableArray objectAtIndex:indexPath.section];
    NSArray *array = [groupDic objectForKey:@"groupCells"];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *className = [dic objectForKey:@"viewController"];
    
    Class someClass = NSClassFromString(className);
    UIViewController *vc = [[someClass alloc] init];
    
    vc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;//设置tableHeader的高度，10，可以识别
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0 || section==1) {
        return CGFLOAT_MIN;//最小数，相当于0
    }
    
    return 0;//机器不可识别，然后自动返回默认高度
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.tableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [self.tableArray objectAtIndex:section];
    NSArray *array = [dic objectForKey:@"groupCells"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = [self.tableArray objectAtIndex:section];
    return [dic objectForKey:@"groupTitle"];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.tableArray objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:@"groupCells"];
    NSDictionary *nameDic = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [nameDic objectForKey:@"name"];
    return cell;
}
@end
