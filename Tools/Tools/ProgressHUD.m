//
//  ProgressHUD.m
//  MaZhan
//
//  Created by majianghai on 2017/1/9.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "ProgressHUD.h"

#define WINDOW    [UIApplication sharedApplication].delegate.window
#define DEFAULT_DISPLAY_DURATION 0.75


@interface ProgressHUD ()<MBProgressHUDDelegate>
@property (nonatomic, weak) UILabel *text;
@end


@implementation ProgressHUD

+ (instancetype)shareHUD
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(void)showMessage:(NSString *)text {
    
    [self showText:text];
    
}

- (void)showText:(NSString *)text_ {
    [self showWithText:text_  topOffset:0.0 duration:DEFAULT_DISPLAY_DURATION];
}

//初始化弹窗
- (void)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_
            duration:(CGFloat)duration_{
    
    @synchronized(self)
    {
        void (^showBlock)() = ^{
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            
            // Configure for text only and offset down
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelText = text_;
            hud.detailsLabelFont = [UIFont systemFontOfSize:15.f];
            hud.removeFromSuperViewOnHide = YES;
            hud.userInteractionEnabled = NO;
            
            [hud hide:YES afterDelay:duration_];
        };
        
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                showBlock();
            });
        } else {
            showBlock();
        }
#if 0
        dispatch_async(dispatch_get_main_queue(), ^{
            if (toast==nil)
            {
                BOOL firstIn=YES;
                toast=[[PromptInfo alloc] initWithText:text_ firstIn:firstIn];
            }
            else
            {
                BOOL firstIn=NO;
                [toast initWithText:text_ firstIn:firstIn];
            }
            [toast setDuration:duration_];
            [toast showFromTopOffset:topOffset_];
        });
#endif
    }
}



- (void)showMessageAfterLoadingFinish:(NSString *)text {
    [self loadingFinish];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMessage:text];
    });
}


-(void)showLoading {
    
    HUD = [MBProgressHUD showHUDAddedTo:WINDOW animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
}


-(void)loadingFinish {
    [HUD hide:YES afterDelay:0.1f];
}


-(void)hudWasHidden:(MBProgressHUD *)hud {
    [HUD removeFromSuperview];
    HUD = nil;
}




@end
