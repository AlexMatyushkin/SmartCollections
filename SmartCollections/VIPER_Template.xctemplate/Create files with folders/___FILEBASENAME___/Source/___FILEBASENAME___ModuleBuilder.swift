//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit


final class ___VARIABLE_productName:identifier___ModuleBuilder {
	
	
	// MARK: Public
	
	func build() -> UIViewController {
		let interactor = ___VARIABLE_productName:identifier___Interactor()
		let router = ___VARIABLE_productName:identifier___Router()
		let preseneter = ___VARIABLE_productName:identifier___Presenter(interactor: interactor, router: router)
		let view = ___VARIABLE_productName:identifier___View(output: preseneter)
		
		preseneter.view = view
		router.viewController = view
		interactor.output = preseneter
		
		return view
	}
}
