//
//  CreateOrderViewController.swift
//  CleanStore
//
//  Created by user on 26/04/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateOrderDisplayLogic: AnyObject //same as the presenter OUTPUT
{
    func displayExpirationDate(
        viewModel: CreateOrder.FormatExpirationDate.ViewModel
    )
}

class CreateOrderViewController: UITableViewController
                                 , CreateOrderDisplayLogic
                                 , UITextFieldDelegate
                                 , UIPickerViewDelegate
                                 , UIPickerViewDataSource
{
//MARK: - ATRIBUTES
    var interactor: CreateOrderBusinessLogic! // OUTPUT that goes to interactor
    var router: (
        NSObjectProtocol
//        & CreateOrderRoutingLogic
//        & CreateOrderDataPassing
    )?
    
    //MARK: outlets
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var shippingMethodTextField: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet var expirationDatePicker: UIDatePicker!
    
//MARK: - CONFIGURATOR
    private func setup()
    {
        let viewController = self
        let interactor = CreateOrderInteractor()
        let presenter = CreateOrderPresenter()
        let router = CreateOrderRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.viewController = viewController
//        router.dataStore = interactor as CreateOrderDataStore
    }
// MARK: - LIFE CYCLE
    //MARK: object
    override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        super.init(
            nibName: nibNameOrNil,
            bundle: nibBundleOrNil
        )
        setup()
    }
    required init?(
        coder aDecoder: NSCoder
    ) {
        super.init(
            coder: aDecoder
        )
        setup()
    }
    //MARK: view
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configurePickers()
        
//        doSomething()
    }
    
//MARK: - TABLE VIEW
    override func tableView( // quando selecionar a cell, mesmo fora do textField, j?? vai para a edi????o do textField
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let cell = tableView.cellForRow(
            at: indexPath
        ) {
            for textField in textFields {
                if textField.isDescendant(
                    of: cell
                ) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }

//MARK: - TEXT FIELDS
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn( // ao pressionar o bot??o NEXT no Keyboard j?? vai direto para o pr??ximo textField
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(
            of: textField
        ) {
            if index < textFields.count - 1 {
                let nextTextField = textFields[ index + 1 ]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
//MARK: - PICKERS
    func configurePickers(){ // When the user taps the??shippingMethodTextField, the correct picker UI will be shown instead of the standard keyboard.
        shippingMethodTextField.inputView = shippingMethodPicker
        expirationDateTextField.inputView = expirationDatePicker
    }
    // MARK: UIPickerViewDelegate
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return interactor.shippingMethods[ row ]
    }
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        shippingMethodTextField.text = interactor.shippingMethods[ row ]
    }
    //MARK: UIPickerViewDataSource
    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return 1
    }
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return interactor.shippingMethods.count
    }
    
    //MARK: expiration date
        //MARK: CreateOrderViewControllerInput
    func displayExpirationDate(
        viewModel: CreateOrder.FormatExpirationDate.ViewModel
    ) {
        let date = viewModel.date
        expirationDateTextField.text = date
      }
        // MARK: Do something
    @IBAction func expirationDatePickerValueChanged(
        _ sender: Any
    ) {
        let date = expirationDatePicker.date
        let request = CreateOrder.FormatExpirationDate.Request(
            date: date
        )
        interactor.formatExpirationDate(
            request: request
        )
    }
    
//    func displaySomething(
//        viewModel: CreateOrder.Something.ViewModel
//    ) {
        //nameTextField.text = viewModel.name
//    }
// MARK: ROUTING
//    override func prepare(
//        for segue: UIStoryboardSegue,
//        sender: Any?
//    ) {
//        if let scene = segue.identifier {
//            let selector = NSSelectorFromString("routeTo\(
                //    scene
            //    )WithSegue:"
        //    )
//            if let router = router, router.responds(
//                to: selector // se no ROUTER tem um m??todo com esse nome
//            ) {
//                router.perform(
//                    selector,
//                    with: segue
//                )
//            }
//        }
//    }
}

