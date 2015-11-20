//
//  ViewController.m
//  Tunnel
//
//  Created by LarryStanley on 2015/10/21.
//  Copyright © 2015年 LarryStanley. All rights reserved.
//

#import "ViewController.h"
#import "Colours.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // create background gradient
    UIColor *topColor = [UIColor colorFromHexString:@"#556BAF"];
    UIColor *bottomColor = [UIColor colorFromHexString:@"#5B9FCA"];
    
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:theViewGradient atIndex:0];

    // set scroll view
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mainScrollView];
    
    
    
    UILabel *estimateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    estimateTimeLabel.text = @"127";
    estimateTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:72.0f];
    [estimateTimeLabel sizeToFit];
    estimateTimeLabel.frame = CGRectMake(self.view.frame.size.width/2 - estimateTimeLabel.frame.size.width/2, 70, estimateTimeLabel.frame.size.width, estimateTimeLabel.frame.size.height);
    estimateTimeLabel.textColor = [UIColor whiteColor];
    [mainScrollView addSubview:estimateTimeLabel];
    
    UILabel *estimateMinuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    estimateMinuteLabel.text = @"分鐘";
    estimateMinuteLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18.0f];
    [estimateMinuteLabel sizeToFit];
    estimateMinuteLabel.frame = CGRectMake(self.view.frame.size.width/2 - estimateMinuteLabel.frame.size.width/2, estimateTimeLabel.frame.size.height + estimateTimeLabel.frame.origin.y - 30, estimateTimeLabel.frame.size.width, estimateTimeLabel.frame.size.height);
    estimateMinuteLabel.textColor = [UIColor whiteColor];
    [mainScrollView addSubview:estimateMinuteLabel];
    
    // set start and destination
    NSArray *places = @[@"南港", @"石碇", @"坪林", @"頭城"];
    UIScrollView *startScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, estimateMinuteLabel.frame.size.height + estimateMinuteLabel.frame.origin.y, self.view.frame.size.width/2, 60)];
    [startScrollView setPagingEnabled:YES];
    [startScrollView setShowsHorizontalScrollIndicator:NO];
    [startScrollView setShowsVerticalScrollIndicator:NO];
    [startScrollView setScrollsToTop:NO];
    [startScrollView setDelegate:self];
    startScrollView.tag = 0;
    
    int index = 0;
    for (NSString *place in places) {
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        placeLabel.text = place;
        placeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
        [placeLabel sizeToFit];
        placeLabel.frame = CGRectMake(index * self.view.frame.size.width/2, 0, self.view.frame.size.width/2, placeLabel.frame.size.height);
        placeLabel.textColor = [UIColor whiteColor];
        placeLabel.textAlignment = NSTextAlignmentCenter;
        [startScrollView addSubview:placeLabel];
        index++;
    }
    [startScrollView setContentSize:CGSizeMake( places.count * self.view.frame.size.width/2, 60)];
    
    startPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, startScrollView.frame.origin.y + 40, self.view.frame.size.width/2, 10)];
    [startPageControl setNumberOfPages:places.count];
    [startPageControl setCurrentPage:0];
    
    [mainScrollView addSubview:startScrollView];
    [mainScrollView addSubview:startPageControl];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"direction202.png"]];
    arrowView.frame = CGRectMake(self.view.frame.size.width/2 - 10, estimateMinuteLabel.frame.size.height + estimateMinuteLabel.frame.origin.y + 5, 20, 20);
    [mainScrollView addSubview:arrowView];
    
    // set start and destination
    UIScrollView *destinationScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake( self.view.frame.size.width/2, estimateMinuteLabel.frame.size.height + estimateMinuteLabel.frame.origin.y, self.view.frame.size.width/2, 60)];
    [destinationScrollView setPagingEnabled:YES];
    [destinationScrollView setShowsHorizontalScrollIndicator:NO];
    [destinationScrollView setShowsVerticalScrollIndicator:NO];
    [destinationScrollView setScrollsToTop:NO];
    [destinationScrollView setDelegate:self];
    destinationScrollView.tag = 1;
    
    destinyPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, startScrollView.frame.origin.y + 40, self.view.frame.size.width/2, 10)];
    [destinyPageControl setNumberOfPages:places.count];
    [destinyPageControl setCurrentPage:0];
    
    [mainScrollView addSubview:destinyPageControl];
    
    index = 0;
    for (NSString *place in places) {
        UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        placeLabel.text = place;
        placeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30];
        [placeLabel sizeToFit];
        placeLabel.frame = CGRectMake(index * self.view.frame.size.width/2, 0, self.view.frame.size.width/2, placeLabel.frame.size.height);
        placeLabel.textColor = [UIColor whiteColor];
        placeLabel.textAlignment = NSTextAlignmentCenter;
        [destinationScrollView addSubview:placeLabel];
        index++;
    }
    [destinationScrollView setContentSize:CGSizeMake( places.count * self.view.frame.size.width/2, 60)];
    
    [mainScrollView addSubview:destinationScrollView];

    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    noteLabel.text = @"目前車流擁擠，建議一小時後再出發";
    noteLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
    [noteLabel sizeToFit];
    noteLabel.frame = CGRectMake(self.view.frame.size.width/2 - noteLabel.frame.size.width/2, destinationScrollView.frame.size.height + destinationScrollView.frame.origin.y + 5, noteLabel.frame.size.width, noteLabel.frame.size.height);
    noteLabel.textColor = [UIColor whiteColor];
    [mainScrollView addSubview:noteLabel];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 20, noteLabel.frame.size.height + noteLabel.frame.origin.y + 10, self.view.frame.size.width - 40, 0.5)];
    line.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:line];
    
    NSArray *predictData = @[@"半小時\n120", @"一小時\n90", @"兩小時\n115", @"三小時\n110"];
    index = 0;
    float predictLabelY = 0;
    for (NSString *predictString in predictData) {
        UILabel *predictLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        predictLabel.text = predictString;
        predictLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        predictLabel.numberOfLines = 0;
        [predictLabel sizeToFit];
        predictLabel.frame = CGRectMake(index * self.view.frame.size.width/4, line.frame.origin.y + line.frame.size.height + 10, self.view.frame.size.width/4, predictLabel.frame.size.height);
        predictLabel.textColor = [UIColor whiteColor];
        predictLabel.textAlignment = NSTextAlignmentCenter;
        [mainScrollView addSubview:predictLabel];
        index++;
        predictLabelY = predictLabel.frame.size.height + predictLabel.frame.origin.y;
    }
    
    UILabel *busLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    busLabel.text = @"大眾運輸方案";
    busLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
    busLabel.textColor = [UIColor whiteColor];
    [busLabel sizeToFit];
    busLabel.frame = CGRectMake(self.view.frame.size.width/2 - busLabel.frame.size.width/2, predictLabelY + 30, busLabel.frame.size.width, busLabel.frame.size.height);
    [mainScrollView addSubview:busLabel];
    
    // set overal label
    /*UILabel *overAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    overAllLabel.text = @"總結";
    overAllLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26.0f];
    [overAllLabel sizeToFit];
    overAllLabel.frame = CGRectMake(self.view.frame.size.width/2 - overAllLabel.frame.size.width/2, 30, overAllLabel.frame.size.width, overAllLabel.frame.size.height);
    overAllLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:overAllLabel];
    
    UILabel *rightNowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    rightNowLabel.text = @"目前雪隧狀況";
    rightNowLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    [rightNowLabel sizeToFit];
    rightNowLabel.frame = CGRectMake(10, self.view.frame.size.height/5*3, rightNowLabel.frame.size.width, rightNowLabel.frame.size.height);
    rightNowLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:rightNowLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 10, rightNowLabel.frame.size.height + rightNowLabel.frame.origin.y + 5, self.view.frame.size.width/5 * 3, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:line];
    
    UILabel *northSpeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    northSpeedLabel.text = @"64";
    northSpeedLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:44.0f];
    [northSpeedLabel sizeToFit];
    northSpeedLabel.frame = CGRectMake(10, line.frame.size.height + line.frame.origin.y + 5, northSpeedLabel.frame.size.width, northSpeedLabel.frame.size.height);
    northSpeedLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:northSpeedLabel];
    
    UILabel *northUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    northUnitLabel.text = @"北上\nkm/hr";
    northUnitLabel.numberOfLines = 0;
    northUnitLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16];
    [northUnitLabel sizeToFit];
    northUnitLabel.frame = CGRectMake( northSpeedLabel.frame.size.width + northSpeedLabel.frame.origin.x + 5, northSpeedLabel.frame.size.height + northSpeedLabel.frame.origin.y - northUnitLabel.frame.size.height, northUnitLabel.frame.size.width, northUnitLabel.frame.size.height);
    northUnitLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:northUnitLabel];
    
    UILabel *southSpeedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    southSpeedLabel.text = @"56";
    southSpeedLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:44.0f];
    [southSpeedLabel sizeToFit];
    southSpeedLabel.frame = CGRectMake(northUnitLabel.frame.size.width + northUnitLabel.frame.origin.x + 10, line.frame.size.height + line.frame.origin.y + 5, southSpeedLabel.frame.size.width, southSpeedLabel.frame.size.height);
    southSpeedLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:southSpeedLabel];
    
    UILabel *southUnitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    southUnitLabel.text = @"南下\nkm/hr";
    southUnitLabel.numberOfLines = 0;
    southUnitLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16];
    [southUnitLabel sizeToFit];
    southUnitLabel.frame = CGRectMake( southSpeedLabel.frame.size.width + southSpeedLabel.frame.origin.x + 5, southSpeedLabel.frame.size.height + southSpeedLabel.frame.origin.y - southUnitLabel.frame.size.height, southUnitLabel.frame.size.width, southUnitLabel.frame.size.height);
    southUnitLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:southUnitLabel];

    UILabel *estimateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    estimateTextLabel.text = @"目前位置抵達宜蘭預估時間";
    estimateTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18.0f];
    [estimateTextLabel sizeToFit];
    estimateTextLabel.frame = CGRectMake(10, southSpeedLabel.frame.size.height + southSpeedLabel.frame.origin.y + 20, estimateTextLabel.frame.size.width, estimateTextLabel.frame.size.height);
    estimateTextLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:estimateTextLabel];
    
    UILabel *estimateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    estimateTimeLabel.text = @"127";
    estimateTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:72.0f];
    [estimateTimeLabel sizeToFit];
    estimateTimeLabel.frame = CGRectMake(10, estimateTextLabel.frame.size.height + estimateTextLabel.frame.origin.y + 10, estimateTimeLabel.frame.size.width, estimateTimeLabel.frame.size.height);
    estimateTimeLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:estimateTimeLabel];
    
    UILabel *estimateMinuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    estimateMinuteLabel.text = @"分鐘";
    estimateMinuteLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18.0f];
    [estimateMinuteLabel sizeToFit];
    estimateMinuteLabel.frame = CGRectMake(estimateTimeLabel.frame.size.width + estimateTimeLabel.frame.origin.x + 10, estimateTimeLabel.frame.size.height + estimateTimeLabel.frame.origin.y - estimateMinuteLabel.frame.size.height - 10, estimateMinuteLabel.frame.size.width, estimateMinuteLabel.frame.size.height);
    estimateMinuteLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:estimateMinuteLabel];*/
}

#pragma mark - All about scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat width = scrollView.frame.size.width;
    NSInteger currentPage = ((scrollView.contentOffset.x - width / 2) / width) + 1;

    if (scrollView.tag) {
        [destinyPageControl setCurrentPage:currentPage];
    } else {
        [startPageControl setCurrentPage:currentPage];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
