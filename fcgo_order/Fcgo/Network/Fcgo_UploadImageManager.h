//
//  Fcgo_UploadImageManager.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

//上传文件控制类
@protocol Fcgo_UploadImageManagerDelegate <NSObject>
@optional
//上传图片成功以后 返回图片id数组
-(void)uploadImagesSucceed:(NSMutableArray *)array;
@end
//typedef enum : NSUInteger {
//    UploadHandleTypeFace,//面部照
////    UploadHandleTypeNormal,//普通栏
//} UploadHandleType;
@interface Fcgo_UploadImageManager : NSObject
{
    __unsafe_unretained id<Fcgo_UploadImageManagerDelegate>_delegate;
}
//@property(nonatomic,assign)UploadHandleType handleType;
@property(nonatomic,assign)id<Fcgo_UploadImageManagerDelegate>delegate;
+(Fcgo_UploadImageManager *)shareInstance;
-(void)uploadImageFromImageArray:(NSMutableArray  *)imageArr;

@end
