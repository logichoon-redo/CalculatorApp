//
//  ViewController.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/07.
//

import Foundation
import RxSwift
import UIKit

class MainViewController: UIViewController {

    //MARK: - Properties
    
    //view객체들
    var logSignLabel = UIButton()
    var logLabel = UILabel()
    var inputLabel = UILabel()
    var interFaceView = UIView()
    var buttonContainerView = UIView()
    var stackViews = (0...5).map { _ in
        UIStackView()
    }
    var numButtons = (0...10).map { _ in
        UIButton()
    }
    
    var ACButton = UIButton()
    var modOperatorButton = UIButton()
    var divisionOperatorButton = UIButton()
    var multiplicationOperatorButton = UIButton()
    var subtractionOperatorButton = UIButton()
    var additionOperatorButton = UIButton()
    var dotButton = UIButton()
    var equalButton = UIButton()
    
    //---------- Calc Value --------------
    let mainViewModel = MainViewModel()
    var resultValue: Double?
    var isShowResult: Bool = false
    var isFirstNum: Bool = true
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
                
        //setlayout
        self.configureSubviews()
        
        //setAction
        self.setTargetAction()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(labelSwiped))
             inputLabel.addGestureRecognizer(swipeGesture)
             inputLabel.isUserInteractionEnabled = true
    }
    
    public func updateResultLabel() {
        self.inputLabel.text = mainViewModel.getOperandBuffer()
        self.logLabel.text = mainViewModel.getLogBuffer()
    }
    
}

//MARK: - Action

extension MainViewController {
    
    fileprivate func setTargetAction() {
        //numbers
        _=(0...10).map {
            self.numButtons[$0].addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        }
        
        //logButton
        self.logSignLabel.addTarget(self, action: #selector(showLogTable), for: .touchUpInside)
        
        //Operator
        self.ACButton.addTarget(self, action: #selector(clickAC), for: .touchUpInside)
        self.modOperatorButton.addTarget(self, action: #selector(clickOperatorButton(_: )), for: .touchUpInside)
        self.divisionOperatorButton.addTarget(self, action: #selector(clickOperatorButton(_: )), for: .touchUpInside)
        self.multiplicationOperatorButton.addTarget(self, action: #selector(clickOperatorButton(_: )), for: .touchUpInside)
        self.subtractionOperatorButton.addTarget(self, action: #selector(clickOperatorButton(_: )), for: .touchUpInside)
        self.additionOperatorButton.addTarget(self, action: #selector(clickOperatorButton(_: )), for: .touchUpInside)
        
        self.dotButton.addTarget(self, action: #selector(clickDotButton), for: .touchUpInside)
        self.equalButton.addTarget(self, action: #selector(equalsClick), for: .touchUpInside)
    }
    
    @objc func clickAC() {
        mainViewModel.setOperandBufferDefault()
        mainViewModel.setLogBufferDefault()
        self.isShowResult = false
        self.isFirstNum = false
        self.updateResultLabel()
    }
    
    @objc func equalsClick() {
        self.resultValue = mainViewModel.calculate()
        
        self.inputLabel.text = "\(String(describing: self.resultValue ?? 0))"
        
        if !isShowResult {
            mainViewModel.appendLogBuffer(" = \(String(describing: self.resultValue ?? 0))")
        }
        
        mainViewModel.MASaveCoreData()
        
        self.isShowResult = true
        self.logLabel.text = mainViewModel.getLogBuffer()
        mainViewModel.setOperandBufferDefault()
        mainViewModel.setLogBufferDefault()
    }
    
    @objc func labelSwiped() {
        if !mainViewModel.operandBufferIsEmpty() {
            mainViewModel.removeLastOperandBuffer()
            mainViewModel.removeLastLogBuffer()
            self.updateResultLabel()
            print("called labelSwiped")
        }
    }
    
    @objc func showLogTable() {
        let logTableVC = CalcLogTableViewController()
        
        self.present(logTableVC, animated: true)
    }
    
    @objc public func clickOperatorButton(_ sender: UIButton) {
        switch sender {
        case modOperatorButton:
            mainViewModel.appendLogBuffer("%")
        case divisionOperatorButton:
            mainViewModel.appendLogBuffer("/")
        case multiplicationOperatorButton:
            mainViewModel.appendLogBuffer("*")
        case subtractionOperatorButton:
            mainViewModel.appendLogBuffer("-")
        case additionOperatorButton:
            mainViewModel.appendLogBuffer("+")
        default:
            print("예외값이 inputBuffer에 입력됨")
            break
        }
        
        self.mainViewModel.setOperandBufferDefault()
        self.isShowResult = false
        self.updateResultLabel()
    }
    
    @objc public func clickDotButton() {
        mainViewModel.appendOperandBuffer(".")
        mainViewModel.appendLogBuffer(".")
    }
    
    @objc public func clickButton(_ sender: UIButton) {
        var item = ""
        switch sender{
        case numButtons[10]:
            item = "00"
        case numButtons[0]:
            item = "0"
        case numButtons[1]:
            item = "1"
        case numButtons[2]:
            item = "2"
        case numButtons[3]:
            item = "3"
        case numButtons[4]:
            item = "4"
        case numButtons[5]:
            item = "5"
        case numButtons[6]:
            item = "6"
        case numButtons[7]:
            item = "7"
        case numButtons[8]:
            item = "8"
        case numButtons[9]:
            item = "9"
        default:
            print("예외값이 inputBuffer에 입력됨")
            break
        }

        if self.isFirstNum {mainViewModel.setOperandBufferDefault()}
        self.isFirstNum = false
        mainViewModel.appendOperandBuffer(item)
        mainViewModel.appendLogBuffer(item)
        self.updateResultLabel()
    }
    
}

//MARK: - Object Setting

extension MainViewController {
    
    fileprivate func setResultScreenView() {
        self.interFaceView.backgroundColor = .lightGray
        self.setLogSignLabel()
        self.setLogLabel()
        self.setinputLabel()
    }
    
    fileprivate func setLogSignLabel() {
        self.logSignLabel.setTitle("Log: ", for: .normal)
        self.logSignLabel.tintColor = .black
    }
    
    fileprivate func setLogLabel() {
        self.logLabel.text = ""
        self.logLabel.tintColor = .black
        self.logLabel.textAlignment = .left
        self.logLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    fileprivate func setinputLabel() {
        inputLabel.text = "0"
        inputLabel.backgroundColor = .lightGray
        inputLabel.tintColor = .black
        inputLabel.font = UIFont.boldSystemFont(ofSize: 40)
        inputLabel.textAlignment = .right
    }
    
    fileprivate func setNormalButtonContainer() {
        equalButton.setTitle("=", for: .normal)
        equalButton.backgroundColor = .systemBlue
        equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        equalButton.layer.cornerRadius = 20
        
        _=(1...5).map {
            self.stackViewSet(stack: stackViews[$0])
        }
        
        //Button속성 설정
        self.setNormalButton(button: ACButton, string: "AC", color: .systemGray)
        self.setNormalButton(button: modOperatorButton, string: "%", color: .systemGray)
        self.setNormalButton(button: divisionOperatorButton, string: "/", color: .systemGray)
        self.setNormalButton(button: multiplicationOperatorButton, string: "*", color: .systemGray)
        
        self.setNormalButton(button: numButtons[7], string: "7", color: .black)
        self.setNormalButton(button: numButtons[8], string: "8", color: .black)
        self.setNormalButton(button: numButtons[9], string: "9", color: .black)
        self.setNormalButton(button: subtractionOperatorButton, string: "-", color: .systemGray)
        
        self.setNormalButton(button: numButtons[4], string: "4", color: .black)
        self.setNormalButton(button: numButtons[5], string: "5", color: .black)
        self.setNormalButton(button: numButtons[6], string: "6", color: .black)
        self.setNormalButton(button: additionOperatorButton, string: "+", color: .systemGray)
        
        self.setNormalButton(button: numButtons[1], string: "1", color: .black)
        self.setNormalButton(button: numButtons[2], string: "2", color: .black)
        self.setNormalButton(button: numButtons[3], string: "3", color: .black)
        
        self.setNormalButton(button: numButtons[0], string: "0", color: .black)
        self.setNormalButton(button: numButtons[10], string: "00", color: .black)
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
    
    
    //MARK: - Constraint Setting
    
    //logLabel, resultTextField view안에 묶어서 다시 설계 할것
    fileprivate func resultScreenViewConstraint() {
        self.interFaceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.interFaceView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.interFaceView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 3),
            self.interFaceView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -3),
            self.interFaceView.bottomAnchor.constraint(equalTo: self.buttonContainerView.topAnchor),
            self.interFaceView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    fileprivate func logSignLabelConstraint() {
        self.logSignLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logSignLabel.topAnchor.constraint(equalTo: self.interFaceView.topAnchor),
            self.logSignLabel.leadingAnchor.constraint(equalTo: self.interFaceView.leadingAnchor,constant: 5),
            self.logSignLabel.trailingAnchor.constraint(equalTo: self.logLabel.leadingAnchor),
            self.logSignLabel.bottomAnchor.constraint(equalTo: self.inputLabel.topAnchor, constant: 5),
            self.logSignLabel.heightAnchor.constraint(equalToConstant: 50),
            self.logSignLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    fileprivate func logLabelConstraint() {
        self.logLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logLabel.topAnchor.constraint(equalTo: self.interFaceView.topAnchor),
            self.logLabel.leadingAnchor.constraint(equalTo: self.logSignLabel.trailingAnchor),
            self.logLabel.trailingAnchor.constraint(equalTo: self.interFaceView.trailingAnchor),
            self.logLabel.bottomAnchor.constraint(equalTo: self.inputLabel.topAnchor, constant: 5),
            self.logLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func resultLabelConstraint() {
        self.inputLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.inputLabel.topAnchor.constraint(equalTo: self.logLabel.bottomAnchor, constant: 5),
            self.inputLabel.leadingAnchor.constraint(equalTo: self.interFaceView.leadingAnchor),
            self.inputLabel.trailingAnchor.constraint(equalTo: self.interFaceView.trailingAnchor, constant: -10),
            self.inputLabel.bottomAnchor.constraint(equalTo: self.interFaceView.bottomAnchor),
            self.inputLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    // -- 여기까지 수정해야됨
    
    fileprivate func buttonContainerConstraint() {
        self.buttonContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.buttonContainerView.topAnchor.constraint(equalTo: self.interFaceView.bottomAnchor),
            self.buttonContainerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.buttonContainerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            self.buttonContainerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    fileprivate func stackViewConstraint() {
        self.stackViews[1].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackViews[1].topAnchor.constraint(equalTo: self.buttonContainerView.topAnchor, constant: 10),
            self.stackViews[1].leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.stackViews[1].trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.stackViews[1].bottomAnchor.constraint(equalTo: self.stackViews[2].topAnchor, constant: -10),
            self.stackViews[1].heightAnchor.constraint(equalTo: self.stackViews[2].heightAnchor),
            self.stackViews[1].widthAnchor.constraint(equalTo: self.stackViews[2].widthAnchor)
        ])
        
        self.stackViews[2].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackViews[2].topAnchor.constraint(equalTo: self.stackViews[1].bottomAnchor, constant: 10),
            self.stackViews[2].leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.stackViews[2].trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.stackViews[2].bottomAnchor.constraint(equalTo: self.stackViews[3].topAnchor, constant: -10),
            self.stackViews[2].heightAnchor.constraint(equalTo: stackViews[3].heightAnchor)
        ])
        
        self.stackViews[3].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackViews[3].topAnchor.constraint(equalTo: self.stackViews[2].bottomAnchor, constant: 10),
            self.stackViews[3].leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.stackViews[3].trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.stackViews[3].bottomAnchor.constraint(equalTo: self.stackViews[4].topAnchor, constant: -10),
            self.stackViews[3].heightAnchor.constraint(equalTo: self.stackViews[4].heightAnchor),
            self.stackViews[3].widthAnchor.constraint(equalTo: self.stackViews[1].widthAnchor)
        ])
        
        self.stackViews[4].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackViews[4].topAnchor.constraint(equalTo: self.stackViews[3].bottomAnchor, constant: 10),
            self.stackViews[4].leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.stackViews[4].trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10),
            self.stackViews[4].bottomAnchor.constraint(equalTo: self.stackViews[5].topAnchor, constant: -10),
            self.stackViews[4].heightAnchor.constraint(equalTo: self.stackViews[5].heightAnchor)
        ])
        
        self.stackViews[5].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackViews[5].topAnchor.constraint(equalTo: self.stackViews[4].bottomAnchor, constant: 10),
            self.stackViews[5].leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.stackViews[5].trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10),
            self.stackViews[5].bottomAnchor.constraint(equalTo: self.buttonContainerView.bottomAnchor),
            self.stackViews[5].heightAnchor.constraint(equalTo: self.stackViews[1].heightAnchor)
        ])
        
    }
    
    fileprivate func equalButtonConstraint() {
        self.equalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.equalButton.topAnchor.constraint(equalTo: self.stackViews[3].bottomAnchor, constant: 10),
            self.equalButton.leadingAnchor.constraint(equalTo: self.stackViews[4].trailingAnchor, constant: 10),
            self.equalButton.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.equalButton.bottomAnchor.constraint(equalTo: self.buttonContainerView.bottomAnchor),
            self.equalButton.heightAnchor.constraint(equalTo: self.stackViews[1].heightAnchor, multiplier: 2, constant: 10),
            self.equalButton.widthAnchor.constraint(equalTo: self.buttonContainerView.widthAnchor, multiplier: 0.25, constant: -10)
        ])
    }
    
}

//MARK: - ConfigureSubviewsCase

extension MainViewController: ConfigureSubviewsCase {
    func configureSubviews() {
        self.addSubviews()
        self.setupLayouts()
    }
    
    func addSubviews() {
        self.view.addSubview(interFaceView)
        self.interFaceView.addSubview(logSignLabel)
        self.interFaceView.addSubview(logLabel)
        self.interFaceView.addSubview(inputLabel)
        self.view.addSubview(buttonContainerView)
        _=[stackViews[1], stackViews[2], stackViews[3], stackViews[4], stackViews[5], equalButton].map{
            self.buttonContainerView.addSubview($0)
        }
        
        _=[ACButton, modOperatorButton,
           divisionOperatorButton, multiplicationOperatorButton].map{
            self.stackViews[1].addArrangedSubview($0)
        }
        _=[numButtons[7], numButtons[8], numButtons[9], subtractionOperatorButton].map{
            self.stackViews[2].addArrangedSubview($0)
        }
        _=[numButtons[4], numButtons[5], numButtons[6], additionOperatorButton].map{
            self.stackViews[3].addArrangedSubview($0)
        }
        _=[numButtons[1], numButtons[2], numButtons[3]].map{
            self.stackViews[4].addArrangedSubview($0)
        }
        _=[numButtons[0], numButtons[10], dotButton].map{
            self.stackViews[5].addArrangedSubview($0)
        }
    }
    
    func setupLayouts() {
        self.setupSubviewsLayouts()
        self.setupSubviewsConstraints()
    }
}

extension MainViewController: SetupSubviewsLayouts {
    func setupSubviewsLayouts() {
        self.setResultScreenView()
        self.setNormalButtonContainer()
    }
}

extension MainViewController: SetupSubviewsConstraints {
    func setupSubviewsConstraints() {
        self.resultScreenViewConstraint()
        self.logSignLabelConstraint()
        self.logLabelConstraint()
        self.resultLabelConstraint()
        self.buttonContainerConstraint()
        self.stackViewConstraint()
        self.equalButtonConstraint()
    }
}
