//
//  TFSegmentProtocol.h
//  VeryCheap
//
//  Created by 谢腾飞 on 2017/11/23.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#pragma mark - 模型必须遵循的协议

@protocol TFSegmentProtocol <NSObject>
/** 选项卡ID */
@property (nonatomic ,copy ,readonly) NSString *classid;
/** 选项卡内容 */
@property (nonatomic ,copy ,readonly) NSString *classname;
/** 选项卡图片 */
@property (nonatomic ,copy ,readonly) NSString *icon;
@end
