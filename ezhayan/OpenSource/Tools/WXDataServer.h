
#import <Foundation/Foundation.h>

@interface WXDataServer : NSObject

/**
 *  这个方法是二次封装AFN的类方法，它既可以用于GET请求，也可以用于POST请求，POST可以在请求体请求图片，视频，音频等二进制数据
 *
 *  @param urlstring 在BaseURL后面拼接的子接口路径
 *  @param method    请求方法（GET请求/POST请求）
 *  @param params    POST请求体中纯文本的形式的（不带图片，音频，视频等二进制数据）的字典
 *  @param files     POST请求体中请求图片，音频，视频等二进制数据的字典
 *  @param success   数据请求成功的block，返回一个我们需要的数据
 *  @param fail      数据请求失败的block，返回一个错误信息
 */
+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;
+ (void)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)parmas
              file:(NSDictionary *)files
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
           success:(void (^)(id data))success
              fail:(void (^)(NSError *error))fail;

@end
