
#import <Foundation/Foundation.h>
#import "BlePluginHelper.h"
#import "NewBle.h"
#import "BleSDK.h"
#import "PrefixHeader.pch"


@implementation BlePluginHelper
    
-(void) setUpDelegate {
    [NewBle sharedManager].delegate = self;
}

-(void) connectDeviceName:(CBPeripheral *)peripheral {
    [self stopScan];
    [[NewBle sharedManager] connectDevice:peripheral];
}

-(void) scanDevice {
    if([NewBle sharedManager].activityPeripheral.state == 2) {
        [[NewBle sharedManager] Disconnect];
        [self performSelector:@selector(findMyBle) withObject:nil afterDelay:1];
    } else {
        [self findMyBle];
    }
}

-(void)EnableCommunicate
{
    NSLog(@"Enable Communicate");
    NSData * data;
    data = [[BleSDK sharedManager] GetSingleHRDataWithMode:0 withStartDate:nil];
    [[NewBle sharedManager] writeValue:SERVICE characteristicUUID:SEND_CHAR p:[NewBle sharedManager].activityPeripheral data:data];

    
}

-(void) BleCommunicateWithPeripheral:(CBPeripheral *)Peripheral data:(NSData *)data {
    DeviceData * deviceData = [[DeviceData alloc] init];
    deviceData  = [[BleSDK sharedManager] DataParsingWithData:data];
    NSLog(@"data: ",deviceData.dicData);
    int count = 0;
    BOOL end = deviceData.dataEnd;
    if(deviceData.dataType == DynamicHR)
    {
        
        /*  NSDictionary * dicData = @{@"date":strDate,@"arrayHR":arrayDynamic};*/
        count +=1;
        NSDictionary * dicData = deviceData.dicData;
        NSArray * arrayDynamicHR = dicData[@"arrayContinuousHR"];
        for (int i = 0; i< arrayDynamicHR.count; i++) {
            NSString * strTemp;
            NSDictionary * dic = arrayDynamicHR[i];
            NSArray * arrayHR = dic[@"arrayHR"];
            NSString * strArrayHR = [arrayHR componentsJoinedByString:@","];
            strTemp = [NSString stringWithFormat:@"date : %@\nheartbeatPerMinute : %@\n\n\n",dic[@"date"],strArrayHR];
            NSLog(strTemp);
        }
        if(count==50&&end==NO)
        {
            // 继续读取剩下的数据
            NSData * data = [[BleSDK sharedManager] GetContinuousHRDataWithMode:2 withStartDate:nil];
            [[NewBle sharedManager] writeValue:SERVICE characteristicUUID:SEND_CHAR p:[NewBle sharedManager].activityPeripheral data:data];
        }
        else if(end==YES)
        {
            
//            if(strText.length>0)
//                _textViewData.text = strText;
//            else
//                _textViewData.text = LocalForkey(@"无数据");
        }
    }
    if(deviceData.dataType == StaticHR)
    {
        count +=1;
        NSDictionary * dicData = deviceData.dicData;
        NSArray * arrayStaticHR = dicData[@"arraySingleHR"];
        for (int i = 0; i< arrayStaticHR.count; i++) {
            NSString * strTemp;
            NSDictionary * dic = arrayStaticHR[i];
            strTemp = [NSString stringWithFormat:@"date : %@\nheartbeatPerMinute : %@\n\n\n",dic[@"date"],dic[@"singleHR"]];
           // strText  = [strText stringByAppendingString:strTemp];
            NSLog(strTemp);

        }
        
        
        if(count==50&&end==NO)
        {
            // 继续读取剩下的数据
            NSData * data = [[BleSDK sharedManager] GetSingleHRDataWithMode:2 withStartDate:nil];
            [[NewBle sharedManager] writeValue:SERVICE characteristicUUID:SEND_CHAR p:[NewBle sharedManager].activityPeripheral data:data];
        }
        else if(end==YES)
        {
//
//            if(strText.length>0)
//                _textViewData.text = strText;
//            else
//                _textViewData.text = LocalForkey(@"无数据");
        }
    }}

-(void) setUpCentralManager {
    [[NewBle sharedManager] SetUpCentralManager];
    [self setUpDelegate];
}

-(void) findMyBle {
    NSArray * bleArray = [[NewBle sharedManager]  retrieveConnectedPeripheralsWithServices:@[[CBUUID UUIDWithString:@"0xfff0"]]];
    if(bleArray.count>0)
    {
        //        [[MyBle sharedManager] connectPeripheral:bleArray.lastObject];
        for (int i = 0; i<[bleArray count]; i++) {
            CBPeripheral * ble = [bleArray objectAtIndex:i];
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:0],@"RSSI",[NSNumber numberWithBool:YES],@"IsConnect", nil];
//            [arrayPeripheral addObject:ble];
//            [arrayPeripheralStatus addObject:dic];
        }
        
    }
    
    
    [[NewBle sharedManager] startScanningWithServices:nil];
}

-(void) stopScan {
    [[NewBle sharedManager] Stopscan];
}

-(void) ConnectSuccessfully {
    NSLog(@"Connect Successfull");
}

-(void) scanWithPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    int value = RSSI.intValue;
    if(value<0&&value>=-70){
        NSString * strName = peripheral.name;
        if(strName.length==0)
            strName = @"j-style";
        //        if([arrayPeripheral containsObject:peripheral])
        //        {
        //            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:RSSI,@"RSSI",[NSNumber numberWithBool:NO],@"IsConnect", nil];
        //            NSUInteger index = [arrayPeripheral indexOfObject:peripheral];
        //            [arrayPeripheralStatus replaceObjectAtIndex:index withObject:dic];
        //        }
        //        else
        //        {
        //            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:RSSI,@"RSSI",NO,@"IsConnect", nil];
        //            [arrayPeripheral addObject:peripheral];
        //            [arrayPeripheralStatus addObject:dic];
        //        }
        //        [myTableView reloadData];
        [self.bleDelegate returnPeripheral:peripheral];
    }
}

@end

