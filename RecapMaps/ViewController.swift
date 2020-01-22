//
//  ViewController.swift
//  RecapMaps
//
//  Created by mobapp02 on 15/01/2020.
//  Copyright © 2020 Floating Reels. All rights reserved.
//

import UIKit
//importeer de mapkit library
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    //maak een location manager aan
    let locationManager = CLLocationManager.init()
    //maak een referentie naar de datasource
    var pojData:POJDataSource? = POJDataSource.init()
    
    //maak outlet aan voor je mapview
    @IBOutlet weak var jesusMV: MKMapView!
    
    
    //long press gesture moet een actie uitvoeren
    @IBAction func longPressPin(_ sender: UILongPressGestureRecognizer) {
        //om te vermijden dat je meerdere pins plaatst bij longpress
        if sender.state != UIGestureRecognizer.State.began {
            return
        }
        //het fysiek punt in je scherm (pixel) waar je longpresst wordt gestuurd naar je mapview
        let pressedPoint = sender.location(in: self.jesusMV)
        //de pixel in het scherm waar je drukt wordt omgezet naar coordinaten in je mapview
        let coordFromPoint = self.jesusMV.convert(pressedPoint, toCoordinateFrom: self.jesusMV)
        
        //aanmaken alertcontroller
        let alert = UIAlertController.init(title: "Point of Jesus",
                                           message: "Where are you currently searching?",
                                           preferredStyle: .alert)
        //textfield handler aanmaken
        //hoe moet het keyboard ingesteld worden
        let tfHandler = {(locationTF:UITextField) -> Void in
            locationTF.keyboardType = .default
            locationTF.keyboardAppearance = .dark
            locationTF.backgroundColor = UIColor.red}
        //toevoegen cancel actie
        let cancelAction = UIAlertAction.init(title: "Cancel",
                                              style: .cancel,
                                              handler: nil)
        //ok handler aanmaken, wat uitvoeren als we op knop duwen
        let okActionHandler = {(action:UIAlertAction) -> Void in
            //tekst uit de inputfield halen
            let inputText:String = alert.textFields![0].text!
            print(inputText)
            //tekst uit de input field opslaan in mijn object
            let pinFromPoint:PointOfJesus = PointOfJesus.init(coordinate: coordFromPoint, title: inputText)
            //voeg pin toe aan mapview
            self.jesusMV.addAnnotation(pinFromPoint)
            //
            self.pojData!.points.append(pinFromPoint)
            
        }
        //ok handler aan ok button koppelen
        let okAction = UIAlertAction.init(title: "OK",
                                          style: .default,
                                          handler: okActionHandler)
        //de aangemaakte actions  toevoegen aan de alert
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addTextField(configurationHandler: tfHandler)
        
        //hoe moet de alert worden weergegeven
        self.present(alert, animated: true, completion: nil)
    }
       
        override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        locationManager.delegate=self
        //laat je locationmanager vragen om toelating je huidige locatie te kennen
        //        locationManager.requestWhenInUseAuthorization()
        
        //voeg de objecten uit datasource toe aan de kaart
        jesusMV.addAnnotations(pojData!.points)
    }
    
    //de segmented controller moet een actie uitvoeren
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        //elke case laadt een andere soort map
        switch sender.selectedSegmentIndex {
        case 0: jesusMV.mapType = .standard
        case 1: jesusMV.mapType = .satellite
        case 2: jesusMV.mapType = .hybrid
        //je moet je code kunnen opvangen moest hij geen van de cases vinden
        default: print("kan niet")
        }
    }
    
}

extension ViewController: MKMapViewDelegate {
    //functie om de aangemaakte annotaties een customview te geven
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //eerst checken of de locatie al bestaat in datasource
        if let poj = annotation as? PointOfJesus {
            //gaat zien of er al een herbruikbare pin (customview) in mapview bestaat
            if let customView = jesusMV.dequeueReusableAnnotationView(withIdentifier: "pin") {
                //geeft de customview de eigenschappen van je eingen klasse
                customView.annotation = poj
                //toon de customview
                return customView
            } else {
                //maak een nieuwe view aan met de annotatie uit je eigen klasse en herbruikbare ID
                let customView = MKPinAnnotationView.init(annotation: poj, reuseIdentifier: "pin")
                
                //geef kleur aan je customview
                customView.pinTintColor = UIColor.blue
                customView.animatesDrop = true
                //toon de var subtitle uit eigen klasse
                customView.canShowCallout = true
                
                //toon de customview
                return customView
            }
        }
        //je moet code opvangen moest hij geen annotaties vinden
        return nil
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let visibleRegion = MKCoordinateRegion.init(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        jesusMV.region = visibleRegion
    }
    
}
