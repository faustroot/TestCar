//
//  TCListViewController.swift
//  TestCar
//
//  Created by Aleksandr Boev on 30.09.17.
//  Copyright © 2017 Aleksandr Boev. All rights reserved.
//

import UIKit

class TCListViewController: UIViewController, TCMainChildViewControllerProtocol, UITableViewDelegate,
	UITableViewDataSource
{
	enum Keys
	{
		static let CellIdentifier = "TCListTableViewwCell"
		static let CellHeight: CGFloat = 100.0
	}

	//MARK: - IBOutlet
	@IBOutlet private weak var tableView: UITableView!
	
	//MARK: - Propertys
	var items: [TCCarModel] = [TCCarModel]()
	{
		didSet
		{
			self.tableView?.reloadData()
		}
	}
	
	//MARK: - Helpers
	private func carDetailView(carModel aCarModel: TCCarModel) -> UIView
	{
		let carDetailView = TCCarDetailView.tc_viewFromNib() as! TCCarDetailView
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
	
	//MARK: - UITableViewDelegate
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return TCListViewController.Keys.CellHeight
	}

	//MARK: - UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell =
			tableView.dequeueReusableCell(withIdentifier: TCListViewController.Keys.CellIdentifier ) as! TCListTableViewCell
		cell.addDitail(view: self.carDetailView(carModel: self.items[indexPath.row]))

		return cell
	}
}
