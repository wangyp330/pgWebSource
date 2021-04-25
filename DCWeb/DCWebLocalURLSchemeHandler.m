//
//  DCWebLocalURLSchemeHandler.m
//  DCUtilKit
//
//  Created by wangyp on 2021/4/12.
//  Copyright © 2021 zhangtao. All rights reserved.
//

#import "DCWebLocalURLSchemeHandler.h"

@implementation DCWebLocalURLSchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask API_AVAILABLE(ios(11.0)){
    NSURLRequest *request = urlSchemeTask.request;
    NSString *requestUlr = request.URL.absoluteString.lastPathComponent;
    NSString *mediaType = [request.URL.absoluteString pathExtension];
    NSURLResponse *response;
    NSData *data;
    NSString *mimeType;
    NSString *resourcePath=[NSString stringWithFormat:@"%@/Documents/images/%@",NSHomeDirectory(),requestUlr];
    if (![mediaType isEqualToString:@"png"]) {
        resourcePath = [NSString stringWithFormat:@"%@/Documents/videos/%@",NSHomeDirectory(),requestUlr];
    }
    
    if ([mediaType isEqualToString:@"png"]) {
        // 图片
        mimeType = [NSString stringWithFormat:@"image/%@",mediaType];
        UIImage *image=[[UIImage alloc]initWithContentsOfFile:resourcePath];
        data = UIImageJPEGRepresentation(image, 1.0);
        response = [[NSURLResponse alloc] initWithURL:nil MIMEType:mimeType expectedContentLength:data.length textEncodingName:nil];
    }
    
    if ([mediaType isEqualToString:@"png"]) {
        // 视频
        mimeType = [NSString stringWithFormat:@"video/%@",mediaType];
        data = [NSData dataWithContentsOfFile:resourcePath];
        response = [[NSURLResponse alloc] initWithURL:nil MIMEType:mimeType expectedContentLength:data.length textEncodingName:nil];
    }
    [urlSchemeTask didReceiveResponse:response];
    [urlSchemeTask didReceiveData:data];
    [urlSchemeTask didFinish];
}

- (void)webView:(WKWebView *)webVie stopURLSchemeTask:(id)urlSchemeTask {
    NSLog(@"urlSchemeTask=%@",urlSchemeTask);
}
@end
