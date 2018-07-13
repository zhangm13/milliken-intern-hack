//
//  ViewController.swift
//  Frank, Prince, Albert, Michael Zhang, Marley Xiong
//
//  Created by Frank Dong on 2018-07-12.
//  Copyright © 2018 Frank Dong. All rights reserved.
//



import UIKit
import MapKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //Map
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var labelcool: UILabel!
    
    var type = "regtype"
    
    //timer
    var timer: Timer!
    
    //list of globals popN
    var popA = Int(arc4random_uniform(16))
    var popB = Int(arc4random_uniform(21))
    var popC = Int(arc4random_uniform(31))
    var popD = Int(arc4random_uniform(35))
    
    let locationManager = CLLocationManager()
    // draw circle
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in  })
        
        let content = UNMutableNotificationContent()
        content.title = "Lab Area Alert"
        if type == "areaA" {
                content.body = "You are in Area A - Ayyy"
        }
        else if type == "areaB" {
                content.body = "You are in Area B - Be cool!"
        }
        else if type == "areaC" {
                content.body = "You are in Area C - Cool Beans!"
        }
        else if type == "areaD"{
                content.body = "You are in Area D - Dude!"
        }
        
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // setup locationManager
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        // setup map
        
        self.map.delegate = self
        self.map.showsUserLocation = true
        self.map.userTrackingMode = .follow
        
        setupData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // status is not determined
            locationManager.requestAlwaysAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            // authorization were denied
            showAlert("Location services were previously denied. Please enable location services for this app in Settings.")
        } else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            // we do have authorization
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func setupData() {
        // check if system can monitor regions
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
           
            //-------------------A------------------------------------------------
            
            
            // region data
            var title = "IBM Markham Building A"
            type = "areaA"
            //need to specify type of expense
            var coordinate = CLLocationCoordinate2DMake(43.848868, -79.339597)
            var regionRadius = 30.0
            
            // setup region
            var region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                         longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            // setup annotation
            var restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            restaurantAnnotation.subtitle = "Population: " + "\(popA)";
            restaurantAnnotation.subtitle?.append("\n Availability: Available \n Average Population in the Week: 10 \n Store Times: 9am-5pm \n Best Times: 10am-11am \n Worst Times: 9am-10am, 12pm - 5pm")
            
            map.addAnnotation(restaurantAnnotation)
            
            // setup circle
            var circle = MKCircle(center: coordinate, radius: regionRadius)
            map.add(circle)
            
            
            
            //-------------------B------------------------------------------------
            
            // region data
            title = "IBM Markham Building B"
            type = "areaB"
            //need to specify type of expense
            coordinate = CLLocationCoordinate2DMake(43.848644, -79.338733)
            regionRadius = 30.0
            
            // setup region
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                     longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            // setup annotation
            restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            restaurantAnnotation.subtitle = "Population: " + "\(popB)";
            restaurantAnnotation.subtitle?.append("\n Availability: Busy \n Average Population in the Week: 20 \n Store Times: 9am-5pm \n Best Times: 10am-11am \n Worst Times: 9am-10am, 12pm - 5pm")
            map.addAnnotation(restaurantAnnotation)
            
            // setup circle
            circle = MKCircle(center: coordinate, radius: regionRadius)
            map.add(circle)
            
            //-------------------C------------------------------------------------
            
            // region data
            title = "IBM Markham Building C"
            type = "areaC"
            //need to specify type of expense
            coordinate = CLLocationCoordinate2DMake(43.848783, -79.337885)
            regionRadius = 30.0
            
            // setup region
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                     longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            // setup annotation
            restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            restaurantAnnotation.subtitle = "Population: " + "\(popC)";
            restaurantAnnotation.subtitle?.append("\n Availability: Available \n Average Population in the Week: 30 \n Store Times: 9am-5pm \n Best Times: 10am-11am \n Worst Times: 9am-10am, 12pm - 5pm")
            map.addAnnotation(restaurantAnnotation)
            
            // setup circle
            circle = MKCircle(center: coordinate, radius: regionRadius)
            map.add(circle)
            
            //-------------------D------------------------------------------------
            
            // region data
            title = "IBM Markham Building D"
            type = "areaA"
            //need to specify type of expense
            coordinate = CLLocationCoordinate2DMake(43.849201, -79.337225)
            regionRadius = 30.0
            
            // setup region
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                                                     longitude: coordinate.longitude), radius: regionRadius, identifier: title)
            locationManager.startMonitoring(for: region)
            
            // setup annotation
            restaurantAnnotation = MKPointAnnotation()
            restaurantAnnotation.coordinate = coordinate;
            restaurantAnnotation.title = "\(title)";
            restaurantAnnotation.subtitle = "Population: " + "\(popD)";
            restaurantAnnotation.subtitle?.append("\n Availability: Super Busy! \n Average Population in the Week: 30 \n Store Times: 9am-5pm \n Best Times: 10am-11am \n Worst Times: 9am-10am, 12pm - 5pm")
            map.addAnnotation(restaurantAnnotation)
            
            // setup circle
            circle = MKCircle(center: coordinate, radius: regionRadius)
            map.add(circle)
            
        }
        else {
            print("System can't track regions")
        }
    }
    
    //problem
    var entrytime = NSDate()
    var entered = false
    //var monitoredRegions: Dictionary<String, NSDate> = [:]
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //showAlert("enter \(region.identifier)")
        if (entered == false) {
            entrytime = NSDate()
        }
        entered = true
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        //showAlert("exit \(region.identifier)")
        
        entered = false
        
    }
    
    //updates regularly
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (entered == true) {
            updateRegions()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    //checks if user has been in proximity for x period of time
    func updateRegions() {
            if type == "areaA" {
                let temp1 = "You have entered a new area"
                self.labelcool.text = temp1
                showAlert(temp1)
            }
            else if type == "areaB" {
                let temp2 = "You have entered a new area"
                self.labelcool.text = temp2
                showAlert(temp2)
            }
            else if type == "areaC" {
                let temp3 = "You have entered a new area"
                self.labelcool.text = temp3
                showAlert(temp3)
            }
            else if type == "areaD" {
                let temp4 = "You have entered a new area"
                self.labelcool.text = temp4
                showAlert(temp4)
            }
            
            entered = false
        
        let content = UNMutableNotificationContent()
        content.subtitle = "DenCity Notification"
        if type == "areaA" {
            let temp1 = "You are in area A"
            content.body = temp1
        }
        else if type == "areaB" {
            content.body = ("You are in area B")
        }
        else if type == "areaC" {
            content.body = ("You are in area C")
        }
        else if type == "areaD" {
            content.body = ("You are in area D")
        }
        //content.body = "Remember your budget for _____ is $_____"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //show alert
    func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func runTimedCode(){
        popA = Int(arc4random_uniform(16))
        popB = Int(arc4random_uniform(21))
        popC = Int(arc4random_uniform(31))
        popD = Int(arc4random_uniform(35))
        
        self.setupData()
    }
    
}




