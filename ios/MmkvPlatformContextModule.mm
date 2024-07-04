//
//  AppleMmkvPlatformContext.m
//  react-native-mmkv
//
//  Created by Marc Rousavy on 25.03.24.
//

#import "MmkvPlatformContext.h"
#import <Foundation/Foundation.h>

@implementation MmkvPlatformContext

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams&)params {
  return std::make_shared<facebook::react::NativeMmkvPlatformContextSpecJSI>(params);
}

- (NSString*)getBaseDirectory {
#if TARGET_OS_TV
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
#else
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
#endif
  NSString* documentPath = (NSString*)[paths firstObject];
  if ([documentPath length] > 0) {
    NSString* basePath = [documentPath stringByAppendingPathComponent:@"mmkv"];
    return basePath;
  } else {
    @throw [NSException exceptionWithName:@"BasePathNotFound"
                                   reason:@"Cannot find base-path to store MMKV files!"
                                 userInfo:nil];
  }
}

@end
