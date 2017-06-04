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

@property (strong,nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items =  [NSMutableArray arrayWithObjects:@"东邪",@"西毒",@"南帝",@"北丐",nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
 
    _tableView.rowHeight = 60;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:10]];
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = @"详细信息";
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    
    return cell;
}

//下面的方法，看方法名称，我们也可以得出，他就是在询问是不是可以编辑每一个indexPath，返回YES就是可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了删除");
    
        [self.items removeObjectAtIndex:indexPath.row];

        NSMutableArray * indexPathArray = [NSMutableArray arrayWithObject:indexPath];
        
        [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    deleteRowAction.backgroundColor = [UIColor greenColor];
    //置顶
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了置顶");
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"第%ld行的标题是%@",indexPath.row,cell.textLabel.text);
    
    cell.textLabel.text = @"我是新标题";
    
    NSLog(@"第%ld行的内容是%@",indexPath.row,cell.detailTextLabel.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
