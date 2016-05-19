//
//  ViewController.m
//  UIDemo
//
//  Created by YU on 16/4/19.
//  Copyright © 2016年 YU. All rights reserved.
//

#import "ViewController.h"
#import "RSAUtil.h"
#import "EncryptionKeys.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *MtextField;
@property (weak, nonatomic) IBOutlet UITextView *eCTextView;
@property (weak, nonatomic) IBOutlet UITextView *deCTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)encrytionButton:(UIButton *)sender {
    if (_MtextField.text.length <= 0) {
        return;
    }
    
    NSDictionary *dic = @{@"user":@"yu",
                          @"age":@25
                          };
    
    NSLog(@"%@",dic);
    
    NSString *e_str = [RSAUtil encryptString:_MtextField.text publicKey:RSA_Public_key];
    if (e_str) {
        self.eCTextView.text = e_str;
    }else{
        self.eCTextView.text = @"加密出错";
    }
    
}
- (IBAction)deEcryption:(UIButton *)sender {
    
//    if (_eCTextView.text.length <= 0) {
//        return;
//    }
    NSString *d_str = [RSAUtil decryptString:_eCTextView.text privateKey:RSA_Private_key];
    if (d_str) {
        self.deCTextView.text = d_str;
    }else{
        self.deCTextView.text = @"加密出错";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
