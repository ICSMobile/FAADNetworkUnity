//
//  FAADDeviceInfo.m
//  FAADConnect
//
//  Created by ICS Mobile on 5/19/11.
//  Copyright 2011 ICS Mobile, Inc. All rights reserved//

#import "FAADDeviceInfo.h"

#include <sys/types.h>
#include <sys/sysctl.h> 
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation UIDevice(Hardware)
//static NSString *mydeviceType = nil;

- (NSString *) platform
{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding: NSUTF8StringEncoding];
	
	free(machine);
	return platform;
}


/**
 * This is not written by me 
 */
static const char* device_string_names[UIDeviceMAX] = 
{
	"Unknown iOS device",
	
	"iPhone Simulator",
	"iPhone Simulator",
	"iPad Simulator",
	
	"iPhone 1G",
	"iPhone 3G",
	"iPhone 3GS",
	"iPhone 4",
	"iPhone 5",
	
	"iPod touch 1G",
	"iPod touch 2G",
	"iPod touch 3G",
	"iPod touch 4G",
	
	"iPad 1G",
	"iPad 2G",
	
	"Unknown iPhone",
	"Unknown iPod",
	"Unknown iPad",
	"iFPGA",
};

- (NSString *) platformString
{
	NSUInteger type = [self platformType];
	return [NSString stringWithUTF8String:device_string_names[type]];
}



- (NSUInteger) platformType{
		NSString *platform = [self platform];
		
		// if ([platform isEqualToString:@"XX"])			
		//	return UIDeviceUnknown;
		
		if ([platform isEqualToString:@"iFPGA"])		
			return UIDeviceIFPGA;
		
		if ([platform isEqualToString:@"iPhone1,1"])	
			return UIDevice1GiPhone;
		
		if ([platform isEqualToString:@"iPhone1,2"])	
			return UIDevice3GiPhone;
		
		if ([platform hasPrefix:@"iPhone2"])	
			return UIDevice3GSiPhone;
		
		if ([platform hasPrefix:@"iPhone3"])			
			return UIDevice4iPhone;
		
		if ([platform hasPrefix:@"iPhone4"])			
			return UIDevice5iPhone;
		
		if ([platform isEqualToString:@"iPod1,1"])   
			return UIDevice1GiPod;
		
		if ([platform isEqualToString:@"iPod2,1"])   
			return UIDevice2GiPod;
		
		if ([platform isEqualToString:@"iPod3,1"])   
			return UIDevice3GiPod;
		
		if ([platform isEqualToString:@"iPod4,1"])   
			return UIDevice4GiPod;
		
		if ([platform isEqualToString:@"iPad1,1"])   
			return UIDevice1GiPad;
		
		if ([platform isEqualToString:@"iPad2,1"])   
			return UIDevice2GiPad;
		
		// MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.
		
		if ([platform hasPrefix:@"iPhone"]) 
			return UIDeviceUnknowniPhone;
		
		if ([platform hasPrefix:@"iPod"]) 
			return UIDeviceUnknowniPod;
		
		if ([platform hasPrefix:@"iPad"]) 
			return UIDeviceUnknowniPad;
		
		if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
		{
			if ([[UIScreen mainScreen] bounds].size.width < 768)
				return UIDeviceiPhoneSimulatoriPhone;
			else 
				return UIDeviceiPhoneSimulatoriPad;
			
			return UIDeviceiPhoneSimulator;
		}
		return UIDeviceUnknown;
}


- (NSString *)getMacAddress
{
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    NSString *errorFlag = NULL;
    size_t length;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    // Get the size of the data available (store in len)
    else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
        errorFlag = @"sysctl mgmtInfoBase failure";
    // Alloc memory based on above call
    else if ((msgBuffer = malloc(length)) == NULL)
        errorFlag = @"buffer allocation failure";
    // Get system information, store in buffer
    else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
    {
        free(msgBuffer);
        errorFlag = @"sysctl msgBuffer failure";
    }
    else
    {
        // Map msgbuffer to interface message structure
        struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
        
        // Map to link-level socket structure
        struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
        
        // Copy link layer address data in socket structure to an array
        unsigned char macAddress[6];
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
        
        // Read from char array into a string object, into traditional Mac address format
        NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                      macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
      //  NSLog(@"Mac Address: %@", macAddressString);
       // NSLog(@"The mac count id %d", [macAddressString length]);
        // Release the buffer memory
        free(msgBuffer);
        
        return macAddressString;
    }
    
    // Error...
   // NSLog(@"Error: %@", errorFlag);
    
    return errorFlag;
}

@end
