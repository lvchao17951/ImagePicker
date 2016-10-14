//
//  ViewController.m
//  ImagePicker
//
//  Created by 吕超 on 16/10/11.
//  Copyright © 2016年 吕超. All rights reserved.
//

#import "ViewController.h"
#import "ImageTableViewCell.h"
#import "UserMessageTableViewCell.h"
#import "WeiChatAccountTableViewCell.h"

// 需要 "UIImagePickerControllerDelegate" 和 "UIImagePickerControllerDelegate" 代理
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titileLabel;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) ImageTableViewCell *cell;

@end

@implementation ViewController

/*   
 *   @ UITableView 的相关问题:
 *   @ 如果想去掉 UITableView 的 SectionHeader 粘性
 
 *   @ 方法一: 
 *   @ 使用 UITableViewStyleGrouped
 *   @ 使用 UITableViewStyleGrouped 时, 需要注意代码顺序, 否则会导致第一个 SectionHeader 的默认高度不会改变
 *   @ 即: 将签代理 放到 隐藏多余分割线之前
           _tableView.delegate = self;
           _tableView.dataSource = self;
           _tableView.tableFooterView = [[UIView alloc] init];
 
 *   @ 方法二:
 *   @ 使用 UITableViewStylePlain
 *   @ 使用 UITableViewStylePlain 或者其它 style 时, 需要在 ScrollView 的代理方法中设置
 */

// 懒加载 UITableView
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

// 懒加载 UIAlertController
- (UIAlertController *)alertController
{
    if (_alertController == nil)
    {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [_alertController addAction:cancelAction];
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
        {
            [self takePhotoActionMethod];
        }];
        [_alertController addAction:takePhotoAction];
        
        UIAlertAction *localPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [self localPhotoActionMethod];
        }];
        [_alertController addAction:localPhotoAction];
    }
    return _alertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", NSHomeDirectory());
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    [self setUpNavigation];
}

// 自定义导航栏样式
- (void)setUpNavigation
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.12 alpha:1.0];
    
    self.titileLabel = [[UILabel alloc] init];
    self.titileLabel.frame = CGRectMake(0, 0, 72, 35);
    self.titileLabel.text = @"个人信息";
    self.titileLabel.font = [UIFont systemFontOfSize:18];
    self.titileLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.titileLabel;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 5;
    }
    else
    {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 66.f;
    }
    else
    {
        return 44.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dentifier = @"Cell";
    static NSString *dentifierOne = @"Cell";
    static NSString *dentifierTwo = @"Cell";
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        self.cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
        if (self.cell == nil)
        {
            self.cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dentifier];
        }
        
        self.cell.nameLabel.text = @"头像";
        
        self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return self.cell;

    }
    else if ((indexPath.section == 0 && indexPath.row != 2) || indexPath.section == 1)
    {
        UserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifierOne];
        if (cell == nil)
        {
            cell = [[UserMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifierOne];
        }
        
        
        if (indexPath.section == 0 && indexPath.row == 1)
        {
            cell.nameLabel.text = @"名字";
            cell.detialLabel.text = @"y1、刀";
        }
        else if (indexPath.section == 0 && indexPath.row == 3)
        {
            cell.nameLabel.text = @"我的二维码";
        }
        else if (indexPath.section == 0 && indexPath.row == 4)
        {
            cell.nameLabel.text = @"我的地址";
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            cell.nameLabel.text = @"性别";
            cell.detialLabel.text = @"男";
        }
        else if (indexPath.section == 1 && indexPath.row == 1)
        {
            cell.nameLabel.text = @"地区";
            cell.detialLabel.text = @"冰岛";
        }
        else
        {
            cell.nameLabel.text = @"个性签名";
            cell.detialLabel.text = @"未填写";
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    else
    {
        WeiChatAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifierTwo];
        if (cell == nil)
        {
            cell = [[WeiChatAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dentifierTwo];
        }
        
        cell.nameLabel.text = @"微信号";
        cell.detialLabel.text = @"lvchao0681";
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        [self presentViewController:self.alertController animated:YES completion:nil];
    }
}

/*  
 *   @ iOS 10 问题:
 *   @ 在 info.plist 中加入:
 *   @ Privacy - Camera Usage Description (相机)
 *   @ Privacy - Photo Library Usage Description (相册)
 */

- (void)takePhotoActionMethod
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)localPhotoActionMethod
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

// 拿到照片之后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    self.cell.iconImage.image = image;
    
    // 将照片存到相册中
    if (_imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self saveImage:image];
}

// 判断保存相册是否成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil)
    {
        NSLog(@"保存成功");
    }
    else
    {
        NSLog(@"保存失败");
    }
}

// 保存本地
- (void)saveImage:(UIImage *)image
{
    NSString *pathStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"imageData"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [imageData writeToFile:pathStr atomically:NO];
    NSLog(@"%@", pathStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
