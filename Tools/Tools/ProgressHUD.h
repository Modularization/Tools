//
//  ProgressHUD.h
//  MaZhan
//
//  Created by majianghai on 2017/1/9.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ProgressHUD : NSObject
{
    MBProgressHUD *HUD;
}


+(instancetype)shareHUD;

-(void)showMessage:(NSString *)text;
- (void)showMessageAfterLoadingFinish:(NSString *)text;

-(void)showLoading;
-(void)loadingFinish;
@end
