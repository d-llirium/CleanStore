//
//  ListOrdersPresenter.swift
//  CleanStore
//
//  Created by user on 28/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListOrdersPresentationLogic
{
  func presentSomething(response: ListOrders.Something.Response)
}

class ListOrdersPresenter: ListOrdersPresentationLogic
{
  weak var viewController: ListOrdersDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ListOrders.Something.Response)
  {
    let viewModel = ListOrders.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
