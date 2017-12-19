//
//  ViewController.m
//  XYPickerViewDemo
//
//  Created by 叶炯 on 2017/12/18.
//  Copyright © 2017年 ixiyedev. All rights reserved.
//

#import "ViewController.h"
#import "XYPickerView.h"
#import "XYPickerTextField.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;

/** 姓名 */
@property (nonatomic, strong) XYPickerTextField *nameTF;
/** 性别 */
@property (nonatomic, strong) XYPickerTextField *genderTF;
/** 出生年月 */
@property (nonatomic, strong) XYPickerTextField *birthdayTF;
/** 出生时刻 */
@property (nonatomic, strong) XYPickerTextField *birthtimeTF;
/** 联系方式 */
@property (nonatomic, strong) XYPickerTextField *phoneTF;
/** 地区 */
@property (nonatomic, strong) XYPickerTextField *addressTF;
/** 学历 */
@property (nonatomic, strong) XYPickerTextField *educationTF;
/** 其它 */
@property (nonatomic, strong) XYPickerTextField *otherTF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    self.title = @"选择器选择";
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"testCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    NSString *title = [self.titleArr objectAtIndex:indexPath.row];
    if ([title hasPrefix:@"* "]) {
        NSMutableAttributedString *textStr = [[NSMutableAttributedString alloc]initWithString:title];
        [textStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[textStr string]rangeOfString:@"* "]];
        cell.textLabel.attributedText = textStr;
    } else {
        cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupNameTF:cell];
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupGenderTF:cell];
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupBirthdayTF:cell];
        }
            break;
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupBirthtimeTF:cell];
        }
            break;
        case 4:
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self setupPhoneTF:cell];
        }
            break;
        case 5:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupAddressTF:cell];
        }
            break;
        case 6:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupEducationTF:cell];
        }
            break;
        case 7:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [self setupOtherTF:cell];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (XYPickerTextField *)getTextField:(UITableViewCell *)cell {
    XYPickerTextField *textField = [[XYPickerTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark - 姓名 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入";
        _nameTF.returnKeyType = UIReturnKeyDone;
        _nameTF.tag = 0;
    }
}

#pragma mark - 性别 textField
- (void)setupGenderTF:(UITableViewCell *)cell {
    if (!_genderTF) {
        _genderTF = [self getTextField:cell];
        _genderTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _genderTF.tapAcitonBlock = ^{
            [XYStringPickerView showStringPickerWithTitle:@"宝宝性别" dataSource:@[@"男", @"女", @"其他"] defaultSelValue:@"男" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.genderTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 出生日期 textField
- (void)setupBirthdayTF:(UITableViewCell *)cell {
    if (!_birthdayTF) {
        _birthdayTF = [self getTextField:cell];
        _birthdayTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _birthdayTF.tapAcitonBlock = ^{
            [XYDatePickerView showDatePickerWithTitle:@"出生年月" dateType:UIDatePickerModeDate defaultSelValue:weakSelf.birthdayTF.text minDateStr:@"" maxDateStr:[weakSelf currentDateString] isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.birthdayTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 出生时刻 textField
- (void)setupBirthtimeTF:(UITableViewCell *)cell {
    if (!_birthtimeTF) {
        _birthtimeTF = [self getTextField:cell];
        _birthtimeTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _birthtimeTF.tapAcitonBlock = ^{
            [XYDatePickerView showDatePickerWithTitle:@"出生时刻" dateType:UIDatePickerModeTime defaultSelValue:weakSelf.birthtimeTF.text minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
                weakSelf.birthtimeTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 联系方式 textField
- (void)setupPhoneTF:(UITableViewCell *)cell {
    if (!_phoneTF) {
        _phoneTF = [self getTextField:cell];
        _phoneTF.placeholder = @"请输入";
        _phoneTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _phoneTF.returnKeyType = UIReturnKeyDone;
        _phoneTF.tag = 4;
    }
}

#pragma mark - 地址 textField
- (void)setupAddressTF:(UITableViewCell *)cell {
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _addressTF.tapAcitonBlock = ^{
            [XYAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
                NSDictionary *provinceDic = selectAddressArr[0];
                NSDictionary *cityDic = selectAddressArr[1];
                if (selectAddressArr.count == 3) {
                    NSDictionary *townDic = selectAddressArr[2];
                    weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@%@",provinceDic[@"provinceName"] ,cityDic[@"cityName"],townDic[@"townName"]];
                }else {
                    weakSelf.addressTF.text = [NSString stringWithFormat:@"%@%@",provinceDic[@"provinceName"] ,cityDic[@"cityName"]];
                    
                }
            }];
        };
    }
}

#pragma mark - 学历 textField
- (void)setupEducationTF:(UITableViewCell *)cell {
    if (!_educationTF) {
        _educationTF = [self getTextField:cell];
        _educationTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _educationTF.tapAcitonBlock = ^{
            [XYStringPickerView showStringPickerWithTitle:@"学历" dataSource:@[@"大专以下", @"大专", @"本科", @"硕士", @"博士", @"博士后"] defaultSelValue:@"本科" isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.educationTF.text = selectValue;
            }];
        };
    }
}

#pragma mark - 其它 textField
- (void)setupOtherTF:(UITableViewCell *)cell {
    if (!_otherTF) {
        _otherTF = [self getTextField:cell];
        _otherTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _otherTF.tapAcitonBlock = ^{
            NSArray *dataSources = @[@[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周", @"第6周", @"第7周"], @[@"第1天", @"第2天", @"第3天", @"第4天", @"第5天", @"第6天", @"第7天"]];
            [XYStringPickerView showStringPickerWithTitle:@"自定义多列字符串" dataSource:dataSources defaultSelValue:@[@"第3周", @"第3天"] isAutoSelect:YES resultBlock:^(id selectValue) {
                weakSelf.otherTF.text = [NSString stringWithFormat:@"%@，%@", selectValue[0], selectValue[1]];
            }];
        };
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0 || textField.tag == 4) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - 获取当前的时间
- (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 按指定格式获取当前的时间
- (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"* 姓名", @"* 性别", @"* 出生年月", @"   出生时刻", @"* 联系方式", @"* 地址", @"   学历", @"   其它"];
    }
    return _titleArr;
}



@end
