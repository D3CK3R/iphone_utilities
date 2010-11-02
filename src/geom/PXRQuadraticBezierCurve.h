#import <UIKit/UIKit.h>


@interface PXRQuadraticBezierCurve : NSObject {
	CGPoint pointA;
	CGPoint pointB;
	CGPoint controlPoint;
}

@property CGPoint pointA;
@property CGPoint pointB;
@property CGPoint controlPoint;

-(CGPoint)positionAt:(double)time;
-(double)rotationAt:(double)time withSensitivity:(double)sens;
-(double)averageLengthWithSensitivity:(double)sens;

@end
