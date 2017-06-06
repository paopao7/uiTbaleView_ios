//
//  ViewController.m
//  tableView
//
//  Created by 钱超 on 2017/6/4.
//  Copyright © 2017年 钱超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *items;

@property (strong,nonatomic) NSMutableArray *detailItems;

@property (strong,nonatomic) NSMutableArray *imageItems;

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items =  [NSMutableArray arrayWithObjects:@"我是苹果",@"我是葡萄",@"我是柠檬",@"我是芒果",@"我是橙子",@"我是梨子",@"我是菠萝",@"我是石榴",@"我是草莓",@"我是西瓜",nil];
    
    self.detailItems = [NSMutableArray arrayWithObjects:@"我是苹果我是苹果我是苹果我是苹果我是苹果",@"我是葡萄我是葡萄我是葡萄我是葡萄我是葡萄",@"我是柠檬我是柠檬我是柠檬我是柠檬我是柠檬",@"我是芒果我是芒果我是芒果我是芒果我是芒果",@"我是橙子我是橙子我是橙子我是橙子我是橙子",@"我是梨子我是梨子我是梨子我是梨子我是梨子",@"我是菠萝我是菠萝我是菠萝我是菠萝我是菠萝",@"我是石榴我是石榴我是石榴我是石榴我是石榴",@"我是草莓我是草莓我是草莓我是草莓我是草莓",@"我是西瓜我是西瓜我是西瓜我是西瓜我是西瓜",nil];
    
    self.imageItems = [NSMutableArray arrayWithObjects:@"apple",@"grape",@"lemon",@"mango",@"orange",@"pear",@"pineapple",@"pomegrante",@"strawberry",@"watermelon",nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-30) style:UITableViewStylePlain];
 
    tableView.rowHeight = 60;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1];
    
    [self.view addSubview:tableView];
    
    
}

// 设置表头的高度。如果使用自定义表头，该方法必须要实现，否则自定义表头无法执行，也不会报错
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

//自定义headerView
- (UIView *) tableView:(UITableView *)_tableViews viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5, 40, 40)];
    
    logoImageView.image = [UIImage imageNamed:@"grape"];

    UILabel *headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 70, 50)];
    
    headerTitleLabel.textColor = [UIColor blackColor];
    
    headerTitleLabel.text = @"水果天堂";
    
    headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [headerView.layer setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1].CGColor];
    
    [headerView addSubview:logoImageView];
    
    [headerView addSubview:headerTitleLabel];
    
    return headerView;
}

//定义行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.items.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, 320 , 0, 0);
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//数据置入以及样式设置
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:10]];
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [self.detailItems objectAtIndex:indexPath.row];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apple.jpg"]];
    
    NSString *imageName = [self.imageItems objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    //修改图片大小
    CGSize itemSize = CGSizeMake(40, 40);
    
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    
    [cell.imageView.image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    
    return cell;
}

//下面的方法，看方法名称，我们也可以得出，他就是在询问是不是可以编辑每一个indexPath，返回YES就是可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置cell左划菜单
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了删除");
    
        //删除操作的实现
        [self.items removeObjectAtIndex:indexPath.row];

        NSMutableArray *indexPathArray = [NSMutableArray arrayWithObject:indexPath];
        
        [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        
        if (self.items.count == 0) {
            UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(103, 200, 114, 30)];
            
            noDataLabel.text = @"暂无数据 请稍后尝试";
            
            noDataLabel.textColor = [UIColor grayColor];
            
            [noDataLabel setFont:[UIFont systemFontOfSize:12]];
            
            [self.view addSubview:noDataLabel];
        }
    }];
    
    deleteRowAction.backgroundColor = [UIColor greenColor];
    
    //置顶
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了置顶");
        
        //置顶功能的实现
        //1.更新数据
        [self.items exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
        [tableView setEditing:NO animated:YES];
    }];
    
    //标记为已读
    UITableViewRowAction *readedRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记为已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了标记为已读");
    }];
    
//    if(indexPath.section == 0 && indexPath.row == 0)
//    {
//        return @[deleteRowAction];
//    }
//    else if(indexPath.section == 0 && indexPath.row == 1)
//    {
//        return @[deleteRowAction, readedRowAction];
//    }
//    else if (indexPath.section == 1 && indexPath.row == 0)
//    {
//        return @[topRowAction];
//    }
//    else
//    {
        return @[deleteRowAction, topRowAction, readedRowAction];
//    }
}


//点击cell时的操作
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"第%ld行的标题是%@",indexPath.row,cell.textLabel.text);
    
    cell.textLabel.text = @"我是新标题";
    
    NSLog(@"第%ld行的内容是%@",indexPath.row,cell.detailTextLabel.text);
}


- (void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground)name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)applicationWillEnterForeground{
    
    NSArray *indexPaths = @[
                            [NSIndexPath indexPathForRow:0 inSection:0],
                            [NSIndexPath indexPathForRow:1 inSection:0]
                            ];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    
    NSLog(@"回到前台");
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
