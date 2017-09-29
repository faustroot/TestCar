//
//  TCMainDataSource.swift
//  TestCar
//
//  Created by Aleksandr Boev on 29.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import Foundation
import AFNetworking

class TCMainDataSource: TCDataSourceProtocol
{
	//MARK: - Constants
	private let kURLString = "http://www.codetalk.de/cars.json"

	//MARK: - Propertys
	private var loadedItems = [AnyClass]()
	private let sessionManager: AFHTTPSessionManager

	//MARK: - Getters
	var items: [AnyClass]
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
			self.kURLString,
			parameters: nil,
			progress: nil,
			success:
				{
					(anOperation, aResponseObject) in
					// build items
					aComplettion(nil)
				},
			failure:
				{
					(anOperation, anError) in

					aComplettion(anError)
				}
			)
		
	}
}
