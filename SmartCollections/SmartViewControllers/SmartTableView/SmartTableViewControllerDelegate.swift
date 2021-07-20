//
//  SmartTableViewControllerDelegate.swift
//  NRUIKit
//
//  Created by Aleksey Matyushkin on 08.06.2021.
//

import Foundation

public protocol SmartTableViewControllerDelegate: AnyObject {
	func wantsToRegisterViewModelsForCells(smartTableViewController: SmartTableViewController)
	func wantsToRegisterViewModelsForHeaders(smartTableViewController: SmartTableViewController)
	func didTapOn(indexPath: IndexPath)
}
