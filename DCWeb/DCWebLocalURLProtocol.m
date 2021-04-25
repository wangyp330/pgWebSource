//
//  DCWebLocalURLProtocol.m
//  DCUtilKit
//
//  Created by wangyp on 2021/4/14.
//  Copyright © 2021 zhangtao. All rights reserved.
//

#import "DCWebLocalURLProtocol.h"
@implementation DCWebLocalURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest*)request
{
    NSString *customScheme = [DCWebSourceScheme lowercaseString];
    if ([request.URL.scheme caseInsensitiveCompare:customScheme] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)request
{
    return request;
}

- (void)startLoading{
    NSString *customScheme = [DCWebSourceScheme lowercaseString];
    if ([self.request.URL.absoluteString containsString:customScheme]) {
        NSString *requestUrl = self.request.URL.absoluteString.lastPathComponent;
        NSString *resourcePath;
        NSString *mediaType = [requestUrl pathExtension];
        NSString *mimeType;
        if ([mediaType isEqualToString:@"png"]) {
            resourcePath=[NSString stringWithFormat:@"%@/Documents/images/%@",NSHomeDirectory(),requestUrl];
            mimeType = [NSString stringWithFormat:@"image/%@",mediaType];
        } else{
            resourcePath=[NSString stringWithFormat:@"%@/Documents/videos/%@",NSHomeDirectory(),requestUrl];
            mimeType = [NSString stringWithFormat:@"video/%@",mediaType];
        }

        NSData *data = [NSData dataWithContentsOfFile:resourcePath];
        
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[self.request URL]
                                                            MIMEType:mimeType
                                               expectedContentLength:data.length
                                                    textEncodingName:@"UTF-8"];
        [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [[self client] URLProtocol:self didLoadData:data];
        [[self client] URLProtocolDidFinishLoading:self];
    }
}

- (void)stopLoading{
    // stopLoading
}

@end
