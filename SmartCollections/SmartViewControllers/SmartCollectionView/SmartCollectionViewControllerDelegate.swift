//
//  SmartCollectionViewProtocol.swift
//  NRUIKit
//
//  Created by Aleksey Matyushkin on 03.06.2021.
//

import UIKit

public protocol SmartCollectionViewControllerDelegate: AnyObject {
	func viewWantsToRegisterViewModelsFor(smartCollectionViewController: SmartCollectionController)
	func didTapOn(indexPath: IndexPath)
}
