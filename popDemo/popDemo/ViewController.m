//
//  ViewController.m
//  popDemo
//
//  Created by 刘长洋 on 2019/8/28.
//  Copyright © 2019 刘长洋. All rights reserved.
//

#import "ViewController.h"

#import "BDModel.h"

#import "BDPopViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *doorArray;

//定位移动的Y
@property (nonatomic, assign) float offy;
//定位UIbutton tag
@property (nonatomic, assign) int postTag;

@end

@implementation ViewController

#pragma mark - System

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.doorArray = [[NSMutableArray alloc] init];
    
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [sv setBackgroundColor:[UIColor whiteColor]];
    [sv setShowsVerticalScrollIndicator:NO];
    [sv setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:sv];
    self.scrollView = sv;
    
    for (int i = 0; i < 20; i++)
    {
        DoorRecordModel *model = [DoorRecordModel safeWithDic:nil];
        model.name = [NSString stringWithFormat:@"%d",i];
        model.remote = 1;
        model.bluetooth = 1;
        model.qrCode = 1;
        [self.doorArray addObject:model];
    }
    
    [self initView];
    
}


- (void)initView
{
    float offy = 40;
    float space = (10);
    float w = (self.view.bounds.size.width - 20 - space*4)/3;
    float h = (self.view.bounds.size.width - 20 - space*4)/3;
    
    for (int i = 0; i < [self.doorArray count]; i++)
    {
        DoorRecordModel *model = [self.doorArray objectAtIndex:i];
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setFrame:CGRectMake(20 + (w + space)*(i%3),offy + (h + space)*(i/3), w, h)];
        [btn setImage:[UIImage imageNamed:@"door_lock"] forState:UIControlStateNormal];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
        [btn setTag:i];
        [btn addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    float offH = (10) + (10) + (20) + (10) + 1;
    
    offH += (((self.view.bounds.size.width - (20)) - (10)*4)/3 + (10)) * (([self.doorArray count] % 3 == 0)?([self.doorArray count] / 3):(1 + [self.doorArray count] / 3));
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, offH + (20))];
}



#pragma mark - LoadView

- (void)lockAction:(UIButton *)btn
{
    self.postTag = (int)btn.tag;
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    CGRect start = [btn convertRect:btn.bounds toView:win];
    [self location:start row:btn.tag];
}

#pragma mark - ViewAction

- (void)location:(CGRect)farme row:(NSInteger)row
{
    DoorRecordModel *recordModel = [self.doorArray objectAtIndex:row];
    
    NSLog(@"为了计算X轴和Y轴：%f%f",farme.origin.x,farme.origin.y);
    
    float offW = ((self.view.bounds.size.width - (20)) - (10)*4)/3;
    
    int number = (int)row % 3;
    
    UIView *bgV = [[UIView alloc] init];
    [bgV setBackgroundColor:[UIColor clearColor]];
    [bgV setUserInteractionEnabled:YES];
    
    BOOL isunder = NO;
    
    if (farme.origin.y > [[UIScreen mainScreen] bounds].size.height/2)
    {
        isunder = YES;
    }
    else
    {
        isunder = NO;
    }
    
    if (isunder)
    {
        UIImage *img = [UIImage imageNamed:@"ico_arrows_unfold"];
        //远程
        if ((recordModel.remote == 1) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+二维码
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - offW * 2 + 1)/2, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+蓝牙
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - offW * 2 + 1)/2, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+二维码+蓝牙
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/3 - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - offW * 3 + 2)/2, farme.origin.y - offW + (35), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 3 + 2), farme.origin.y - offW + (35), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/3*2 + (bgV.bounds.size.width/3 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW * 2 + 1, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW * 2 + 2, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //二维码
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //二维码+蓝牙
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - offW * 2 + 1)/2, farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y - offW + (35), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //蓝牙
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y - offW + (35), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, bgV.bounds.size.height - imgV.image.size.height, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
    }
    else
    {
        UIImage *img = [UIImage imageNamed:@"lock_choose"];
        //远程
        if ((recordModel.remote == 1) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+二维码
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - (offW * 2 + 1))/2, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+蓝牙
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - (offW * 2 + 1))/2, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //远程+二维码+蓝牙
        else if ((recordModel.remote == 1) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/3 - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - offW * 3 + 2)/2, farme.origin.y + offW - (15), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 3 + 2), farme.origin.y + offW - (15), offW * 3 + 2, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/3 * 2 + (bgV.bounds.size.width/3 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"key_door"] forState:UIControlStateNormal];
                [btn setTitle:@"一键开门" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW * 2 + 1, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW * 2 + 2, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //二维码
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 0) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //二维码+蓝牙
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 1))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake(((bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake((self.view.bounds.size.width - (offW * 2 + 1))/2, farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(self.view.bounds.size.width - (20) - (offW * 2 + 1), farme.origin.y + offW - (15), offW * 2 + 1, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width/2 + (bgV.bounds.size.width/2 - imgV.image.size.width)/2), 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"code_door"] forState:UIControlStateNormal];
                [btn setTitle:@"二维码" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
            {
                UIView *lineV = [[UIView alloc] init];
                [lineV setFrame:CGRectMake(offW, (20), 1, view.bounds.size.height - (40))];
                [lineV setBackgroundColor:[UIColor whiteColor]];
                [view addSubview:lineV];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(offW + 1, 0, offW, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
        //蓝牙
        else if ((recordModel.remote == 0) && (recordModel.bluetooth == 1) && (recordModel.qrCode == 0))
        {
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV setBackgroundColor:[UIColor clearColor]];
            [imgV setImage:img];
            [bgV addSubview:imgV];
            
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:[UIColor blackColor]];
            [view setUserInteractionEnabled:YES];
            [bgV addSubview:view];
            {
                [self bd_loadShadowWithView:view ShadowOpacity:0.5 ShadowRadius:5 CornerRadius:5];
            }
            if (number == 0)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 1)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            else if (number == 2)
            {
                [bgV setFrame:CGRectMake(farme.origin.x, farme.origin.y + offW - (15), offW, img.size.height + (80))];
                [imgV setFrame:CGRectMake((bgV.bounds.size.width - imgV.image.size.width)/2, 0, imgV.image.size.width, imgV.image.size.height)];
                [view setFrame:CGRectMake(0, img.size.height - (5), bgV.bounds.size.width, (80))];
            }
            {
                UIButton *btn = [[UIButton alloc] init];
                [btn setFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setImage:[UIImage imageNamed:@"shake_door"] forState:UIControlStateNormal];
                [btn setTitle:@"摇一摇" forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake((5), -btn.imageView.frame.size.width, -btn.imageView.frame.size.height, 0)];
                [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height, 0, 0, -btn.titleLabel.intrinsicContentSize.width)];
                [btn addTarget:self action:@selector(shakeAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:btn];
            }
        }
    }
    
    [[BDPopViewController sharePopViewController] pushPopViewWithSuperView:[[UIApplication sharedApplication] delegate].window PopView:bgV BDPopViewIn:BDPopViewInCustom BDPopViewStop:BDPopViewStopCustom BDPopViewOut:BDPopViewOutCustom BDPopViewStopFrame:bgV.frame bgViewShow:YES transparent:NO BgViewClickCancel:YES];
    
}

- (void)keyAction:(UIButton *)btn
{
    [[BDPopViewController sharePopViewController] dissPopView];
}

- (void)shakeAction:(UIButton *)btn
{
    [[BDPopViewController sharePopViewController] dissPopView];
}

- (void)codeAction:(UIButton *)btn
{
    [[BDPopViewController sharePopViewController] dissPopView];
}

- (void)bd_loadShadowWithView:(UIView *)view ShadowOpacity:(float)shadowOpacity ShadowRadius:(float)shadowRadius CornerRadius:(CGFloat)cornerRadius
{
    [view.layer setShadowColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowOffset:CGSizeMake(0,0)];
    [view.layer setShadowOpacity:shadowOpacity];
    [view.layer setShadowRadius:shadowRadius];
    [view.layer setCornerRadius:cornerRadius];
    [view.layer setMasksToBounds:YES];
}

#pragma mark - MJLoadData

#pragma mark - UIScrollViewDelegate

#pragma mark - UITableView

#pragma mark - UICollectionView

#pragma mark - SelfDelegate

#pragma mark - Request

@end
