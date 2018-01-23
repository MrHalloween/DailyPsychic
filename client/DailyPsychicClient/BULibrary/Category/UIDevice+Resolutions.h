//
//  UIDevice+Resolutions.h
//  pbuHeavenTemple
//
//  Created by  -3 on 12-12-11.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
enum {
    UIDeviceResolution_Unknown          = 0,
    UIDeviceResolution_iPhoneStandard   = 1,    // iPhone 1,3,3GS Standard Display              (320x480px)
    UIDeviceResolution_iPhoneRetina35   = 2,    // iPhone 4,4S Retina Display 3.5"              (640x960px)
    UIDeviceResolution_iPhoneRetina4    = 3,    // iPhone 5,5S,5C Retina Display 4"             (640x1136px)
    UIDeviceResolution_iPhoneRetina47    = 4,    // iPhone 6,6S,7 Retina Display 4.7"           (750x1334px)
    UIDeviceResolution_iPhoneRetina55    = 5,    // iPhone 6,6S,7 plus Retina Display 5.5"      (1242x2208px)
    
    UIDeviceResolution_iPadStandard     = 6,    // iPad 1,2,mini Standard Display               (1024x768px)
    UIDeviceResolution_iPadRetina       = 7     // iPad 3 Retina Display                        (2048x1536px)
};

typedef NSUInteger UIDeviceResolution;

@interface UIDevice(Resolutions)

-(UIDeviceResolution)resolution;

NSString *NSStringFromResolution(UIDeviceResolution resolution);

@end
