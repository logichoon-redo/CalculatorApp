//
//  ViewController.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/07.
//

import UIKit

class ViewController: UIViewController {

    //MARK : -Properties
    
    var resultTextField: UITextField!
    var buttonsContainer: UIView!
    var firstStackView: UIStackView!
    var secondStackView: UIStackView!
    var thirdStackView: UIStackView!
    var fourthStackView: UIStackView!
    

    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.makeTextField()
        print("test")
    }


}

extension ViewController {
    
    //MARK: -ObjectSetting
    
    fileprivate func makeTextField() {
        resultTextField = UITextField()
        resultTextField.text = "Result Text"
        resultTextField.backgroundColor = .systemGray
        self.view.addSubview(resultTextField)
    }
    
    fileprivate func makeButtonContainer() {
        buttonsContainer = UIView()
        buttonsContainer.backgroundColor = .green
        self.view.addSubview(buttonsContainer)
        
        
        
    }
    
    func stackSetting(stack: UIStackView) {
        stack.axis = .horizontal
        stack.spacing = 10
        
    }
}
