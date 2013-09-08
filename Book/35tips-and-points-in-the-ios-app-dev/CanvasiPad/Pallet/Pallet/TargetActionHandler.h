//
//  TargetActionHandler.h
//  Pallet
//
//  Created by 國居 貴浩 on 11/10/17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetActionHandler : NSObject {
    NSMutableDictionary*    targetAndActionDic;
}
- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;
- (void)sendAction:(int)event sender:(id)sender;
@end
