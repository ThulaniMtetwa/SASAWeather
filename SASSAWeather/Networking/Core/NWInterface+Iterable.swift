//
//  NWInterface+Iterable.swift
//  SASSAWeather
//
//  Created by Thulani Mtetwa on 2023/07/08.
//

import Network

extension NWInterface.InterfaceType: CaseIterable {
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
}
