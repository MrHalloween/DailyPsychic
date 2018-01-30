//
//  SCHAnimationGroup.h

//
//  Created by 魏巍 on 12-9-26.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface SCHAnimationGroup : CAAnimationGroup

{
    NSInteger _animation_tag;
}
@property (nonatomic,assign) NSInteger animation_tag;
@end
