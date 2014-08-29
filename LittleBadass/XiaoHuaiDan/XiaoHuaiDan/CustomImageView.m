
#import "CustomImageView.h"

//这个类的功能只是,你传给我一个调用方法的对象和方法本身,我只负责去调用这个方法
@implementation CustomImageView

@synthesize delegate = _delegate;
@synthesize method = _method;

//点击结束
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView * view = [self viewWithTag:1000];
    if (view) {
        view.hidden = YES;
    }
    
    //把自身或自身的参数传给方法本身
    if ([self.delegate respondsToSelector:self.method]) {
        //调用self.delegate对象的self.method方法,self为方法的参数
        [self.delegate performSelector:self.method withObject:self];
    }
    else{
        NSLog(@"回调方法没有实现:%@",NSStringFromSelector(self.method));
    }
}

//刚开始点击
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView * view = [self viewWithTag:1000];
    if (!view) {
        view = [[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.75;
        view.tag = 1000;
        [self addSubview:view];
        [view release];
    }
    else{
        //view默认是隐藏的
        view.hidden = NO;
    }
}

//单击图片的同时滑动屏幕,则touchesEnded就会被取消.这时再重载touchesEnded方法
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView * view = [self viewWithTag:1000];
    if (view) {
        view.hidden = YES;
    }
}

@end
