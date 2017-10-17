//
//  TCListTableViewCell.swift
//  TestCar
//
//  Created by Aleksandr Boev on 01.10.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import UIKit

class TCListTableViewCell: UITableViewCell
{
	func addDitail(view aView: UIView)
	{
		let _ = self.subviews.map{ $0.removeFromSuperview() }
		self.addSubview(aView)
		aView.frame = self.bounds
	}
}
