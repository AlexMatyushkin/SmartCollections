//
//  SmartTableViewController.swift
//  NRUIKit
//
//  Created by Aleksey Matyushkin on 08.06.2021.
//

import UIKit

public final class SmartTableViewController: NSObject {
	
	// MARK: Public properties
	
	private weak var tableView: UITableView?
	
	
	// MARK: Private properties
	
	private var dataViewModel = SmartDataViewModel(sections: [])
	private var cellSize: CGSize = .init(width: 56, height: 100)
	
	private weak var delegate: SmartTableViewControllerDelegate?
	
	
	
	// MARK: Lifecycle
	
	public init(delegate: SmartTableViewControllerDelegate,
				tableView: UITableView? = nil) {
		self.delegate = delegate
		self.tableView = tableView
		super.init()
		self.tableView?.dataSource = self
		self.tableView?.delegate = self
	}
	
	// MARK: Public functions
	
	public func setDataViewModel(_ data: SmartDataViewModel) {
		delegate?.wantsToRegisterViewModelsForCells(smartTableViewController: self)
		delegate?.wantsToRegisterViewModelsForHeaders(smartTableViewController: self)
		dataViewModel = data
		tableView?.reloadData()
	}
	
	public func setCellSize(_ size: CGSize) {
		cellSize = size
	}
	
	public func clearCollectionView() {
		dataViewModel = .init(sections: [.init(cells: [])])
		tableView?.reloadData()
	}
	
	public func registerCells(_ cells: [SmartCellModelProtocol.Type]) {
		cells.forEach {
			tableView?.register($0.viewClass, forCellReuseIdentifier: $0.identifier)
		}
	}
	
	public func registerHeadersOrFooters(_ headers: [SmartCellModelProtocol.Type]) {
		headers.forEach {
			tableView?.register($0.viewClass, forHeaderFooterViewReuseIdentifier: $0.identifier)
		}
	}
}

extension SmartTableViewController: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		return dataViewModel.sections.count
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataViewModel.sections[section].cells.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = dataViewModel.sections[indexPath.section].cells[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: type(of: model).identifier, for: indexPath)
		model.configureAbstract(cell)

		return cell
	}
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let headerViewModel = dataViewModel.sections[section].header else {
			return nil
		}
		
		guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: type(of: headerViewModel).identifier) else { return nil
		}

		headerViewModel.configureAbstract(view)

		return view
	}
}

extension SmartTableViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didTapOn(indexPath: indexPath)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		guard let modelItemHeight = dataViewModel.sections[section].header?.itemHeight() else {
			return UITableView.automaticDimension
		}

		return modelItemHeight
	}

	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		guard let modelItemHeight = dataViewModel.sections[section].footer?.itemHeight() else {
			return UITableView.automaticDimension
		}

		return modelItemHeight
	}
}
