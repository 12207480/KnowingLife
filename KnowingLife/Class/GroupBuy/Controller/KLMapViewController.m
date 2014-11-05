//
//  KLMapViewController.m
//  KnowingLife
//
//  Created by tanyang on 14/11/5.
//  Copyright (c) 2014年 tany. All rights reserved.
//

#import "KLMapViewController.h"
#import <MapKit/MapKit.h>

@interface KLMapViewController ()<MKMapViewDelegate>
@property (nonatomic, weak) MKMapView *mapView;
@end

@implementation KLMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图";
    
    // 添加mapView
    MKMapView *mapView = [[MKMapView alloc]init];
    mapView.frame = self.view.frame;
    
    // 显示用户位置点
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    //self.mapView = mapView;
    
    
}

#pragma mark 根据经度纬度定位
- (void)locateToCoordinate2D:(CLLocationCoordinate2D) locateCoordinate
{
    // 设置地图经度纬度
    CLLocationCoordinate2D center = locateCoordinate;
    
    // 设置地图显示范围
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.03;
    
    // 创建MKCoordinateRegion 地区
    MKCoordinateRegion region = {center,span};
    
    // 设置当前地图的显示中心和范围
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark MKMapViewDelegate
#pragma mark 当定位到用户的位置就会调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.mapView == nil) {
        self.mapView = mapView;
        
        [self locateToCoordinate2D:userLocation.location.coordinate];
    }
}

#pragma mark 拖动地图（地图展示的区域改变了）就会调用
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}

- (void)dealloc
{
    KLLog(@"KLMapViewController dealloc");
}



@end