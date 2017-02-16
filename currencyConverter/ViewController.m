//
//  ViewController.m
//  currencyConverter
//
//  Created by SnehaPriya Ale on 1/4/17.
//  Copyright © 2017 snehapriyaale. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputCurrency;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencyOption;
@property (weak, nonatomic) IBOutlet UILabel *resultCurrency;

@property (strong, nonatomic) CRCurrencyRequest *request;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableDictionary *dinnerRequest = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"Breakfast":@"Bread",
                                                                                  @"Lunch":@"Chapati",
                                                                                  @"Dinner":@"Rice"
                                                                                  }];
    
    [dinnerRequest enumerateKeysAndObjectsUsingBlock:
     ^(id key, id value,BOOL *stop){
         NSLog(@"%@:%@",key,value);
     }];
    
    NSArray *dinner = @[@"Breakfast",@"Bread",
                        @"Lunch",@"Chapati",
                        @"Dinner",@"Rice"];
    [dinner enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isEqualToString:@"Chapati"]){
            *stop = YES;
        }else{
            NSLog(@"%@",obj);
        }
    }];
    void (^myBlock)(id,NSUInteger,BOOL *);
    myBlock = ^(id Obj,NSUInteger idx, BOOL *stop){
        if([Obj isEqualToString:@"Chapati"]){
            *stop = YES;
        }else{
            NSLog(@"%@",Obj);
    }
    };
        [dinner enumerateObjectsUsingBlock:myBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickConvert:(id)sender {
//    self.convertButton.enabled = NO;
//    self.request = [CRCurrencyRequest alloc];
//    self.request.delegate = self;
//    [self.request start];
}

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies {
    self.convertButton.enabled = YES;
    double input = [self.inputCurrency.text doubleValue];
    if(input){
        
        self.resultCurrency.text = [NSString stringWithFormat:@"%.2lf",[self convertTo:input :self.currencyOption.selectedSegmentIndex :currencies] ] ;
    }else{
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error!"
                                     message:@"Please enter a valid number"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okButton = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
     //   NSLog(@"Please enter number as Input.");
    }

}

- (double) convertTo :(double) inputValue : (NSInteger) selectedIndex : (CRCurrencyResults *)currencies {
    switch (selectedIndex) {
        case 0:
            return inputValue * currencies.INR;
            break;
        case 1:
            return inputValue * currencies.GBP;
            break;
        case 2:
            return inputValue * currencies.EUR;
            break;
            
        default:
            return 0.0;
            break;
    }

}

@end
