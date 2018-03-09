//
//  ViewController.swift
//  BeaconDemo
//
//  Created by Artur Kokoev on 08.03.18.
//  Copyright © 2018 Artur Kokoev. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BeaconManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = BeaconManager()
    
    var beaconRegions:[CLBeaconRegion] = []
    var beacons:[NSDictionary] = []
    var locationManager:CLLocationManager!
    
    func initilizeBeacons(){
        let path = Bundle.main.path(forResource: "Beacons",
                                    ofType: "plist")
        
        guard let dictionary = NSDictionary(contentsOfFile: path!) else {return}
        
        
        if let beaconArray = dictionary["Beacons"] as?
            [NSDictionary] {
            print(beaconArray)
        }
        
    
    }
    
    
    func initializeLocationManager (completion: @escaping() ->
        Void) {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.allowsBackgroundLocationUpdates =
            true
        completion()
    }
    
    //MARK: Helper
    func createBeaconRegionFor(uuidString:String, majorString: String, minorString: String) -> CLBeaconRegion{
    
        let unique = uuidString.substring(from: uuidString.index(uuidString.endIndex, offsetBy: -4))
        
        let region = CLBeaconRegion(proximityUUID: UUID (uuidString: uuidString)!, major:CLBeaconMajorValue(majorString)!, minor: CLBeaconMinorValue(minorString)!, identifier:
        "com.agi.beacon. \(unique)")
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        return region
        
    }
    
    func getAuthorizationStatus(status: CLAuthorizationStatus)
        -> String {
            switch status {
            case .authorizedAlways:
                return "Authorization Always"
            case .authorizedWhenInUse:
                return "Authorization When In Use"
            case .denied:
                return "Denied"
            case .notDetermined:
                return "Not Determined"
            case .restricted:
                return "Restricted"
            }
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion){
        locationManager.requestState(for: region)
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 
        print("Failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        //
        print("Failed: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        //
        print("Failed: \(error)")
    }
    
    
}

