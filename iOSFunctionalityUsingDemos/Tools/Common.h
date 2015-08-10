#pragma mark --------------------------- 沙盒
#define  kBundleIdentifier ([NSBundle mainBundle].bundleIdentifier)
//沙盒 Documents 目录
#define kDocumentsDir (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0])
//沙盒 Caches 目录
#define kCachesDir ((NSString *)(NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)[0]))
//沙盒 tmp 目录
#define kTmpDir NSTemporaryDirectory()

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#pragma mark --------------------------- 设备尺寸

#if TARGET_IPHONE_SIMULATOR
#define kISSIMULATOR 1
#elif TARGET_OS_IPHONE
#define kISSIMULATOR 0
#endif

//获取屏幕 宽度、高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#pragma mark --------------------------- 版本相关
//获取应用版本
#define kAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey])
//获取设备系统版本
#define kIOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kIOSVersionString ([[UIDevice currentDevice] systemVersion])
//匹配系统版本
#define kSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define kSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define kSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define kSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define kSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define kIOS8_0_OR_LATER ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] ==NSOrderedDescending||[[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] ==NSOrderedSame)
#define kIOS7_0_OR_LATER ([[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch] ==NSOrderedDescending||[[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch] ==NSOrderedSame)
#define kIOS6_0_OR_LATER ([[UIDevice currentDevice].systemVersion compare:@"6.0" options:NSNumericSearch] ==NSOrderedDescending||[[UIDevice currentDevice].systemVersion compare:@"6.0" options:NSNumericSearch] ==NSOrderedSame)
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define kIsRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为 Iphone6
#define IS_IPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
//判断是否为 iPhone6 plus
#define IS_IPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#pragma mark ---------------------------  图片相关
//读取本地图片
#define kLoadLocalImg(imgName) (([imgName rangeOfString:@"."].location!=NSNotFound)?[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imgName ofType:nil]]:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:[imgName stringByAppendingString:@".png"] ofType:nil]])

#pragma mark --------------------------- 颜色相关
//随机颜色
#define kRandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0 ) saturation:( arc4random() % 256 / 256.0 ) brightness:( arc4random() % 256 / 256.0 ) alpha:1];
//rgb颜色
#define kColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//rgb颜色转换（16进制->10进制）
#define kColorFromRGB16(rgbValue16,a) [UIColor colorWithRed:((float)((rgbValue16 & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue16 & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue16 & 0xFF))/255.0 alpha:a]
//透明背景色
#define kClearColor [UIColor clearColor]
#pragma mark --------------------------- 多线程
//GCD
#define kGCD_Gobal_Queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kGCD_Main_Queue dispatch_get_main_queue();
#define kGCD_Back_Async(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define kGCD_Main_Async(block) dispatch_async(dispatch_get_main_queue(),block)



#pragma mark --------------------------- 数字处理
#define kRoundToInt(number) ((NSInteger)round(number))
//精确到小数点后面指定的位数（四舍五入制）
//floatNum 要转换的数字
//accuracy 精度（小数点后面几位）
#define kAccurateDecimalPoint(floatNum,accuracy) (floor(floatNum*pow(10, accuracy)+0.5)/pow(10, accuracy))
#define kNumIsEqual(a,b) (ABS(a-b)<1e-6)

#pragma mark ------------------- 其他 -------------------
//由角度获取弧度 有弧度获取角度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// .h
#define kSingle_interface(class)  + (class *)shared##class;
// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define kSingle_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}

#define kSetBgImg \
- (void) loadView{\
[super loadView];\
self.view.backgroundColor=kColor(242,242,242,1);\
}

#define NEED_YOUHUA_LOG(s) NSLog(@"--->>该处性能需要优化,类：%@ line:%d 问题：%@",[self class],__LINE__,s)

#define FIXLaterLOG(s) NSLog(@"------->>>>>>>>>该处发布时需要修改：%@ line:%d 描述：%@",[self class],__LINE__,s)



