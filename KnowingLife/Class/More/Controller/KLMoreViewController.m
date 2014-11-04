//
//  KLMoreViewController.m
//  KnowingLife
//
//  Created by tanyang on 14/10/28.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLMoreViewController.h"
#import "RETableViewManager.h"
#import "MBProgressHUD+MJ.h"
#import <MessageUI/MessageUI.h>
#import "AboutViewController.h"
#import "KLWeatherInfo.h"
#import "WeatherViewController.h"

@interface KLMoreViewController ()<RETableViewManagerDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) RETableViewManager *manager;
@end

#define SectionHeaderHeight 42
#define SectionFooterHeight 0.5

@implementation KLMoreViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //NSLog(@"%@",self.weatherInfo);
    // 创建RETableViewManager管理类
    self.manager = [[RETableViewManager alloc]initWithTableView:self.tableView delegate:self];
    self.manager.style.cellHeight = 36;
    // 选中不显示高亮
    //self.manager.style.defaultCellSelectionStyle = UITableViewCellSelectionStyleNone;
    // 创建第一组
    [self addSectionOne];
    
    // 创建系统设置组
    [self addSectionSetting];
    
    // 创建意见反馈
    [self addSectionSuggest];
    
    // 创建关于
    [self addSectionAbout];
}

- (void)addSectionOne
{
    // 创建一个组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight/2;
    section.footerHeight = SectionFooterHeight;
    
    __typeof (self) __weak selfVc = self;
    // 创建组中的条目
    RETableViewItem *item = [RETableViewItem itemWithTitle:@"检查更新" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:selfVc.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"检查更新中...";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"没有更新！";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:selfVc.view animated:YES];
            });
            
        });
    }];
    item.image = [UIImage imageNamed:@"plugin_icon_offline"];
    [section addItem:item];
    
}

- (void)addSectionSetting
{
    // 创建一个组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    section.headerTitle = @"系统设置";
    
    __typeof (self) __weak selfVc = self;
    // 创建组中的条目
    RETableViewItem *cleanItem = [RETableViewItem itemWithTitle:@"清除缓存" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        // 显示清除缓存
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:selfVc.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"清除缓存中...";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            // 清除缓存
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSUInteger fileCount = [files count];
            //NSLog(@"files :%ld",[files count]);
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                }
            }
            
            hud.mode = MBProgressHUDModeText;
            hud.labelText = [NSString stringWithFormat:@"清除缓存文件%ld个!",fileCount];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                // Do something...
                [MBProgressHUD hideHUDForView:selfVc.view animated:YES];
            });
            
        });
    }];
    
    cleanItem.image = [UIImage imageNamed:@"plugin_icon_setting"];
    [section addItem:cleanItem];
    
    // 创建第二个条目
    NSString *city = @"深圳";
    if (self.weatherInfo) {
        KLWeatherData *weatherData = self.weatherInfo.weather_data[0];
        city = [NSString stringWithFormat:@"%@   %@   %@",self.weatherInfo.currentCity,weatherData.temperature, weatherData.weather];
    }
    __typeof (self) __weak weakSelf = self;
    RETableViewItem *weatherItem = [RETableViewItem itemWithTitle:city accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        WeatherViewController *weatherCtl = [[WeatherViewController alloc]init];
        weatherCtl.weatherInfo = self.weatherInfo;
        [weakSelf.navigationController pushViewController:weatherCtl animated:YES];
    }];
    
    weatherItem.image = [UIImage imageNamed:@"plugin_icon_weather"];
    [section addItem:weatherItem];
    
    REBoolItem *location = [REBoolItem itemWithTitle:@"定位" value:NO switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    location.image = [UIImage imageNamed:@"plugin_icon_setting"];
    [section addItem:location];
}

- (void)addSectionSuggest
{
    // 创建一个组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    section.headerTitle = @"反馈建议";
    
    __typeof (self) __weak weakSelf = self;
    // 创建组中的条目 打分
    RETableViewItem *scoreItem = [RETableViewItem itemWithTitle:@"评价打分" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        
    }];
    scoreItem.image = [UIImage imageNamed:@"plugin_icon_star"];
    [section addItem:scoreItem];
    
    // 建议
    RETableViewItem *suggestItem = [RETableViewItem itemWithTitle:@"问题与建议" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [weakSelf sendEMail];
    }];
    suggestItem.image = [UIImage imageNamed:@"plugin_icon_mailbox"];
    [section addItem:suggestItem];
}

- (void)addSectionAbout
{
    // 创建一个组
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    section.headerHeight = SectionHeaderHeight;
    section.footerHeight = SectionFooterHeight;
    section.headerTitle = @"关于我们";
    
    __typeof (self) __weak weakSelf = self;
    // 创建组中的条目 打分
    RETableViewItem *AboutItem = [RETableViewItem itemWithTitle:@"关于" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        AboutViewController *aboutCtr = [[AboutViewController alloc]init];
        aboutCtr.title = @"关于";
        [weakSelf.navigationController pushViewController:aboutCtr animated:YES];
    }];
    
    AboutItem.image = [UIImage imageNamed:@"plugin_icon_star"];
    [section addItem:AboutItem];
}

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

// 发送邮件
-(void)sendEMail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见反馈"];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: @"122074809@qq.com"];
    //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
    [mailPicker setToRecipients: toRecipients];
    //[picker setCcRecipients:ccRecipients];
    //[picker setBccRecipients:bccRecipients];
    
    // 添加图片
    //UIImage *addPic = [UIImage imageNamed: @"123.jpg"];
    //NSData *imageData = UIImagePNGRepresentation(addPic);            // png
    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg
    //[mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"123.jpg"];
    
    NSString *emailBody = @"\r\n\r\n ～来自我的iPhone";
    [mailPicker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:mailPicker animated:YES completion:nil];
}

// 转到系统邮件
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

// 邮件发送返回
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
