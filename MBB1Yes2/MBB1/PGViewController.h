//
//  PGViewController.h
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PGViewController : FatherViewController{
    
    AVAudioPlayer *_audioPlayer;    //音乐播放器对象
}
@property (strong , nonatomic) UIImageView *gifView;


@property (strong , nonatomic) NSMutableArray *imageArr;
@property (assign , nonatomic) CGFloat animationTime;
/*
+(CGSize)downloadImageSizeWithURL:(id)imageURL;
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request;
 
*/
@end
