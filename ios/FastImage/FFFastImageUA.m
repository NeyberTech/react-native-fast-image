#import "FFFastImageUA.h"
#include <sys/utsname.h>

@implementation FFFastImageUA

static NSString *_cachedUserAgent = nil;
static dispatch_once_t onceToken;

+ (NSString *)getCustomUserAgent {

    dispatch_once(&onceToken, ^{
        NSString *userAgentAppInfo = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UserAgentAppInfo"] ?: @"";
        NSString *cfnVersion = [NSBundle bundleWithIdentifier:@"com.apple.CFNetwork"].infoDictionary[@"CFBundleShortVersionString"];
        struct utsname u;
        uname(&u);
        NSString *darwinVersion = [NSString stringWithUTF8String:u.release];

        if (userAgentAppInfo) {
            _cachedUserAgent = [NSString stringWithFormat:@"%@ CFNetwork/%@ Darwin/%@", userAgentAppInfo, cfnVersion, darwinVersion];
        }
    });

    return _cachedUserAgent;
}

@end