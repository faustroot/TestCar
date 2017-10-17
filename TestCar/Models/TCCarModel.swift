//
//  TCCarModel.swift
//  TestCar
//
//  Created by Aleksandr Boev on 30.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import Foundation
import MapKit

class TCCarModel: NSObject, MKAnnotation
{
	private enum Keys
	{
		static let Identifier = "id"
		static let ModelIdentifier = "modelIdentifier"
		static let ModelName = "modelName"
		static let Name = "name"
		static let Make = "make"
		static let Group = "group"
		static let Color = "color"
		static let Series = "series"
		static let FuelType = "fuelType"
		static let FuelLevel = "fuelLevel"
		static let Transmission = "transmission"
		static let LicensePlate = "licensePlate"
		static let Latitude = "latitude"
		static let Longitude = "longitude"
		static let InnerCleanliness = "innerCleanliness"
		static let CarImageUrl = "carImageUrl"
	}

	//MARK: - Propertys
	let identifier: String
	let modelIdentifier: String
	let modelName: String
	let name: String
	let make: String
	let group: String
	let color: String
	let series: String
	let fuelType: String
	let fuelLevel: Float
	let transmission: String
	let licensePlate: String
	let latitude: Double
	let longitude: Double
	let innerCleanliness: String
	let carImageUrl: String
	
	//MARK - Getters
	public var coordinate: CLLocationCoordinate2D
	{
		return CLLocation(latitude: self.latitude, longitude: self.longitude).coordinate
	}
	
	var title: String? { return " " }
	
	//MARK: - Lifecycle
    init?(json aJSON: [String : Any])
    {
		guard let identifier = aJSON[TCCarModel.Keys.Identifier] as? String,
			let modelIdentifier = aJSON[TCCarModel.Keys.ModelIdentifier] as? String,
			let modelName = aJSON[TCCarModel.Keys.ModelName] as? String,
			let name = aJSON[TCCarModel.Keys.Name] as? String,
			let make = aJSON[TCCarModel.Keys.Make] as? String,
			let group = aJSON[TCCarModel.Keys.Group] as? String,
			let color = aJSON[TCCarModel.Keys.Color] as? String,
			let series = aJSON[TCCarModel.Keys.Series] as? String,
			let fuelType = aJSON[TCCarModel.Keys.FuelType] as? String,
			let transmission = aJSON[TCCarModel.Keys.Transmission] as? String,
			let licensePlate = aJSON[TCCarModel.Keys.LicensePlate] as? String,
			let latitude = aJSON[TCCarModel.Keys.Latitude] as? Double,
			let longitude = aJSON[TCCarModel.Keys.Longitude] as? Double,
			let innerCleanliness = aJSON[TCCarModel.Keys.InnerCleanliness] as? String else
			{
				return nil
			}
		
		self.identifier = identifier
		self.modelIdentifier = modelIdentifier
		self.modelName = modelName
		self.name = name
		self.make = make
		self.group = group
		self.color = color
		self.series = series
		self.fuelType = fuelType
		self.transmission = transmission
		self.licensePlate = licensePlate
		self.latitude = latitude
		self.longitude = longitude
		self.innerCleanliness = innerCleanliness
		self.carImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/"
			+ "cars/\(self.modelIdentifier)/\(self.color)/2x/car.png"
		
		if let fuelLevel = aJSON[TCCarModel.Keys.FuelLevel] as? Float
		{
			self.fuelLevel = fuelLevel
		}
		else
		{
			self.fuelLevel = 0.0
		}
	}
}
