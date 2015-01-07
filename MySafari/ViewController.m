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
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@property int pageCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
    [self loadWebPage:@"http://butt.systems"];
    self.backButton.enabled = false;
    self.pageCount = 0;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loadWebPage:textField.text];
    self.backButton.enabled = true;
    return true;
}

-(void)loadWebPage:(NSString *)string
{
    NSURL *urlString = [NSURL URLWithString:string];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlString];
    [self.webView loadRequest:urlRequest];
    self.pageCount++;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.networkActivityIndicator.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.networkActivityIndicator.hidden = true;
}

- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
    self.pageCount--;
    if (self.pageCount == 0) {
        sender.enabled = NO;
    }
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}
- (IBAction)onStopLoadButtonPressed:(UIButton *)sender
{
    [self.webView stopLoading];
}

- (IBAction)onReloadButtonPressed:(UIButton *)sender
{
    [self.webView reload];
}



@end
