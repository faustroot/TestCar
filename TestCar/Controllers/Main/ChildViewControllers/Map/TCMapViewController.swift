//
//  TCMapViewController.swift
//  TestCar
//
//  Created by Aleksandr Boev on 30.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import UIKit
import MapKit

class TCMapViewController: UIViewController, TCMainChildViewControllerProtocol, MKMapViewDelegate
{
	enum Keys
	{
		static let RegionRadius: CLLocationDistance = 2000
		static let AnnotationViewIdentifier = "TCMapAnotationView"
		static let CarDetailViewHeight = 50.0
		static let CarDetailViewWidth = 250.0
	}
	
	//MARK: - IBOutlet
	@IBOutlet weak var mapView: MKMapView!
	
	//MARK: - Propertys
	var items: [TCCarModel] = [TCCarModel]()
	{
		didSet
		{
			if oldValue.count == 0 && self.items.count > 0
			{
				self.centerMap()
			}
			
			self.mapView.removeAnnotations(self.mapView.annotations)
			self.mapView.addAnnotations(self.items)
		}
	}
	
	//MARK: - Helpers
    private func centerMap()
    {
		if let carModelItem = self.items.first
		{
			let coordinateRegion = MKCoordinateRegionMakeWithDistance(carModelItem.coordinate,
				TCMapViewController.Keys.RegionRadius, TCMapViewController.Keys.RegionRadius)
			self.mapView.setRegion(coordinateRegion, animated: true)
		}
	}

	private func carDetailView(carModel aCarModel: TCCarModel) -> UIView
	{
		let carDetailView = TCCarDetailView.tc_viewFromNib() as! TCCarDetailView
		let views = ["carDetailView": carDetailView]
		carDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[carDetailView(\(TCMapViewController.Keys.CarDetailViewWidth))]",
			options: [], metrics: nil, views: views))
		carDetailView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[carDetailView(\(TCMapViewController.Keys.CarDetailViewHeight))]",
			options: [], metrics: nil, views: views))

		carDetailView.carMakeLabel.text = aCarModel.make
		carDetailView.carModelLabel.text = aCarModel.modelName
		carDetailView.carFuelLevelLabel.text = String(format: "%.2f", aCarModel.fuelLevel)
		carDetailView.carTransmissionLabel.text = aCarModel.transmission
		
		if let url  = URL(string: aCarModel.carImageUrl)
		{
			carDetailView.carPreviewImageView.setImageWith(url)
		}

		return carDetailView
	}

	//MARK: - MKMapViewDelegate
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
	{
		guard let carModelItem = annotation as? TCCarModel  else
		{
			return nil
		}
		
		var annotationView: MKAnnotationView?
		if let view =
			mapView.dequeueReusableAnnotationView(withIdentifier: TCMapViewController.Keys.AnnotationViewIdentifier)
		{
			annotationView = view
		}
		else
		{
			annotationView = MKPinAnnotationView(annotation: annotation,
				reuseIdentifier: TCMapViewController.Keys.AnnotationViewIdentifier)
			annotationView?.canShowCallout = true
		}
		
		annotationView?.annotation = annotation
		annotationView?.detailCalloutAccessoryView = self.carDetailView(carModel: carModelItem)
		
		return annotationView
	}
}
