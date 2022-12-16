//
//  ButtonView.swift
//  Calc
//
//  Created by Amini on 05/09/22.
//

import Foundation
import UIKit
import EMTNeumorphicView
import Combine

enum ButtonType {
    case Scientifics
    case MainCalc
}

class ButtonPads: UIView {
    
    var type: ButtonType = .MainCalc
    let model: CalculatorViewModel
    
    let mainButtons = [
        [CleareanceValue.clear, CleareanceValue.clearEnter, FormatValue.percent, FormatValue.divide],
        [NumberValue.seven, NumberValue.eight, NumberValue.nine, FormatValue.mutilplie],
        [NumberValue.four, NumberValue.five, NumberValue.six, FormatValue.minus],
        [NumberValue.one, NumberValue.two, NumberValue.three, FormatValue.plus],
        [NumberValue.zero, FormatValue.comma, NumberValue.dot, CleareanceValue.equals]
    ]
    
    let scientificsPads = [
        [MathOperationValue.sinus, MathOperationValue.cosinus, MathOperationValue.tangen, MathOperationValue.modulo, MathOperationValue.plusMinus],
        [MathOperationValue.asinus, MathOperationValue.acosinus, MathOperationValue.atangen, FunctionalValue.modulus, MathOperationValue.onePerX],
        [MathOperationValue.power2, MathOperationValue.power3, FunctionalValue.powery, FunctionalValue.xPowMinus, MathOperationValue.tenPowx],
        [MathOperationValue.sqroot, MathOperationValue.cbroot, FunctionalValue.yroot, MathOperationValue.piNumber, MathOperationValue.expnen],
        [MathOperationValue.logaritma, MathOperationValue.lnFunction, FunctionalValue.combination, FunctionalValue.permutation, MathOperationValue.factorial]
    ]
    
    init(_ type: ButtonType, _ model: CalculatorViewModel) {
        self.type = type
        self.model = model
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        // button stack
        let vstackview = UIStackView()
        vstackview.axis = .vertical
        vstackview.distribution = .fillEqually
        
        
        for outer in 0...4 {
            let hstackView = UIStackView()
            hstackView.axis = .horizontal
            hstackView.distribution = .fillEqually
            
            if type == .MainCalc {
                for inner in 0...3 {
                    hstackView.addArrangedSubview(ButtonView(mainButtons[outer][inner] as! CalcButton, model))
                }
            } else {
                for inner in 0...4 {
                    hstackView.addArrangedSubview(ButtonView(scientificsPads[outer][inner] as! CalcButton, model))
                }
            }
            
            vstackview.addArrangedSubview(hstackView)
        }
        
        addSubview(vstackview)
        
        vstackview.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
}

class ButtonView: UIView {
    
    let calculatorViewModel: CalculatorViewModel
    
    var title: CalcButton!
        
    let button: EMTNeumorphicButton = {
        let button = EMTNeumorphicButton(type: .custom)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.neumorphicLayer?.depthType = .convex
        button.neumorphicLayer?.cornerRadius = 8
        button.neumorphicLayer?.elementDepth = 4
        return button
    }()
    
    let text: UILabel = {
        let text = UILabel()
        text.text = "AAA"
        text.textAlignment = .center
        text.numberOfLines = 1
        text.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return text
    }()
    
    init(_ title: CalcButton, _ model: CalculatorViewModel) {
        self.title = title
        self.calculatorViewModel = model
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        text.text = title.text()
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        calculatorViewModel.execute(input: input.eraseToAnyPublisher())
    }
    
    private func setupView() {
        addSubview(button)
         button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        addSubview(text)
        text.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        button.addTarget(self, action: #selector(actionButton(_:)), for: .touchUpInside)

    }
    
    private let input: PassthroughSubject<CalcButton, Never> = .init()
    
    @objc private func actionButton(_ sender: EMTNeumorphicButton) {
        print("action button")
        input.send(title)
    }
}
