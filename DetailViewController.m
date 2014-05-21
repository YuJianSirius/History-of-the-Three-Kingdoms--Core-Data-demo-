//
//  DetailViewController.m
//  SanGuoZhi
//
//  Created by xiaojia on 14-3-28.
//  Copyright (c) 2014年 sirius. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
	// Do any additional setup after loading the view.
}




-(void)initUI
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector  (actCancel:)];
    //self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                         target:self
                                                                                         action:@selector   (actSave:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    if(self.heroInfo){
        self.nameTextField.text = self.heroInfo.name;
        if(self.heroInfo.image){
            NSLog(@"showIMage %@",self.heroInfo.image);
            [self.ImageBtn setImage:self.heroInfo.image forState:UIControlStateNormal];
        }
    }
}

- (IBAction)actCancel:(id)sender
{
    if (self.delegate) {
        [self.delegate cancelDetailedInfo:self];
    }
}

- (IBAction)actSave:(id)sender
{
    if (self.delegate) {
        [self.delegate saveDetailedInfo:self];
    }
}

/*
- (IBAction)actChooseImage:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate        = self;
    self.imagePicker.allowsEditing   = YES;
    self.imagePicker.sourceType      = UIImagePickerControllerSourceTypePhotoLibrary;
    //系统相册
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}
*/
@end
