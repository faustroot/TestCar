//
//  TCMainDataSource.swift
//  TestCar
//
//  Created by Aleksandr Boev on 29.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import Foundation
import AFNetworking

class TCMainDataSource: TCMainDataSourceProtocol
{
	enum TCMainDataSourceError : Error
	{
		case ParsingJson
		case ParsingJsonItem
		
		func localazedDescription() -> String
		{
			switch self
			{
				case .ParsingJson:
					return "Json has wrong format"

				case .ParsingJsonItem:
					return "Json item has wrong format"
			}
		}
	}
	
	enum Keys
	{
		static let Url = "http://www.codetalk.de/cars.json"
	}

	//MARK: - Propertys
	private var loadedItems = [TCCarModel]()
	private let sessionManager: AFHTTPSessionManager

	//MARK: - Getters
	var items: [TCCarModel]
	{
		return self.loadedItems
	}

	//MARK: - Lifecycle
	init(sessionManager aSessionManager:AFHTTPSessionManager)
	{
		self.sessionManager = aSessionManager
	}
	
	//MARK: - TCDataSourceProtocol
	func loadData(_ aComplettion: @escaping (Error?) -> ())
	{
		self.sessionManager.get(
			TCMainDataSource.Keys.Url,
			parameters: nil,
			progress: nil,
			success:
				{
					(anOperation, aResponseObject) in
					
					guard let responseJSON = aResponseObject as? [[String : Any]] else
					{
						aComplettion(TCMainDataSourceError.ParsingJson)
						return
					}
					self.buildItemsFrom(json: responseJSON, completion: aComplettion)
				},
			failure:
				{
					(anOperation, anError) in

					aComplettion(anError)
				})
	}

	//MARK: - Helpers
	func buildItemsFrom(json aJSON: [[String : Any]], completion aComplettion: @escaping (Error?) -> ())
	{
		for JSONItem in aJSON
		{
			guard let item = TCCarModel(json: JSONItem) else
			{
				aComplettion(TCMainDataSourceError.ParsingJsonItem)
				return
			}
			
			self.loadedItems.append(item)
		}
		
		aComplettion(nil)
	}
}
