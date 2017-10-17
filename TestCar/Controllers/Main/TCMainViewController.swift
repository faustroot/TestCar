//
//  TCMainViewController.swift
//  TestCar
//
//  Created by Aleksandr Boev on 29.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import UIKit
import AFNetworking

class TCMainViewController: UIViewController
{
	private enum TCMainViewControllerChildController: Int
	{
		case list = 0
 		case map = 1
	}

	private enum Keys
	{
		static let ListViewControllerIdentifier = "TCListViewController"
		static let MapViewControllerIdentifier = "TCMapViewController"
	}

	//MARK: - IBOutlet
	@IBOutlet private weak var segmentedControl: UISegmentedControl!
	@IBOutlet private weak var containerView: UIView!
	
	//MARK: - Propertys
	private var dataSource: TCMainDataSource!
	private var currentChildViewController: (UIViewController & TCMainChildViewControllerProtocol)?

	//MARK: - Lifecycle
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.presetupe()
		self.dataSource.loadData
			{
				(anError) in
				
				if let error = anError
				{
					print(error)
				}
				else
				{
					self.currentChildViewController?.items = self.dataSource.items
				}
			}
	}
	
	private func presetupe()
	{
		self.dataSource = TCMainDataSource(sessionManager: AFHTTPSessionManager())
		self.updateContainerView()
	}
	
	private func updateContainerView()
	{
		if let childViewController = self.currentChildViewController
		{
			childViewController.willMove(toParentViewController: nil)
			childViewController.view.removeFromSuperview()
			childViewController.removeFromParentViewController()
		}
	
		let typeNewViewController =
			TCMainViewControllerChildController(rawValue: self.segmentedControl.selectedSegmentIndex)!
	
		if let viewController = self.viewController(type: typeNewViewController)
		{
			self.addChildViewController(viewController)
			self.containerView.addSubview(viewController.view)
			viewController.view.frame = self.containerView.bounds;
			viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			viewController.didMove(toParentViewController: self)
			
			self.currentChildViewController =
				(viewController as! UIViewController & TCMainChildViewControllerProtocol)
			self.currentChildViewController?.items = self.dataSource.items
		}
	}

	//MARK: - Actions
	@IBAction private func selectedControlDidChanged(_ sender: Any)
	{
		self.updateContainerView()
	}
	
	//MARK: - Helpers
	private func viewController(type aType: TCMainViewControllerChildController) -> UIViewController?
	{
		switch aType
		{
			case .list:
				return self.storyboard?.instantiateViewController(withIdentifier: TCMainViewController.Keys.ListViewControllerIdentifier)
				
			case .map:
				return self.storyboard?.instantiateViewController(withIdentifier: TCMainViewController.Keys.MapViewControllerIdentifier)
		}
	}


}

