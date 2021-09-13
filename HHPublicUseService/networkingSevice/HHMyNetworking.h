//
//  HHMyNetworking.h
//  MeileTang
//
//  Created by admin on 2019/6/19.
//  Copyright © 2019 douzi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UploadParam.h"

@class UploadParam;

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost = 1,
    /**
     *  put请求
     */
    HttpRequestTypePut = 2,
    /**
     *  delete请求
     */
    HttpRequestTypeDelete = 3,
};

@interface HHMyNetworking : NSObject

+ (instancetype)sharedInstance;

//设置token等属性
- (void)setTokenInfo:(NSString *)token;

//取消当前请求
- (void)cancleRequestTask;

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success 请求的结果
 */
- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;
/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadArr   上传图片的信息的数组
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <UploadParam *>*)uploadArr
            uploadVedioPath:(NSString *)vedioPath
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError * error))failure;

/**
 *  上传视频加图片
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <UploadParam *>*)uploadArr
             uploadVedioUrl:(NSURL *)vedioUrl
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError * error))failure;

/**
 *  上传pdf  data
 */
- (void)uploadPDFfileWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                          fileData:(NSData *)fileData
                          fileName:(NSString *)fileName
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError * error))failure ;

//post提交 Json
- (void)postJSONWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure;

//put提交 json
- (void)putJSONWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure;

//文件下载
-(void)downloadFileFromServer:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure;

//删除 Body传值
- (void)requestForDeleteBody:(NSString *)URLString
                   listArr:(NSMutableArray *)listArr
                   success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError * error))failure;


//批量上传 Body传值
- (void)postBodyJSONWithURLString:(NSString *)URLString
                     listArr:(NSMutableArray *)listArr
                     success:(void (^)(id))success
                          failure:(void (^)(NSError *))failure;

@end

