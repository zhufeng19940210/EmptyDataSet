//  HomeViewController.m
//  TestDemo
//  Created by bailing on 2018/4/17.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "HomeViewController.h"
#import "UIScrollView+EmptyDataSet.h"
@interface HomeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetDelegate,
    DZNEmptyDataSetSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)BOOL loading;
@end
@implementation HomeViewController
-(void)setLoading:(BOOL)loading{
    if (self.loading == loading) {
        return;
    }
    _loading = loading;
    
    [self.tableView reloadEmptyDataSet];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EmpyData示例";
    //seutpTableView
    [self setupTableView];
}
-(void)setupTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 删除单元格分割线的小技巧
    self.tableView.tableFooterView = [UIView new];
}
#pragma mark -- UITableViewDelegate | UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity  = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.textLabel.text = @"";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- DZNEmptyDataSetDelegate
/*
 1.如果你想返回状态显示的内容,并且充分利用NSAttributedString的功能去实现这个功能
 */
/*
 1.空白页显示图片
 */
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_dropbox"];
}
/*
 2.空白页显示标题
 */
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *tittle = @"当前的内容为空";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    return [[NSAttributedString alloc]initWithString:tittle attributes:attributes];
}
/*
 3.空白页显示详细描述
 */
-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"你好，我的名字叫做辛巴，大草原是我的家";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode =  NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:[UIColor grayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}
/*
 4.空白页显示按钮
 */
-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *butotnTitle = @"喜欢我就点点点我";
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:15]
                                 };
    return [[NSAttributedString alloc]initWithString:butotnTitle attributes:attributes];
}
/*
 5.把指定按钮设置成图片
 */
-(UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    return [UIImage imageNamed:@"placeholder_dropbox"];
}
/*
 6.设置图片的titntColor
 */
-(UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor yellowColor];
}
/*
 7.设置空白页面的背景颜色
 */
-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    UIColor *appleGreenColor = [UIColor colorWithRed:199/255.0 green:237/255.0 blue:204/255.0 alpha:1.0];
    return appleGreenColor;
}
/*
 8.如果是复杂的界面
 */
//-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIActivityIndicatorView *activitiyView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [activitiyView startAnimating];
//    return activitiyView;
//}
/*
  10.图形视图动画
 */
/*
#pragma mark  ---DZEmptyDataSetDSource
#pragma mark - DZNEmptyDataSetSource
#pragma mark 空白页显示图片
- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"lion"];
}

#pragma mark 图像视图动画: 旋转
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

#pragma mark - DZNEmptyDataSetDelegate
// 向代理请求图像视图动画权限。 默认值为NO。
// 确保从 imageAnimationForEmptyDataSet 返回有效的CAAnimation对象：
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}
*/
/*
 图像瑟视图动画: 缩放
 */
/*
#pragma mark - DZNEmptyDataSetSource
#pragma mark 空白页显示图片
- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"computer"];
}

#pragma mark 图像视图动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = 1.25;
    animation.cumulative = NO;
    animation.repeatCount = MAXFLOAT;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 45, 45)];
    
    return animation;
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}
*/
#pragma mark -- DZNEmptyDataSetSource
/*
 1.空白视图默认情况是一张静态图片,当用户点击静止图片,然后实现的功能是的定义了一个bol
 */
#pragma mark-- 空白页显示图片
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.loading) {
        //图片加载图片
        return [UIImage imageNamed:@""];
    }else{
        //默认是静止的图片
        return [UIImage imageNamed:@""];
    }
}
#pragma mark -- 图片旋转动画
-(CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}
#pragma mark --  DZNEmptyDataSetDelegate
#pragma mark -- 是否开启动画
-(BOOL )emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.loading;
}
#pragma mark --空白页面被点击时候刷新页面
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    //空白页面被点击时候开启动画，reloadEemptyDataSet
    self.loading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_main(), ^{
        self.loading = NO;
    });
}
-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64;
}
/*
 最后，将组件彼此上下分离
 */
-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 25.0f;
}
#pragma mark -- 实现代理
/*
 1.是否应该呈现和显示空白页面 (默认是YES)
 */

-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
/*
 2.请求代理空数据在显示时应该淡入 (默认是YES)
 */
-(BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView
{
    return YES;
}
/*
 3.强制电视空数据集:当项目数量大于0时,请求代理是否应该显示空数结合
 */
-(BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView
{
    return YES;
}
/*
 4.获取允许交互模式(默认是YES)
 */
-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return  YES;
}
/*
 5.获取允许滚动权限 (默认是NO)
 */
-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

/*
 6.获取允图像动画权限 (默认值为NO)
 */
-(BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}
/*
 7.空白数据集,视图被点击是触发的方法
 */
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"didTapView 点击的方法");
}
/*
 8.空白数据集,按钮点击时候触发的方法
 */
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"didTapButton 点击的方法");
}
/*
 9.空白页将要出现
 */
-(void)emptyDataSetWillAppear:(UIScrollView *)scrollView
{
    NSLog(@"空白页将要出现");
}
/*
 10.空白页已经出现
 */
-(void)emptyDataSetDidAppear:(UIScrollView *)scrollView
{
    NSLog(@"空白页已经出现");
}
/*
 11.空白页将要消失
 */
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView{
    
    NSLog(@"空白页将要消失");
}
/*
 12.空白页已经消失
 */
-(void)emptyDataSetDidDisappear:(UIScrollView *)scrollView
{
    NSLog(@"空白页已经消失");
}
/*
 刷新布局
 */
-(void)reloadData
{
    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
