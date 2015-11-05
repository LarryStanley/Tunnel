//
//  ViewController.h
//  Tunnel
//
//  Created by LarryStanley on 2015/10/21.
//  Copyright © 2015年 LarryStanley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetDataController.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
    UIPageControl *startPageControl;
    UIPageControl *destinyPageControl;
    UITableView *estimateTableView;
}

@end

