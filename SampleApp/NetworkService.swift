//
//  NetworkService.swift
//  SampleApp
//
//  Created by user on 2019-06-19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import Foundation

enum ConnectionType: String {
    case _WIFI
    case _2G
    case _3G
    case _4G
    case _NONE
    
    func get () -> String {
        let index = self.rawValue.index(self.rawValue.startIndex, offsetBy: 1)
        return self.rawValue[..<index]
    }
}

class NetworkService {
    
    func getNetworkType()->String {
        do{
            let reachability:Reachability = try Reachability.reachabilityForInternetConnection()
            do{
                try reachability.startNotifier()
                let status = reachability.currentReachabilityStatus
                if(status == .NotReachable){
                    return ConnectionType.NONE.get()
                }else if (status == .ReachableViaWiFi){
                    return "Wifi"
                }else if (status == .ReachableViaWWAN){
                    let networkInfo = CTTelephonyNetworkInfo()
                    let carrierType = networkInfo.currentRadioAccessTechnology
                    switch carrierType{
                    case CTRadioAccessTechnologyGPRS?,CTRadioAccessTechnologyEdge?,CTRadioAccessTechnologyCDMA1x?: return "2G"
                    case CTRadioAccessTechnologyWCDMA?,CTRadioAccessTechnologyHSDPA?,CTRadioAccessTechnologyHSUPA?,CTRadioAccessTechnologyCDMAEVDORev0?,CTRadioAccessTechnologyCDMAEVDORevA?,CTRadioAccessTechnologyCDMAEVDORevB?,CTRadioAccessTechnologyeHRPD?: return "3G"
                    case CTRadioAccessTechnologyLTE?: return "4G"
                    default: return ""
                    }
                    
                    
                }else{
                    return ""
                }
            }catch{
                return ""
            }
            
        }catch{
            return ""
        }
        
        
    }
    
}
