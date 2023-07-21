

#import <Foundation/Foundation.h>
#import "NewBle.h"

typedef void (^CompletionScanPeripheral)(CBPeripheral*);

@protocol BlePluginHelperDelegate
-(void)returnPeripheral: (CBPeripheral *) completionScanPeripheral;
@end
@interface BlePluginHelper : NSObject<MyBleDelegate>
    
-(void) setUpDelegate;
-(void) scanDevice;
-(void) setUpCentralManager;
-(void) findMyBle;
-(void) stopScan;
-(void) connectDeviceName: (CBPeripheral *) peripheral;

@property (nonatomic,retain) id<BlePluginHelperDelegate> _Nullable bleDelegate;

@end
