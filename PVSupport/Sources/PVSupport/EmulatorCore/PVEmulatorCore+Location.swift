//
//  PVEmulatorCore+Location.swift
//  PVSupport
//
//  Created by Joseph Mattiello on 8/2/22.
//  Copyright © 2022 Provenance Emu. All rights reserved.
//

import Foundation
import CoreLocation

fileprivate let g_locationManager: CLLocationManager = CLLocationManager()

@objc public extension PVEmulatorCore {
    @objc func locationStart() -> Bool {
#if os(iOS)
        g_locationManager.startUpdatingLocation()
        return true
#else
        return false
#endif
    }
    
    @objc func locationStop() {
#if os(iOS)
        g_locationManager.stopUpdatingLocation()
#endif
    }
    
    @objc func setLocationInterval(_ ms: UInt, distance : UInt) {
#if os(iOS)
//        g_locationManager.desiredAccuracy = distance
        g_locationManager.distanceFilter = Double(distance)
        g_locationManager.activityType = .otherNavigation
#endif
    }
    
    @objc func locationGetPosition(latitude: UnsafeMutablePointer<Double>, longitude: UnsafeMutablePointer<Double>, horizontalAccuracy: UnsafeMutablePointer<Double>, verticleAccuracy: UnsafeMutablePointer<Double>) -> Bool {
        guard let location = g_locationManager.location else { return false }
        latitude.pointee = location.coordinate.latitude
        longitude.pointee = location.coordinate.longitude
        horizontalAccuracy.pointee = location.horizontalAccuracy
        verticleAccuracy.pointee = location.verticalAccuracy
        return true
    }
}
