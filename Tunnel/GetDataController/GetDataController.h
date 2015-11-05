//
//  GetDataController.h
//  Tunnel
//
//  Created by LarryStanley on 2015/11/4.
//  Copyright © 2015年 LarryStanley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class GetDataController;
@protocol GetDataControllerDelegate <NSObject>

@optional
- (void) getDataController:(GetDataController *)controller didFinishReceiveData:(NSDictionary *)receiveData;

@end

@interface GetDataController : NSObject
{
    NSString *baseURL;
    NSMutableArray *finalData;
}

@property (nonatomic, weak) id <GetDataControllerDelegate> delegate;
@property (nonatomic, strong) NSString *serverLocation;

- (void)getData:(NSURL *)URL;

@end
