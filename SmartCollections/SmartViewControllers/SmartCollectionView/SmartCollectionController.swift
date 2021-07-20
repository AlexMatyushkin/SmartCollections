//
//  SmartCollectionController.swift
//  NRUIKit
//
//  Created by Aleksey Matyushkin on 31.05.2021.
//

import UIKit

public final class SmartCollectionController: NSObject {
	
	// MARK: Public properties
	
	public weak var collectionView: UICollectionView? {
		didSet {
			collectionView?.dataSource = self
			collectionView?.delegate = self
		}
	}
	
	
	// MARK: Private properties
	
	private var dataViewModel = SmartDataViewModel(sections: [])
	private var cellSize: CGSize = .init(width: 56, height: 100)
	
	private weak var delegate: SmartCollectionViewControllerDelegate?
	
	
	
	// MARK: Lifecycle
	
	init(delegate: SmartCollectionViewControllerDelegate) {
		self.delegate = delegate
		
		super.init()
	}
	
	// MARK: Public functions
	
	public func setDataViewModel(_ data: SmartDataViewModel) {
		delegate?.viewWantsToRegisterViewModelsFor(smartCollectionViewController: self)
		dataViewModel = data
		collectionView?.reloadData()
	}
	
	public func setCellSize(_ size: CGSize) {
		cellSize = size
	}
	
	public func clearCollectionView() {
		dataViewModel = .init(sections: [.init(cells: [])])
		collectionView?.reloadData()
	}
	
	public func registerCells<Cell: SmartCellModelProtocol>(_ cells: [Cell.Type]) {
		cells.forEach {
			collectionView?.register($0.viewClass, forCellWithReuseIdentifier: $0.identifier)
		}
	}
}

extension SmartCollectionController: UICollectionViewDataSource {
	
	public func numberOfSections(in collectionView: UICollectionView) -> Int {
		return dataViewModel.sections.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataViewModel.sections[section].cells.count
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = dataViewModel.sections[indexPath.section].cells[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: model).identifier, for: indexPath)
		model.configureAbstract(cell)

		return cell
	}
}

extension SmartCollectionController: UICollectionViewDelegate {
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didTapOn(indexPath: indexPath)
	}
}

extension SmartCollectionController: UICollectionViewDelegateFlowLayout {
	public func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return cellSize
	}
}
