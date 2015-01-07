//
//  ViewController.m
//  MySafari
//
//  Created by Gabriel Borri de Azevedo on 1/7/15.
//  Copyright (c) 2015 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    self.urlTextField.delegate = self;

    [self loadWebPage:@"http://butt.systems"];
    self.backButton.enabled = false;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text hasPrefix:@"http://"]) {
        NSString *httpString = @"http://";
        NSString *correctedString = [httpString stringByAppendingString:textField.text];
        [self loadWebPage:correctedString];
    }
    else
    {
        [self loadWebPage:textField.text];
    }
    self.backButton.enabled = true;
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
    if (![self.webView canGoBack]) {
        self.backButton.enabled = NO;
    }
    if ([self.webView canGoBack]) {
        self.backButton.enabled = YES;
    }
    if (![self.webView canGoForward]) {
        self.forwardButton.enabled = NO;
    }
    if ([self.webView canGoForward]) {
        self.forwardButton.enabled = YES;
    }

}

- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
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

- (IBAction)onAddButtonPressed:(UIButton *)sender
{
    UIAlertView *alert = [UIAlertView new];
    alert.delegate = self;
    alert.title = @"Coming soon!";
    [alert addButtonWithTitle:@"Dismiss"];
    [alert show];
}



@end
