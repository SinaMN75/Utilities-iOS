//  Created by SinaMN75 on 8/12/19.
//  Copyright © 2019 SinaMN75. All rights reserved.

import UIKit
import SystemConfiguration

func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress) }
    }
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false { return false }
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return ((flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0 && !needsConnection)
}

func grgToSh(gerogorianDateString:String) -> String {
    var dateString = gerogorianDateString
    if dateString.count == 10 { dateString += " 00:00:00" }
    if dateString.count > 19 { dateString = String(dateString.dropLast(dateString.count - 19)) }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let gerogorianDate = formatter.date(from: dateString)
    formatter.dateFormat = "yyyy/MM/dd"
    formatter.calendar = Calendar(identifier: .persian)
    if let date = gerogorianDate { return formatter.string(from: date) }
    return ""
}

func versionName() -> String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }

func versionCode() -> String { return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String }

func versionBuild() -> String {
    let version = versionName(), build = versionCode()
    return version == build ? "v\(version)" : "v\(version)(\(build))"
}

extension Array where Element: Equatable {

    mutating func remove(object: Element) {
        if let index = firstIndex(of: object) { remove(at: index) }
    }
}
