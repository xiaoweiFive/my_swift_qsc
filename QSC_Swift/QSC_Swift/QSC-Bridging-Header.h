//
//  QSC-Bridging-Header.h
//  QSC_Swift
//
//  Created by zhangzhenwei on 17/4/21.
//  Copyright © 2017年 QSC. All rights reserved.
//

//#ifndef QSC_Bridging_Header_h
//#define QSC_Bridging_Header_h

#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>




//#endif /* QSC_Bridging_Header_h */


#define YYSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
