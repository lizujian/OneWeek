//
//  MapView.m
//  XiaoHuaiDan
//
//  Created by TCL on 14-7-2.
//  Copyright (c) 2014年 sch. All rights reserved.
//

#import "MapView.h"
#import "CustomAnnotationView.h"
//#import "XHDUsers.h"

#import "CustomPinAnnotation.h"
#import "CustomCalloutAnnotation.h"
#import "CustomCalloutView.h"

@implementation MapView

NSString *userLatitude;
NSString *userlongitude;

@synthesize mapBtn,listBtn,table,map,screenView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 128.0/1136.0*frame.size.height)];
        [barView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
        [self addSubview:barView];
        
        UITextField *titleText = [[UITextField alloc] initWithFrame:CGRectMake(224.0/640.0*frame.size.width, 65.0/1136.0*frame.size.height, 180.0/640.0*frame.size.width, 39.0/1136.0*frame.size.height)];
        titleText.text = @"LBS";
        titleText.textColor = [UIColor whiteColor];
        [titleText setFont:[UIFont fontWithName:@"Arial" size:17.0]];
        titleText.textAlignment = NSTextAlignmentCenter;
        [titleText setEnabled:NO];
        [barView addSubview:titleText];
        
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        checkBtn.frame = CGRectMake(548.0/640.0*frame.size.width, 53.0/1136.0*frame.size.height, 63.0/640.0*frame.size.width, 64.0/1136.0*frame.size.height);
        [checkBtn setBackgroundImage:[UIImage imageNamed:@"screening.png"] forState:UIControlStateNormal];
        [checkBtn addTarget:self action:@selector(screening:) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:checkBtn];
        
        [barView release];
        [titleText release];
        
        
        self.listBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        listBtn.frame = CGRectMake(61.0/640.0*self.frame.size.width, 148.0/1136.0*self.frame.size.height, 260.0/640.0*self.frame.size.width,57.0/1136.0*self.frame.size.height);
        [listBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
        [listBtn setTitle:@"列表" forState:UIControlStateNormal];
        [listBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [listBtn addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:listBtn];
        
        self.mapBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        mapBtn.frame = CGRectMake(321.0/640.0*self.frame.size.width, 148.0/1136.0*self.frame.size.height, 260.0/640.0*self.frame.size.width,57.0/1136.0*self.frame.size.height);
        [mapBtn setBackgroundColor:[UIColor whiteColor]];
        [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
        [mapBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [mapBtn addTarget:self action:@selector(showMap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mapBtn];
        
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 225.0/1136.0*frame.size.height, frame.size.width, frame.size.height-225.0/1136.0*frame.size.height) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        
        //        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:table];
        
        [table release];
        
//        userLatitude=@"30.281843";
//        userlongitude=@"120.102193";
        
        self.map=[[MKMapView alloc] initWithFrame:CGRectMake(0, 128.0/1136.0*frame.size.height, frame.size.width, frame.size.height-128.0/1136.0*frame.size.height)];
        map.mapType=MKMapTypeStandard;
        map.delegate=self;
        map.showsUserLocation=YES;
        [map setHidden:YES];
        [self addSubview:map];
        
        CLLocationCoordinate2D coord = {39.904299,116.22169};
        
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];//创建位置管理器
        locationManager.delegate=self;//设置代理
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
        locationManager.distanceFilter=1000.0f;//设置距离筛选器
        [locationManager startUpdatingLocation];//启动位置管理器
        MKCoordinateSpan theSpan;
        //地图的范围 越小越精确
        theSpan.latitudeDelta=0.05;
        theSpan.longitudeDelta=0.05;
        MKCoordinateRegion theRegion;
        theRegion.center=[[locationManager location] coordinate];
        theRegion.span=theSpan;
        
        MKCoordinateRegion region = {coord,theSpan};
        [map setRegion:region];
        
        //开始实时定位
        [locationManager startUpdatingLocation];
        
        
        CLLocationCoordinate2D showCoord = {39.904299,116.22169};
        CustomPinAnnotation *pinAnnotation = [[CustomPinAnnotation alloc] initWithCoordinate:showCoord addressDictionary:nil];
        // 调用addAnnotation方法时，会调用viewForAnnotation方法返回要显示的view
        [map addAnnotation:pinAnnotation];
        
        
        // 是否显示当前位置
        map.showsUserLocation = YES;
        
        [locationManager release];
        
        [map release];
        
        self.screenView = [[ScreenView alloc] initWithFrame:frame];
        [self.screenView setHidden:YES];
        [self addSubview:screenView];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSCreening:) name:@"MAPSHOW" object:nil];
        
    }
    return self;
}

-(void)showSCreening:(NSNotification *)noti
{
    [self addSubview:table];
    [self addSubview:listBtn];
    [self addSubview:mapBtn];

}

-(void)screening:(UIButton *)btn
{
    [map setHidden:YES];
    [self.table removeFromSuperview];
    [mapBtn removeFromSuperview];
    [listBtn removeFromSuperview];
    [self.screenView setHidden:NO];
}

-(void)beginScreen:(NSNotification *)noti
{
    [self.screenView setHidden:YES];
}

-(void)showList:(UIButton *)btn
{
    [map setHidden:YES];
    [self addSubview:table];
    [table reloadData];
    [mapBtn setBackgroundColor:[UIColor whiteColor]];
    [mapBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [listBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
    [listBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [mapBtn removeFromSuperview];
    [listBtn removeFromSuperview];
    
    [self addSubview:listBtn];
    [self addSubview:mapBtn];
}

-(void)showMap:(UIButton *)btn
{
    [self.table removeFromSuperview];
    [listBtn setBackgroundColor:[UIColor whiteColor]];
    [listBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [mapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [mapBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:99.0/255.0 alpha:1.0]];
   
    [map setHidden:NO];
    
    [mapBtn removeFromSuperview];
    [listBtn removeFromSuperview];
    
    [self addSubview:listBtn];
    [self addSubview:mapBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0/1136.0*self.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.showsReorderControl = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( 33.0/640.0*self.frame.size.width, 22.0/1136.0*self.frame.size.height, 81.0/640.0*self.frame.size.width, 81.0/1136.0*self.frame.size.height)];
        [headImg setBackgroundColor:[UIColor grayColor]];
        headImg.layer.cornerRadius = headImg.bounds.size.width/2;
        [cell.contentView addSubview:headImg];
        
        UITextField *petName = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*self.frame.size.width, 31.0/1136.0*self.frame.size.height, 90.0/640.0*self.frame.size.width, 29.0/1136.0*self.frame.size.height)];
        petName.text = @"moka";
        petName.textColor = [UIColor colorWithRed:118.0/255.0 green:196.0/255.0 blue:255.0/255.0 alpha:1.0];
        [petName setEnabled:NO];
        [cell.contentView addSubview:petName];
        
        UIImageView *sexImg = [[UIImageView alloc] initWithFrame:CGRectMake( 228.0/640.0*self.frame.size.width, 30.0/1136.0*self.frame.size.height, 20.0/640.0*self.frame.size.width, 30.0/1136.0*self.frame.size.height)];
        [sexImg setImage:[UIImage imageNamed:@"tie.png"]];
        [cell.contentView addSubview:sexImg];
        
        UITextField *varieties = [[UITextField alloc] initWithFrame:CGRectMake( 121.0/640.0*self.frame.size.width, 71.0/1136.0*self.frame.size.height, 90.0/640.0*self.frame.size.width, 25.0/1136.0*self.frame.size.height)];
        varieties.text = @"泰迪";
        [varieties setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
        varieties.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
        [varieties setEnabled:NO];
        [cell.contentView addSubview:varieties];
        
        UIImageView *locaImg = [[UIImageView alloc] initWithFrame:CGRectMake( 261.0/640.0*self.frame.size.width, 71.0/1136.0*self.frame.size.height, 20.0/640.0*self.frame.size.width, 25.0/1136.0*self.frame.size.height)];
        [locaImg setImage:[UIImage imageNamed:@"pin.png"]];
        [cell.contentView addSubview:locaImg];
        
        UITextField *location = [[UITextField alloc] initWithFrame:CGRectMake( 291.0/640.0*self.frame.size.width, 71.0/1136.0*self.frame.size.height, 90.0/640.0*self.frame.size.width, 25.0/1136.0*self.frame.size.height)];
        location.text = @"深圳";
        [location setFont:[UIFont fontWithName:@"Arial-BoldMT" size:12.0]];
        location.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
        [location setEnabled:NO];
        [cell.contentView addSubview:location];
        
        UIImageView *peoImg = [[UIImageView alloc] initWithFrame:CGRectMake( 540.0/640.0*self.frame.size.width, 22.0/1136.0*self.frame.size.height, 60.0/640.0*self.frame.size.width, 58.0/1136.0*self.frame.size.height)];
        [peoImg setBackgroundColor:[UIColor grayColor]];
        peoImg.layer.cornerRadius = 5;//设置那个圆角的有多圆
        [cell.contentView addSubview:peoImg];
        
        UITextField *dis = [[UITextField alloc] initWithFrame:CGRectMake( 527.0/640.0*self.frame.size.width, 85.0/1136.0*self.frame.size.height, 78.0/640.0*self.frame.size.width, 20.0/1136.0*self.frame.size.height)];
        dis.text = @"0.18km";
        [dis setFont:[UIFont fontWithName:@"Arial" size:9.0]];
        dis.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        [dis setEnabled:NO];
        [cell.contentView addSubview:dis];
        
        [headImg release];
        [petName release];
        [sexImg release];
        [varieties release];
        [locaImg release];
        [location release];
        [peoImg release];
        [dis release];
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.latitude];
    NSString *lng=[[NSString alloc] initWithFormat:@"%f",userLocation.coordinate.longitude];
    
    userLatitude=lat;
    userlongitude=lng;
    
    MKCoordinateSpan span;
    MKCoordinateRegion region;
    
    span.latitudeDelta=0.010;
    span.longitudeDelta=0.010;
    region.span=span;
    region.center=[userLocation coordinate];
    
    
    [map setRegion:[map regionThatFits:region] animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        // 当前位置 返回nil用系统自己的CalloutView
        [self.map setCenterCoordinate:annotation.coordinate animated:YES];
        return nil;
    } else if ([annotation isKindOfClass:[CustomCalloutAnnotation class]]) {
        // 点击位置点时，再弹出calloutview
        CustomCalloutView *calloutView = (CustomCalloutView *) [self.map dequeueReusableAnnotationViewWithIdentifier:@"calloutView"];
        if (calloutView == nil) {
            calloutView = [[CustomCalloutView alloc] initWithAnnotation:annotation reuseIdentifier:@"calloutView"];
        }
        
        // 调整calloutView的位置
        calloutView.centerOffset = CGPointMake(-75, -100);
        return calloutView;
    } else if ([annotation isKindOfClass:[CustomPinAnnotation class]]) {
        // 返回一个位置点标志，这个也可以用自定义的view
        MKAnnotationView *pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"];
        pinView.image = [UIImage imageNamed:@"cat_coordinates.png"];
        
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 2, 30.0, 30.0)];
        [headImage setBackgroundColor:[UIColor lightGrayColor]];
        headImage.layer.cornerRadius = headImage.bounds.size.width/2;
        [pinView addSubview:headImage];
        
        [self.map setCenterCoordinate:annotation.coordinate animated:YES];
        return pinView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
}

// 当点击地图上的一个位置点时，会调用此方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        // 点击当前位置
        
    } else if ([view.annotation isKindOfClass:[CustomPinAnnotation class]]) {
        // 点击自定义的位置点
        CustomPinAnnotation *pinAnnotation = (CustomPinAnnotation *)view.annotation;
        
        CustomCalloutAnnotation *calloutAnnotation = [[CustomCalloutAnnotation alloc] initWithLatitude:pinAnnotation.latitude longitude:pinAnnotation.longitude];
        pinAnnotation.calloutAnnotation = calloutAnnotation;
        // 调用此addAnnotation方法时，又会调viewForAnnotation方法返回对应的view
        [self.map addAnnotation:calloutAnnotation];
        [self.map setCenterCoordinate:view.annotation.coordinate animated:YES];
    }
}

// calloutView消失时调用
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    if ([view.annotation isKindOfClass:[CustomPinAnnotation class]]) {
        CustomPinAnnotation *pinAnnotation = (CustomPinAnnotation *) view.annotation;
        [self.map removeAnnotation:pinAnnotation.calloutAnnotation];
        pinAnnotation.calloutAnnotation = nil;
    }
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
//    MapAnnotation *annotation = view.annotation;
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:annotation.urlstring]];
    
    NSLog(@"2222222");
}

- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        NSLog(@"%@",location);
        // 市
    }
    
    [manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"%f,%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MAPSHOW" object:nil];
    
    [map release];
    [table release];
    [mapBtn release];
    [listBtn release];
    [screenView release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
