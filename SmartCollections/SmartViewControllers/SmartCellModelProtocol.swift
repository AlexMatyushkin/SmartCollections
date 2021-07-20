//
//  SmartCollectionViewCellModelProtocol.swift
//  NRUIKit
//
//  Created by Aleksey Matyushkin on 31.05.2021.
//

import UIKit

public protocol SmartCellModelProtocol {

	static var identifier: String { get }
	static var viewClass: UIView.Type { get }
	
	func configureAbstract(_ view: UIView)
	func itemHeight() -> CGFloat?
}

public extension SmartCellModelProtocol {

	static var identifier: String {
		return String(describing: viewClass) + "ReuseIdentifier"
	}

}

public protocol SmartModelProtocol: SmartCellModelProtocol {

	associatedtype ViewType: UIView
	func configure(_ view: ViewType)
}


extension SmartModelProtocol {

	public func configureAbstract(_ view: UIView) {
		configure(view as! ViewType )
	}

	public static var viewClass: UIView.Type {
		return ViewType.self
	}

	public func itemHeight() -> CGFloat? {
		return nil
	}
}

public struct AnyViewModel: SmartCellModelProtocol {

	public static var viewClass: UIView.Type {
		return UIView.self
	}
	
	public static var view: UIView {
		return UIView()
	}

	private let _viewModel: SmartCellModelProtocol

	init(_ viewModel: SmartCellModelProtocol) {
		_viewModel = viewModel
	}

	public func configureAbstract(_ view: UIView) {
		_viewModel.configureAbstract(view)
	}

	public func itemHeight() -> CGFloat? {
		return _viewModel.itemHeight()
	}
}

public struct SectionViewModel {
	let header: SmartCellModelProtocol?
	let cells: [SmartCellModelProtocol]
	let footer: SmartCellModelProtocol?
	
	public init(cells: [SmartCellModelProtocol],
				header: SmartCellModelProtocol? = nil,
				footer: SmartCellModelProtocol? = nil) {
		self.cells = cells
		self.header = header
		self.footer = footer
	}
}

public struct SmartDataViewModel {
	let sections: [SectionViewModel]
	
	public init(sections: [SectionViewModel]) {
		self.sections = sections
	}
}
