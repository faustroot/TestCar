//
//  TCMainDataSourceProtocol.swift
//  TestCar
//
//  Created by Aleksandr Boev on 29.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import Foundation

protocol TCMainDataSourceProtocol
{
	var items : [TCCarModel] {get}
	
	func loadData(_ aComplettion: @escaping (_ anError: Error?)->())
}
