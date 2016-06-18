//
//  KRSportViewController.m
//  酷跑
//
//  Created by tarena on 16/6/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "KRSportViewController.h"
#import "KRUserInfo.h"
#import "NSString+md5.h"
#import "BMapKit.h"
#import "AFNetworking.h"
#import "MBProgressHUD+KR.h"
#define  KRBMKSPAN  0.002
/** 定义一个类型 用来区分是画线还是不画线 */
typedef enum {
    TrailStart = 1,
    TrailEnd
}Trail;
@interface KRSportViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
/** 百度地图的view */
@property (nonatomic,strong) BMKMapView *mapView;
/** 百度地图位置服务 */
@property (nonatomic,strong) BMKLocationService *locationService;
/** 开始运动的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *startSportBtn;
/** 开始运动 */
- (IBAction)startSport:(id)sender;
/** 暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *pauseSportBtn;
/** 标记是画用户路径 还是不画 */
@property (nonatomic,assign) Trail trail;
/** 起点 和 终点大头针 */
@property (nonatomic,strong) BMKPointAnnotation *startPoint;
@property (nonatomic,strong)
    BMKPointAnnotation *endPoint;
/** 用来存储用户的位置的数组 */
@property (nonatomic,strong) NSMutableArray *locationArrayM;
/** 用来记录用户的上一个位置 */
@property (nonatomic,strong) CLLocation*preLocation;
/** 记录用户的总距离 */
@property (nonatomic, assign) double sumDistance;
/** 运动的总时间长度 */
@property (nonatomic, assign) double
    sumTimeLen;
/** 运动的总热量 */
@property (nonatomic, assign) double
    sumHeat;
/** 折线 遮盖线 */
@property (nonatomic, strong) BMKPolyline * polyLine;
/** 暂停运动视图 */
@property (weak, nonatomic) IBOutlet UIView *pauseSportView;
/** 继续运动 */
- (IBAction)continueSport:(id)sender;
/** 完成运动 */
- (IBAction)completeSport:(id)sender;
/** 完成运动对应的view */
@property (weak, nonatomic) IBOutlet UIView *completeSportView;
/** 取消本次运动 */
- (IBAction)cancelSport:(id)sender;
/** 保存运动数据到web服务器 */
- (IBAction)saveSportDataToWebServer:(id)sender;
/** 分享到酷跑的运动圈 */
- (IBAction)sharedToKRSportCircle:(id)sender;
/** 分享到新浪微博 */
- (IBAction)sharedToSinaWeiBo:(id)sender;

@end

@implementation KRSportViewController
/** 懒加载 */
- (NSMutableArray*) locationArrayM{
    if (_locationArrayM == nil) {
        _locationArrayM = [NSMutableArray array];
    }
    return _locationArrayM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [BMKMapView new];
    self.mapView.frame = self.view.bounds;
    //[self.view addSubview:self.mapView];
    [self.view insertSubview:self.mapView atIndex:0];
    [self setBMKLocationService];
    [self setMapViewProperty];
    // 设置代理
    self.mapView.delegate = self;
    self.locationService.delegate = self;
    // 对暂停按钮增加手势
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pauseSport)];
    gesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.pauseSportBtn addGestureRecognizer:gesture];
    // 启动定位服务
    [self.locationService startUserLocationService];
}
/** 暂停运动 */
- (void) pauseSport{
    self.pauseSportBtn.hidden = YES;
    // 停止定位服务
    [self.locationService stopUserLocationService];
    // 显示暂停视图
    self.pauseSportView.hidden = NO;
}
/**  设置百度地图位置服务 */
- (void) setBMKLocationService{
    self.locationService = [BMKLocationService new];
    [BMKLocationService setLocationDistanceFilter:5];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
}
/** 百度地图view 的设置 */
- (void) setMapViewProperty{
    // 显示定位图层
    self.mapView.showsUserLocation = YES;
    // 设置定位模式
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    self.mapView.rotateEnabled = NO;
    // 是否显示比例尺
    self.mapView.showMapScaleBar = YES;
    self.mapView.mapScaleBarPosition = CGPointMake(self.mapView.frame.size.width - 50, self.mapView.frame.size.height - 50);
    // 自定义样式参数
    BMKLocationViewDisplayParam *displayParam = [BMKLocationViewDisplayParam new];
    displayParam.isAccuracyCircleShow = NO;
    displayParam.locationViewOffsetX = 0;
    [self.mapView updateLocationViewWithParam:displayParam];
    
}
/** 用户位置更新 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"用户的位置发生改变 %lf:%lf", userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    [self.mapView updateLocationData:userLocation];
    // 根据扇区 获取一个合适的区域
    BMKCoordinateRegion fitsRegion = [self.mapView regionThatFits:BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(KRBMKSPAN, KRBMKSPAN))];
    [self.mapView setRegion:fitsRegion animated:YES];
    // 定位的准确度
    if(userLocation.location.horizontalAccuracy > kCLLocationAccuracyNearestTenMeters){
        // 判断用户没有在室外活动
        return;
    }
    // 如果是可以画线的状态
    if(self.trail == TrailStart){
        // 把用户的位置存储 并根据用户位置做相关操作
        [self  startTrailRouterWithUserLocation: userLocation];
    }
}
- (void) startTrailRouterWithUserLocation:(BMKUserLocation*) userLocation{
    /** 计算运动的总距离 */
    if(self.preLocation){
        // 当前位置到前一个点的位置
        double distance = [self.preLocation distanceFromLocation:userLocation.location];
        // 累加到总距离的属性上
        self.sumDistance += distance;
    }
    self.preLocation = userLocation.location;
    // 把当前位置放入位置数组
    [self.locationArrayM addObject:userLocation.location];
    // 根据位置数组 绘制用户路径
    [self drawWalkLine];
}
- (void) drawWalkLine{
    NSInteger  count = self.locationArrayM.count;
    // 在堆中申请一块内存空间 使用一个指针指向这块空间
    BMKMapPoint *tempPoints = malloc(sizeof(BMKMapPoint)*count);
    // 把数组中的位置 转换成BMKMapPoint
    for (int i = 0; i < count; i++) {
        BMKMapPoint point = BMKMapPointForCoordinate([self.locationArrayM[i] coordinate]);
        tempPoints[i] = point;
    }
//    [self.locationArrayM enumerateObjectsUsingBlock:^(CLLocation* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        BMKMapPoint point = BMKMapPointForCoordinate(obj.coordinate);
//        tempPoints[idx] = point;
//    }];
    // 构建线之前 应该把之前的线移走
    [self.mapView  removeOverlay:self.polyLine];
    // 如何处理这些位置点
    self.polyLine = [BMKPolyline polylineWithPoints:tempPoints count:count];
    // 把遮盖线 加到地图上
    if (self.polyLine) {
        [self.mapView addOverlay:self.polyLine];
    }
    // 释放堆内存
    free(tempPoints);
}
/** 遮盖线视图 */
- (BMKOverlayView*) mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polyLineView = [[BMKPolylineView alloc]initWithOverlay:overlay];
        polyLineView.strokeColor = [UIColor greenColor];
        polyLineView.lineWidth = 4.0;
        return polyLineView;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startSport:(id)sender {
    self.startSportBtn.hidden = YES;
    self.pauseSportBtn.hidden = NO;
    self.trail = TrailStart;
    CLLocation *location = self.locationService.userLocation.location;
    // 设置起点大头针
    if (location){
        self.startPoint = [self createPointWithLocation:location title:@"起点"];
        [self.locationArrayM addObject:location];
    }
}
/** 创建大头针的方法 */
- (BMKPointAnnotation*) createPointWithLocation:(CLLocation*) location title:(NSString*) title{
    BMKPointAnnotation *point = [BMKPointAnnotation new];
    point.coordinate = location.coordinate;
    point.title = title;
    [self.mapView addAnnotation:point];
    return point;
}
/** 大头针的view方法 */
- (BMKAnnotationView*) mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        // 设置图片(如果startPoint有值就设置终点图片 没有值就设置起点图片)
        if(self.startPoint){
            annotationView.image = [UIImage imageNamed:@"定位-终"];
        }else{
            annotationView.image = [UIImage imageNamed:@"定位-起"];
        }
        annotationView.draggable = NO;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return  nil;
}
- (IBAction)continueSport:(id)sender {
    // 隐藏暂停视图
    self.pauseSportView.hidden = YES;
    // 显示暂停按钮
    self.pauseSportBtn.hidden = NO;
    // 启动定位服务
    [self.locationService startUserLocationService];
}
/** 完成运动 需要实现那些? */
- (IBAction)completeSport:(id)sender {
    // 先隐藏暂停运动视图
    self.pauseSportView.hidden = YES;
    // 设置终点大头针
    self.endPoint = [self createPointWithLocation:[self.locationArrayM lastObject] title:@"终点"];
    // 把所有的点都显示在视图范围内
    [self fitMapViewForPolyLine];
    // 显示完成运动的视图
    self.completeSportView.hidden = NO;
    CLLocation *firstLoc = [self.locationArrayM firstObject];
    CLLocation *lastLoc = [self.locationArrayM lastObject];
    self.sumTimeLen = [lastLoc.timestamp timeIntervalSince1970] - [firstLoc.timestamp timeIntervalSince1970];
    self.sumHeat = (self.sumTimeLen/3600.0)*600;
}
/** 把所有的点都显示在视图范围内 */
- (void)fitMapViewForPolyLine {
    // 计算最小的x 和 最小的y 以及最大的x最大的y
    CGFloat ltX, ltY, maxX, maxY;
    if (self.polyLine.pointCount < 2) {
        return;
    }
    BMKMapPoint  pt = self.polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    maxX = pt.x, maxY = pt.y;
    for (int i = 1 ; i < self.polyLine.pointCount ; i++) {
        BMKMapPoint tempPoint = self.polyLine.points[i];
        if (tempPoint.x < ltX) {
            ltX = tempPoint.x;
        }
        if (tempPoint.y < ltY) {
            ltY = tempPoint.y;
        }
        if (tempPoint.x > maxX) {
            maxX = tempPoint.x;
        }
        if (tempPoint.y > maxY) {
            maxY = tempPoint.y;
        }
    }
    // 构建一个矩形
    BMKMapRect  rect;
    rect.origin = BMKMapPointMake(ltX - 40, ltY - 60);
    CGFloat sizeW = maxX - ltX;
    CGFloat sizeH = maxY - ltY;
    rect.size = BMKMapSizeMake(sizeW + 80, sizeH + 120);
    [self.mapView setVisibleMapRect:rect animated:YES];
    
}

/* 1.做出运动完成时的界面
   2.完成取消功能 就是恢复到跑步之前的状态
     如果发现了程序的bug就修复一下(遮盖线的问题)
   3.参考新浪开放平台上的 发布带图片的微博api
     完成发布一条微博
 // 后续操作中需要获取地图的图片
 // UIImage *image = self.mapView takeSnapshot;
*/

- (IBAction)cancelSport:(id)sender {
    self.completeSportView.hidden = YES;
    self.startSportBtn.hidden = NO;
    [self clean];
    [self.locationService startUserLocationService];
}
/** 清理状态的方法 */
- (void)clean{
    self.sumDistance = 0.0;
    self.trail = TrailEnd;
    // 清理位置数组
    [self.locationArrayM removeAllObjects];
    // 移除大头针
    if(self.startPoint){
        [self.mapView removeAnnotation:self.startPoint];
        self.startPoint = nil;
    }
    if (self.endPoint) {
        [self.mapView removeAnnotation:self.endPoint];
        self.endPoint = nil;
    }
    // 移除遮盖线
    if (self.polyLine) {
        [self.mapView removeOverlay:self.polyLine];
        self.polyLine = nil;
    }
    
}
/** 把运动数据存入 web 服务器 
    需要准备8个参数 */
- (IBAction)saveSportDataToWebServer:(id)sender {
    NSString *url = @"http://127.0.0.1:8080/allRunServer/addSportData.jsp";
    // 准备请求的参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = [KRUserInfo sharedKRUserInfo].userName;
    parameters[@"md5password"] = [[KRUserInfo sharedKRUserInfo].userPassword md5StrXor];
    parameters[@"sportType"] = @(2);
    /** 把用户的位置点 变成如下格式的字符串:
        经度|纬度|运动开始时间@经度|纬度|运动开始时间 
        要求只存起点 和 终点 */
    CLLocation *firstLoc = [self.locationArrayM firstObject];
    CLLocation *lastLoc = [self.locationArrayM lastObject];
    parameters[@"data"] = [NSString stringWithFormat:@"%.2lf|%.4lf|%.4lf@%.2lf|%.4lf|%.4lf",[firstLoc.timestamp timeIntervalSince1970],firstLoc.coordinate.latitude,firstLoc.coordinate.longitude,[lastLoc.timestamp timeIntervalSince1970],lastLoc.coordinate.latitude,lastLoc.coordinate.longitude];
    /** 剩下的四个参数 参考数据库表中的字段 
        运动的距离 运动的时间长度 运动的热量
        运动开始的时间 */
    parameters[@"sportDistance"] = @(self.sumDistance);
    parameters[@"sportTimeLen"] = @(self.sumTimeLen);
    /** 计算总共的距离 热量  总运动时间
     爬楼梯1500级（不计时） 250卡
     快走（一小时8公里） 　　 555卡
     快跑(一小时12公里） 700卡
     单车(一小时9公里) 245卡
     单车(一小时16公里) 415卡
     单车(一小时21公里) 655卡
     舞池跳舞 300卡
     健身操 300卡
     骑马 350卡
     网球 425卡
     爬梯机 680卡
     手球 600卡
     桌球 300卡
     慢走(一小时4公里) 255卡
     慢跑(一小时9公里) 655卡
     游泳(一小时3公里) 550卡
     有氧运动(轻度) 275卡
     有氧运动(中度) 350卡
     高尔夫球(走路自背球杆) 270卡
     锯木 400卡
     体能训练 300卡
     走步机(一小时6公里) 345卡
     轮式溜冰 350卡
     跳绳 660卡
     郊外滑雪(一小时8公里) 600卡
     练武术 790 */
  
    parameters[@"sportHeat"] = @(self.sumHeat);
    parameters[@"sportStartTime"] = @([firstLoc.timestamp timeIntervalSince1970]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    // 调用取消对应的代表 把程序恢复到最初状态
    [self cancelSport:nil];
}
/** 分享到运动圈 */
- (IBAction)sharedToKRSportCircle:(id)sender {
    // http://127.0.0.1:8080/allRunServer/addTopic.jsp
    NSString *url = @"http://127.0.0.1:8080/allRunServer/addTopic.jsp";
    /** 准备参数 */
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = [KRUserInfo sharedKRUserInfo].userName;
    parameters[@"md5password"] = [[KRUserInfo sharedKRUserInfo].userPassword md5StrXor];
    NSString *status = [NSString stringWithFormat:@"本次运动的总距离是%.1lf米,运动的总时间是%.1lf秒,消耗的总热量%.4lfK卡",self.sumDistance,self.sumTimeLen,self.sumHeat];
    parameters[@"content"] = status;
    parameters[@"address"] = @"中国北京";
    // 最后一个位置对应的经纬度
    parameters[@"latitude"] = @(self.endPoint.coordinate.latitude);
    parameters[@"longitude"] = @(self.endPoint.coordinate.longitude);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 获取地图对应的图片
        UIImage *image = [self.mapView takeSnapshot];
        // 宽度处理成200 高度等比例变化
        double s = 200.0 / image.size.width;
        UIImage *newImage = [self thumbnaiWithImage:image size:CGSizeMake(200, image.size.height * s )];
       NSData *sendData =  UIImageJPEGRepresentation(newImage, 0.3);
//        NSData *imageData = UIImagePNGRepresentation(image);
       // 当前时间+用户名
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *dateStr = [dateFormatter stringFromDate:date];
        NSString *picName = [NSString stringWithFormat:@"%@%@.png",dateStr,[KRUserInfo sharedKRUserInfo].userName];
        [formData appendPartWithFileData:sendData name:@"pic" fileName:picName mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [self saveSportDataToWebServer:nil];
}
/** 压缩图片 */
- (UIImage*) thumbnaiWithImage:(UIImage*)image size:(CGSize) size {
    UIImage  *newImage = nil;
    if (image != nil) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

/** 分享到新浪 微博 */
- (IBAction)sharedToSinaWeiBo:(id)sender {
    // 是新浪第三方登录 就发微博
    // 不是新浪第三方登录就提示用户第三方登录才能才微博
    if ([KRUserInfo sharedKRUserInfo].isSinaLogin) {
        NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
        /** 准备参数 */
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"access_token"] = [KRUserInfo sharedKRUserInfo].userRegisterPassword;
        /** 构建微博的内容 */
        NSString *status = [NSString stringWithFormat:@"本次运动的总距离是%.1lf米,运动的总时间是%.1lf秒,消耗的总热量%.4lfK卡",self.sumDistance,self.sumTimeLen,self.sumHeat];
        parameters[@"status"] = status;
        /** 上传运动图片 */
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            // 获取地图的截图
            UIImage *image = [self.mapView takeSnapshot];
            NSData *imageData = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:imageData name:@"pic" fileName:@"运动记录.png" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"发布微博成功:%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发布微博失败");
        }];
    }else{
        [MBProgressHUD showError:@"请使用新浪第三方登录"];
    }
    //[self cancelSport:nil];
     // 保存一份数据到web服务器
    [self saveSportDataToWebServer:nil];
}
@end








