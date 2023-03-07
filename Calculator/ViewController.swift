//
//  ViewController.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/07.
//

import UIKit

class ViewController: UIViewController {

    //MARK: -Properties
    
    let resultTextField = UITextField()
    let buttonContainerView = UIView()
    let firstStackView = UIStackView()
    let secondStackView = UIStackView()
    let thirdStackView = UIStackView()
    let fourthStackView = UIStackView()
    let fifthStackView = UIStackView()
    
    //firstStack안에 있는 버튼
    let ACButton = UIButton()
    let modOperatorButton = UIButton()
    let divisionOperatorButton = UIButton()
    let MultiplicationOperatorButton = UIButton()
    
    //secondStack안에 있는 버튼
    let button7 = UIButton()
    let button8 = UIButton()
    let button9 = UIButton()
    let subtractionOperatorButton = UIButton()
    
    //thirdStack안에 있는 버튼
    let button4 = UIButton()
    let button5 = UIButton()
    let button6 = UIButton()
    let additionOperatorButton = UIButton()
    
    //fourthStack안에 있는 버튼
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    
    //fifthStack안에 있는 버튼
    let zeroButton = UIButton()
    let doubleZeroButton = UIButton()
    let dotButton = UIButton()
    
    //Equal(=) 버튼
    let equalButton = UIButton()
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.makeTextField()
        self.makeNormalButtonContainer()
    }


}

//MARK: - ObjectSetting

extension ViewController {
    
    fileprivate func makeTextField() {
        resultTextField.text = "Result Text"
        resultTextField.backgroundColor = .lightGray
        resultTextField.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(resultTextField)
        self.textFieldConstraint()
    }
    
    fileprivate func makeNormalButtonContainer() {
        self.view.addSubview(buttonContainerView)
        self.buttonContainerConstraint()
        
        self.buttonContainerView.addSubview(firstStackView)
        self.buttonContainerView.addSubview(secondStackView)
        self.buttonContainerView.addSubview(thirdStackView)
        self.buttonContainerView.addSubview(fourthStackView)
        self.buttonContainerView.addSubview(fifthStackView)
        self.buttonContainerView.addSubview(equalButton)
        equalButton.setTitle("=", for: .normal)
        equalButton.backgroundColor = .systemBlue
        equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        equalButton.layer.cornerRadius = 20
        //normal버튼과 다르게 모양이나 background색이 다름
        
        
        
        self.stackViewSet(stack: firstStackView)
        self.stackViewSet(stack: secondStackView)
        self.stackViewSet(stack: thirdStackView)
        self.stackViewSet(stack: fourthStackView)
        self.stackViewSet(stack: fifthStackView)
        
        self.stackViewConstraint()
        self.equalButtonConstraint()
        
        //stack에 button추가
        self.firstStackView.addArrangedSubview(ACButton)
        self.firstStackView.addArrangedSubview(modOperatorButton)
        self.firstStackView.addArrangedSubview(divisionOperatorButton)
        self.firstStackView.addArrangedSubview(MultiplicationOperatorButton)
        
        self.secondStackView.addArrangedSubview(button7)
        self.secondStackView.addArrangedSubview(button8)
        self.secondStackView.addArrangedSubview(button9)
        self.secondStackView.addArrangedSubview(subtractionOperatorButton)
        
        self.thirdStackView.addArrangedSubview(button4)
        self.thirdStackView.addArrangedSubview(button5)
        self.thirdStackView.addArrangedSubview(button6)
        self.thirdStackView.addArrangedSubview(additionOperatorButton)
        
        self.fourthStackView.addArrangedSubview(button1)
        self.fourthStackView.addArrangedSubview(button2)
        self.fourthStackView.addArrangedSubview(button3)
        
        self.fifthStackView.addArrangedSubview(zeroButton)
        self.fifthStackView.addArrangedSubview(doubleZeroButton)
        self.fifthStackView.addArrangedSubview(dotButton)
        
        //Button속성 설정
        self.setNormalButton(button: ACButton, string: "AC", color: .systemGray)
        self.setNormalButton(button: modOperatorButton, string: "%", color: .systemGray)
        self.setNormalButton(button: divisionOperatorButton, string: "/", color: .systemGray)
        self.setNormalButton(button: MultiplicationOperatorButton, string: "*", color: .systemGray)
        
        self.setNormalButton(button: button7, string: "7", color: .black)
        self.setNormalButton(button: button8, string: "8", color: .black)
        self.setNormalButton(button: button9, string: "9", color: .black)
        self.setNormalButton(button: subtractionOperatorButton, string: "-", color: .systemGray)
        
        self.setNormalButton(button: button4, string: "4", color: .black)
        self.setNormalButton(button: button5, string: "5", color: .black)
        self.setNormalButton(button: button6, string: "6", color: .black)
        self.setNormalButton(button: additionOperatorButton, string: "+", color: .systemGray)
        
        self.setNormalButton(button: button1, string: "1", color: .black)
        self.setNormalButton(button: button2, string: "2", color: .black)
        self.setNormalButton(button: button3, string: "3", color: .black)
        
        self.setNormalButton(button: zeroButton, string: "0", color: .black)
        self.setNormalButton(button: doubleZeroButton, string: "00", color: .black)
        self.setNormalButton(button: dotButton, string: ".", color: .black)
        
    }
    
    fileprivate func stackViewSet(stack: UIStackView) {
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
    }
    
    fileprivate func setNormalButton(button: UIButton, string: String, color: UIColor) {
        button.setTitle(string, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.layer.cornerRadius = 20
    }
    
    //MARK: - Constraint
    
    fileprivate func textFieldConstraint() {
        self.resultTextField.translatesAutoresizingMaskIntoConstraints = false
        self.resultTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.resultTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 3).isActive = true
        self.resultTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -3).isActive = true
        self.resultTextField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.resultTextField.layer.cornerRadius = 15
        self.resultTextField.layer.masksToBounds = true
    }
    
    fileprivate func buttonContainerConstraint() {
        self.buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.buttonContainerView.topAnchor.constraint(equalTo: self.resultTextField.bottomAnchor).isActive = true
        self.buttonContainerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.buttonContainerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        self.buttonContainerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    fileprivate func stackViewConstraint() {
        self.firstStackView.translatesAutoresizingMaskIntoConstraints = false
        self.firstStackView.topAnchor.constraint(equalTo: self.buttonContainerView.topAnchor, constant: 10).isActive = true
        self.firstStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor).isActive = true
        self.firstStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor).isActive = true
        self.firstStackView.bottomAnchor.constraint(equalTo: self.secondStackView.topAnchor, constant: -10).isActive = true
        self.firstStackView.heightAnchor.constraint(equalTo: self.secondStackView.heightAnchor).isActive = true
        self.firstStackView.widthAnchor.constraint(equalTo: self.secondStackView.widthAnchor).isActive = true
        
        self.secondStackView.translatesAutoresizingMaskIntoConstraints = false
        self.secondStackView.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 10).isActive = true
        self.secondStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor).isActive = true
        self.secondStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor).isActive = true
        self.secondStackView.bottomAnchor.constraint(equalTo: self.thirdStackView.topAnchor, constant: -10).isActive = true
        self.secondStackView.heightAnchor.constraint(equalTo: thirdStackView.heightAnchor).isActive = true
        self.secondStackView.widthAnchor.constraint(equalTo: self.thirdStackView.widthAnchor).isActive = true
        
        self.thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        self.thirdStackView.topAnchor.constraint(equalTo: self.secondStackView.bottomAnchor, constant: 10).isActive = true
        self.thirdStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor).isActive = true
        self.thirdStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor).isActive = true
        self.thirdStackView.bottomAnchor.constraint(equalTo: self.fourthStackView.topAnchor, constant: -10).isActive = true
        self.thirdStackView.heightAnchor.constraint(equalTo: self.fourthStackView.heightAnchor).isActive = true
        self.thirdStackView.widthAnchor.constraint(equalTo: self.firstStackView.widthAnchor).isActive = true
        
        self.fourthStackView.translatesAutoresizingMaskIntoConstraints = false
        self.fourthStackView.topAnchor.constraint(equalTo: self.thirdStackView.bottomAnchor, constant: 10).isActive = true
        self.fourthStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor).isActive = true
        self.fourthStackView.trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10).isActive = true
        self.fourthStackView.bottomAnchor.constraint(equalTo: self.fifthStackView.topAnchor, constant: -10).isActive = true
        self.fourthStackView.heightAnchor.constraint(equalTo: self.fifthStackView.heightAnchor).isActive = true
        
        self.fifthStackView.translatesAutoresizingMaskIntoConstraints = false
        self.fifthStackView.topAnchor.constraint(equalTo: self.fourthStackView.bottomAnchor, constant: 10).isActive = true
        self.fifthStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor).isActive = true
        self.fifthStackView.trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10).isActive = true
        self.fifthStackView.bottomAnchor.constraint(equalTo: self.buttonContainerView.bottomAnchor).isActive = true
        self.fifthStackView.heightAnchor.constraint(equalTo: self.firstStackView.heightAnchor).isActive = true
        
        

    }
    
    fileprivate func equalButtonConstraint() {
        
        self.equalButton.translatesAutoresizingMaskIntoConstraints = false
        self.equalButton.topAnchor.constraint(equalTo: self.thirdStackView.bottomAnchor, constant: 10).isActive = true
        self.equalButton.leadingAnchor.constraint(equalTo: self.fourthStackView.trailingAnchor, constant: 10).isActive = true
        self.equalButton.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor).isActive = true
        self.equalButton.bottomAnchor.constraint(equalTo: self.buttonContainerView.bottomAnchor).isActive = true
        self.equalButton.heightAnchor.constraint(equalTo: self.firstStackView.heightAnchor, multiplier: 2, constant: 10).isActive = true
        self.equalButton.widthAnchor.constraint(equalTo: self.buttonContainerView.widthAnchor, multiplier: 0.25, constant: -10).isActive = true
    }
    
}
