//
//  UIViewAdditions.swift
//  TestCar
//
//  Created by Aleksandr Boev on 01.10.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import UIKit

extension UIView
{
	class func tc_viewFromNib() -> UIView
	{
		return UIView.tc_view(nibName: NSStringFromClass(self).components(separatedBy: ".").last!)
	}

	class func tc_view(nibName aNibName: String) -> UIView
	{
		let nib = UINib(nibName: aNibName, bundle: nil)
		let views = nib.instantiate(withOwner: nil, options: nil)
		return views.first as! UIView
	}
}

