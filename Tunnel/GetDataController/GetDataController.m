//
//  GetDataController.m
//  Tunnel
//
//  Created by LarryStanley on 2015/11/4.
//  Copyright © 2015年 LarryStanley. All rights reserved.
//

#import "GetDataController.h"

@implementation GetDataController



- (void)getData:(NSURL *)URL{
    __block NSDictionary *results;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        results = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)responseObject];
        [_delegate getDataController:self didFinishReceiveData:results];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate getDataController:self didFinishReceiveData:results];
    }];
    [operation start];
}

- (void)getFinalData {
    [self getData:[NSURL URLWithString:baseURL]];
}

@end
