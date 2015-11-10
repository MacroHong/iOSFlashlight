//
//  MHTorch.m
//   
//
//  Created by MacroHong on 9/6/15.
//  Copyright © 2015 MacroHong. All rights reserved.
//

#import "MHTorch.h"
#import <UIKit/UIKit.h>
// 要导入AVFoundation.framework, 并添加下面的头文件
#import <AVFoundation/AVFoundation.h>


@interface MHTorch ()
{
    AVCaptureDevice *_device;
    dispatch_queue_t _queue;
}

@end

@implementation MHTorch

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("flashlight", NULL);
        if (!_queue) {
            return nil;
        }
        dispatch_async(_queue, ^{
            for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
                if ([device hasFlash] &&
                    [device isTorchModeSupported:(AVCaptureTorchModeOn)] &&
                    [device isTorchModeSupported:(AVCaptureTorchModeOff)]) {
                    _device = device;
                    break;
                }
            }
        });
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus != AVAuthorizationStatusRestricted &&
        authStatus != AVAuthorizationStatusDenied) {
        dispatch_async(_queue, ^{
            NSError *error = nil;
            if ([_device lockForConfiguration:&error]) {
                if (enabled) {
                    [_device setTorchMode:(AVCaptureTorchModeOn)];
                } else {
                    [_device setTorchMode:(AVCaptureTorchModeOff)];
                }
                [_device unlockForConfiguration];
            } else {
                NSLog(@"Failed to lock device %@ for configuration: %@", _device, error);
            }
        });
    } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"使用手电筒需要打开摄像头权限" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
    }
}

- (void)turnTorchOn {
    [self setEnabled:YES];
}

- (void)turnTorchOff {
    [self setEnabled:NO];
}

@end
