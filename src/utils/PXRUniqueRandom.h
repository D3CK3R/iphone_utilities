#import <Foundation/Foundation.h>


@interface PXRUniqueRandom : NSObject {
	int min;
	int max;
	NSMutableArray *log;
}
- (id)initWithMin:(int)mini andMax:(int)maxi;
- (void)setRangeWithMin:(int)mini andMax:(int)maxi;
- (int)getUnique;
- (void)reset;



@end
