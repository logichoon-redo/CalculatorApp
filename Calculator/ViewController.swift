//
//  ViewController.swift
//  Calculator
//
//  Created by 이치훈 on 2023/03/07.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {

    //MARK: - Properties
    
    //view객체들
    var logSignLabel: UIButton!
    var logLabel: UILabel!
    var inputLabel: UILabel!
    var interFaceView: UIView!
    var buttonContainerView: UIView!
    var firstStackView: UIStackView!
    var secondStackView: UIStackView!
    var thirdStackView: UIStackView!
    var fourthStackView: UIStackView!
    var fifthStackView: UIStackView!
    
    //firstStack안에 있는 버튼
    var ACButton: UIButton!
    var modOperatorButton: UIButton!
    var divisionOperatorButton: UIButton!
    var multiplicationOperatorButton: UIButton!
    
    //secondStack안에 있는 버튼
    var button7: UIButton!
    var button8: UIButton!
    var button9: UIButton!
    var subtractionOperatorButton: UIButton!
    
    //thirdStack안에 있는 버튼
    var button4: UIButton!
    var button5: UIButton!
    var button6: UIButton!
    var additionOperatorButton: UIButton!
    
    //fourthStack안에 있는 버튼
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    
    //fifthStack안에 있는 버튼
    var zeroButton: UIButton!
    var doubleZeroButton: UIButton!
    var dotButton: UIButton!
    
    //Equal(=) 버튼
    var equalButton: UIButton!
    
    //이것들로 계산할거임
    var tempValue: Double = 0
    var inputBuffer: String = "0"
    var logBuffer: String = ""
    
    //calculator
    var resultValue: Double?
    var isShowResult: Bool = false
    var isInitNum: Bool = true
    
    //CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
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

    //MARK: - Button Logic
    
    fileprivate func setTargetAction() {
        //logButton
        self.logSignLabel.addTarget(self, action: #selector(showLogTable), for: .touchUpInside)
        
        //firstStack
        self.ACButton.addTarget(self, action: #selector(clickAC), for: .touchUpInside)
        self.modOperatorButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.divisionOperatorButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.multiplicationOperatorButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        
        //secondStack
        self.button7.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button8.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button9.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.subtractionOperatorButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        
        //thirdStack
        self.button4.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button5.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button6.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.additionOperatorButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        
        //fourthStack
        self.button1.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button2.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.button3.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        
        //fifthStack
        self.zeroButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.doubleZeroButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        self.dotButton.addTarget(self, action: #selector(clickButton(_: )), for: .touchUpInside)
        
        //equals
        self.equalButton.addTarget(self, action: #selector(equalsClick), for: .touchUpInside)
        
    }
    
    //firstStack의 버튼들
    @objc fileprivate func clickButton(_ sender: UIButton) {
        switch sender{
        case modOperatorButton:
            logBuffer.append(" % ")
            inputBuffer = ""
            self.isShowResult = false
            updateResultLabel()
        case divisionOperatorButton:
            logBuffer.append(" / ")
            inputBuffer = ""
            self.isShowResult = false
            updateResultLabel()
        case multiplicationOperatorButton:
            logBuffer.append(" * ")
            inputBuffer = ""
            self.isShowResult = false
            updateResultLabel()
        case subtractionOperatorButton:
            logBuffer.append(" - ")
            inputBuffer = ""
            self.isShowResult = false
            updateResultLabel()
        case additionOperatorButton:
            logBuffer.append(" + ")
            inputBuffer = ""
            self.isShowResult = false
            updateResultLabel()
        //Literal ---------------------------------
        case dotButton:
            inputBuffer.append(".")
            logBuffer.append(".")
            updateResultLabel()
        case doubleZeroButton:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("00")
            logBuffer.append("00")
            updateResultLabel()
        case zeroButton:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("0")
            logBuffer.append("0")
            updateResultLabel()
        case button1:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("1")
            logBuffer.append("1")
            updateResultLabel()
        case button2:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("2")
            logBuffer.append("2")
            updateResultLabel()
        case button3:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("3")
            logBuffer.append("3")
            updateResultLabel()
        case button4:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("4")
            logBuffer.append("4")
            updateResultLabel()
        case button5:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("5")
            logBuffer.append("5")
            updateResultLabel()
        case button6:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("6")
            logBuffer.append("6")
            updateResultLabel()
        case button7:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("7")
            logBuffer.append("7")
            updateResultLabel()
        case button8:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("8")
            logBuffer.append("8")
            updateResultLabel()
        case button9:
            if self.isInitNum {self.inputBuffer = ""}
            self.isInitNum = false
            inputBuffer.append("9")
            logBuffer.append("9")
            updateResultLabel()
        default:
            print("예외값이 inputBuffer에 입력됨")
            break
        }
    }
    
    @objc func clickAC() {
        inputBuffer = ""
        logBuffer = ""
        self.isShowResult = false
        self.isInitNum = false
        updateResultLabel()
    }
    
    @objc func equalsClick() {
        print("input \(logBuffer)")
        self.resultValue = self.calculate(logBuffer)
        print("output \(resultValue!)")
        
        self.inputLabel.text = "\(String(describing: self.resultValue ?? 0))"
        
        if !isShowResult {
            self.logBuffer.append(" = \(String(describing: self.resultValue ?? 0))")
        }
        //self.inputLabel.text = "\(String(describing: self.resultValue ?? 0))"
        self.saveLog()
        
        self.isShowResult = true
        self.logLabel.text = self.logBuffer
        self.inputBuffer = ""
        self.logBuffer = ""
        //self.updateResultLabel()
    }
    
    //MARK: Equal Algorithms
    
    func calculate(_ equation: String) -> Double {
        let operators: Set<Character> = ["+", "-", "*", "/", "%"]
        var numStack = [Double]()
        var opStack = [Character]()
        var numString = ""
        
        // 문자열을 반복하며 숫자와 연산자를 구분합니다.
        for char in equation {
            if char.isNumber || char == "." {
                numString.append(char)
            } else if operators.contains(char) {
                if let num = Double(numString) {
                    numStack.append(num)
                    numString = ""
                }
                
                // 우선순위가 높은 연산자는 먼저 처리합니다.
                while !opStack.isEmpty && higherPrecedence(opStack.last!, char) {
                    let num2 = numStack.removeLast()
                    let num1 = numStack.removeLast()
                    let op = opStack.removeLast()
                    let result = calculator(op, num1, num2)
                    numStack.append(result)
                }
                
                opStack.append(char)
            }
        }
        
        if let num = Double(numString) {
            numStack.append(num)
        }
        
        // 남은 연산자를 모두 처리합니다.
        while !opStack.isEmpty {
            let num2 = numStack.removeLast()
            let num1 = numStack.removeLast()
            let op = opStack.removeLast()
            let result = calculator(op, num1, num2)
            numStack.append(result)
        }
        
        // 계산된 결과값을 반환합니다.
        return numStack.last ?? 0
    }
    
    func higherPrecedence(_ op1: Character, _ op2: Character) -> Bool {
        return (op1 == "*" || op1 == "/" || op1 == "%") && (op2 == "+" || op2 == "-")
    }
    
    func calculator(_ op: Character, _ num1: Double, _ num2: Double) -> Double {
        switch op {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            if num2 == 0 {
                return Double.nan
            } else {
                return num1 / num2
            }
        case "%":
            return num1.truncatingRemainder(dividingBy: num2)
        default:
            return Double.nan
        }
    }
    
    //Label Logic
    
    @objc func labelSwiped() {
        if !inputBuffer.isEmpty {
            self.inputBuffer.removeLast()
            self.logBuffer.removeLast()
            self.updateResultLabel()
            print("called labelSwiped")
        }
    }
    
    @objc func showLogTable() {
        let logTableVC = CalcLogTableViewController()
        
        self.present(logTableVC, animated: true)
    }
    
    //Core Data
    
    fileprivate func saveLog() {
        
        let object = CalcLog(context: context)
        object.log = logBuffer
        object.date = Date()
        object.uuid = UUID()
        
        do {
            try context.save()
        } catch {
            print("Failed saving log with error: \(error)")
        }
        
    }
    
    fileprivate func updateResultLabel() {
        self.inputLabel.text = self.inputBuffer
        self.logLabel.text = self.logBuffer
    }
    
    
}

//MARK: - Object Setting

extension ViewController {
    
    fileprivate func setResultScreenView() {
        self.interFaceView.backgroundColor = .lightGray
        self.setLogSignLabel()
        self.setLogLabel()
        self.setinputLabel()
    }
    
    fileprivate func setLogSignLabel() {
        self.logSignLabel.setTitle("Log: ", for: .normal)
        self.logSignLabel.tintColor = .black
        //self.logSignLabel.textAlignment = .left
        //self.logSignLabel.font = UIFont.boldSystemFont(ofSize: 20)
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
        //normal버튼과 다르게 모양이나 background색이 다름
        
        
        
        self.stackViewSet(stack: firstStackView)
        self.stackViewSet(stack: secondStackView)
        self.stackViewSet(stack: thirdStackView)
        self.stackViewSet(stack: fourthStackView)
        self.stackViewSet(stack: fifthStackView)
        
        //Button속성 설정
        self.setNormalButton(button: ACButton, string: "AC", color: .systemGray)
        self.setNormalButton(button: modOperatorButton, string: "%", color: .systemGray)
        self.setNormalButton(button: divisionOperatorButton, string: "/", color: .systemGray)
        self.setNormalButton(button: multiplicationOperatorButton, string: "*", color: .systemGray)
        
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
        self.firstStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.firstStackView.topAnchor.constraint(equalTo: self.buttonContainerView.topAnchor, constant: 10),
            self.firstStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.firstStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.firstStackView.bottomAnchor.constraint(equalTo: self.secondStackView.topAnchor, constant: -10),
            self.firstStackView.heightAnchor.constraint(equalTo: self.secondStackView.heightAnchor),
            self.firstStackView.widthAnchor.constraint(equalTo: self.secondStackView.widthAnchor)
        ])
        
        self.secondStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.secondStackView.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 10),
            self.secondStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.secondStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.secondStackView.bottomAnchor.constraint(equalTo: self.thirdStackView.topAnchor, constant: -10),
            self.secondStackView.heightAnchor.constraint(equalTo: thirdStackView.heightAnchor)
        ])
        
        self.thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.thirdStackView.topAnchor.constraint(equalTo: self.secondStackView.bottomAnchor, constant: 10),
            self.thirdStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.thirdStackView.trailingAnchor.constraint(equalTo: self.buttonContainerView.trailingAnchor),
            self.thirdStackView.bottomAnchor.constraint(equalTo: self.fourthStackView.topAnchor, constant: -10),
            self.thirdStackView.heightAnchor.constraint(equalTo: self.fourthStackView.heightAnchor),
            self.thirdStackView.widthAnchor.constraint(equalTo: self.firstStackView.widthAnchor)
        ])
        
        self.fourthStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.fourthStackView.topAnchor.constraint(equalTo: self.thirdStackView.bottomAnchor, constant: 10),
            self.fourthStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.fourthStackView.trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10),
            self.fourthStackView.bottomAnchor.constraint(equalTo: self.fifthStackView.topAnchor, constant: -10),
            self.fourthStackView.heightAnchor.constraint(equalTo: self.fifthStackView.heightAnchor)
        ])
        
        self.fifthStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.fifthStackView.topAnchor.constraint(equalTo: self.fourthStackView.bottomAnchor, constant: 10),
            self.fifthStackView.leadingAnchor.constraint(equalTo: self.buttonContainerView.leadingAnchor),
            self.fifthStackView.trailingAnchor.constraint(equalTo: self.equalButton.leadingAnchor, constant: -10),
            self.fifthStackView.bottomAnchor.constraint(equalTo: self.buttonContainerView.bottomAnchor),
            self.fifthStackView.heightAnchor.constraint(equalTo: self.firstStackView.heightAnchor)
        ])
        
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

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

//MARK: - ConfigureSubviewsCase

extension ViewController: ConfigureSubviewsCase {
    func configureSubviews() {
        self.createSubviews()
        self.addSubviews()
        self.setupLayouts()
    }
    
    func createSubviews() {
        //view객체들
        logSignLabel = UIButton()
        logLabel = UILabel()
        inputLabel = UILabel()
        interFaceView = UIView()
        buttonContainerView = UIView()
        firstStackView = UIStackView()
        secondStackView = UIStackView()
        thirdStackView = UIStackView()
        fourthStackView = UIStackView()
        fifthStackView = UIStackView()
        
        //firstStack안에 있는 버튼
        ACButton = UIButton()
        modOperatorButton = UIButton()
        divisionOperatorButton = UIButton()
        multiplicationOperatorButton = UIButton()
        
        //secondStack안에 있는 버튼
        button7 = UIButton()
        button8 = UIButton()
        button9 = UIButton()
        subtractionOperatorButton = UIButton()
        
        //thirdStack안에 있는 버튼
        button4 = UIButton()
        button5 = UIButton()
        button6 = UIButton()
        additionOperatorButton = UIButton()
        
        //fourthStack안에 있는 버튼
        button1 = UIButton()
        button2 = UIButton()
        button3 = UIButton()
        
        //fifthStack안에 있는 버튼
        zeroButton = UIButton()
        doubleZeroButton = UIButton()
        dotButton = UIButton()
        
        //Equal(=) 버튼
        equalButton = UIButton()
    }
    
    func addSubviews() {
        self.view.addSubview(interFaceView)
        self.interFaceView.addSubview(logSignLabel)
        self.interFaceView.addSubview(logLabel)
        self.interFaceView.addSubview(inputLabel)
        self.view.addSubview(buttonContainerView)
        _=[firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView, equalButton].map{
            self.buttonContainerView.addSubview($0)
        }
        
        _=[ACButton, modOperatorButton,
           divisionOperatorButton, multiplicationOperatorButton].map{
            self.firstStackView.addArrangedSubview($0)
        }
        _=[button7, button8, button9, subtractionOperatorButton].map{
            self.secondStackView.addArrangedSubview($0)
        }
        _=[button4, button5, button6, additionOperatorButton].map{
            self.thirdStackView.addArrangedSubview($0)
        }
        _=[button1, button2, button3].map{
            self.fourthStackView.addArrangedSubview($0)
        }
        _=[zeroButton, doubleZeroButton, dotButton].map{
            self.fifthStackView.addArrangedSubview($0)
        }
    }
    
    func setupLayouts() {
        self.setupSubviewsLayouts()
        self.setupSubviewsConstraints()
    }
}

extension ViewController: SetupSubviewsLayouts {
    func setupSubviewsLayouts() {
        self.setResultScreenView()
        self.setNormalButtonContainer()
    }
}

extension ViewController: SetupSubviewsConstraints {
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
