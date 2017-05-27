//
//  SecondViewController.m
//  tableviewcell-自适应
//
//  Created by quakoo on 2017/5/27.
//  Copyright © 2017年 quakoo. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableDictionary * dict;

@end

@implementation SecondViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dict = [NSMutableDictionary dictionary];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"second"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    // 设置tableViewCell 的高度默认为60
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // 这个方法只适用于ios7
    // self.tableView.separatorInset = UIEdgeInsetsZero;
    
    
    [self.view addSubview:self.tableView];
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
    
    UILabel * lb = [cell viewWithTag:101];
    
    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    int a = [self.dict[str] intValue];
    
    if (a!=0)
    {
        lb.numberOfLines  = 0;
        
    }else{
    
         lb.numberOfLines  = 1;
    
    }
 
    
    
    
    return  cell;
    
}


/*  这个代理是我们自己去计算每一个cell的高度问题 现在要自适应 所以这个暂时没用
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return  70;
 
 }
 */


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    SecondTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UILabel * lb = [cell viewWithTag:101];
    
    
    [tableView beginUpdates];
    
    [self.dict removeAllObjects];
    
    NSString * str = nil ;
    if(lb.numberOfLines == 1){
    
        lb.numberOfLines = 0;
        
        str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        [self.dict setObject:@"1" forKey:str];
        
        
    }else{
    
        lb.numberOfLines = 1;
        
        str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        [self.dict setObject:@"0" forKey:str];
    }
    
    [tableView endUpdates];
    
    /*
    // 我们以前刷新的时候都是用这个方法 其实还有其他方法
    [tableView reloadData];
    */
    
    // 这里介绍一下  beginUpdates 和endUpdates   这个动画是一帧一帧 的实现的
    /*
     1. beginUpdates方法和endUpdates方法是什么呢？
     这两个方法，是配合起来使用的，标记了一个tableView的动画块。
     分别代表动画的开始开始和结束。
     两者成对出现，可以嵌套使用。
     一般，在添加，删除，选择 tableView中使用，并实现动画效果。
     在动画块内，不建议使用reloadData方法，如果使用，会影响动画。
     
     如果我们的UITableView是分组的时候，我们如果删除某个分组的最后一条记录时，相应的分组也将被删除。所以，必须保证UITableView的分组，和cell同时被删除。
     所以，就需要使用beginUpdates方法和endUpdates方法，将要做的删除操作“包”起来。
     
     */
    
    
}


-(void)viewDidLayoutSubviews
{
  
    // tableView 的内外边距都为  UIEdgeInsetsZero
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 

    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
}


@end
