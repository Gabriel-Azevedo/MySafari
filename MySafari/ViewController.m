//
//  ViewController.m
//  MySafari
//
//  Created by Gabriel Borri de Azevedo on 1/7/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loadWebPage:textField.text];
    return true;
}

-(void)loadWebPage:(NSString *)string
{
    NSURL *urlString = [NSURL URLWithString:string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlString];
    [self.webView loadRequest:urlRequest];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.networkActivityIndicator.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.networkActivityIndicator.hidden = true;
}



@end
