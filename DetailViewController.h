//
//  DetailViewController.h
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-28.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHero.h"

@protocol DetailedViewControllerDelegate;

@interface DetailViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationBarDelegate>

@property (nonatomic)         id <DetailedViewControllerDelegate>    delegate;

//创建时需要表视图提供信息，之后可以在代理回调函数中供表视图取得已更新的信息
@property (nonatomic,strong)  XHero                                 *heroInfo;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton    *ImageBtn;


@end

@protocol  DetailedViewControllerDelegate <NSObject>
-(void)saveDetailedInfo:(DetailViewController *)detailedInfoVC;
-(void)cancelDetailedInfo:(DetailViewController *)detailedInfoVC;
@end
