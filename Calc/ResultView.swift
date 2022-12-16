//
//  ResultView.swift
//  Calc
//
//  Created by Amini on 05/09/22.
//

import Foundation
import UIKit
import Combine
import EMTNeumorphicView

class ResultView: UIView {
    let calculatorViewModel: CalculatorViewModel

    
    let bgView: EMTNeumorphicView = {
        let bgView = EMTNeumorphicView()
//        bgView.neumorphicLayer?.elementBackgroundColor = backgroundColor?.cgColor
        bgView.neumorphicLayer?.cornerRadius = 10
        bgView.neumorphicLayer?.depthType = .convex
        bgView.neumorphicLayer?.elementDepth = 7
        return bgView
    }()
    
    let operationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 100)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "0"
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        label.font = UIFont(name: "Verdana", size: 100)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.text = "0"
        return label
    }()
        
    init(_ model: CalculatorViewModel) {
        self.calculatorViewModel = model
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        addSubview(bgView)
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 10
        
        stackview.addArrangedSubview(operationLabel)
        stackview.addArrangedSubview(resultLabel)
        
        addSubview(stackview)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        
        stackview.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.height.equalTo(bgView.snp.height).multipliedBy(0.8)
        }
        
        operationLabel.snp.makeConstraints { make in
            make.height.equalTo(stackview.snp.height).multipliedBy(0.3)
        }
        
        calculatorViewModel.currentResult.sink { [unowned self] result in
            print("\(Thread.printCurrent())")
            
            self.resultLabel.text = result
            
        }.store(in: &subscriptions)
        
        calculatorViewModel.currentOperation.sink { [unowned self] operation in
            print("\(Thread.printCurrent())")
            
            self.operationLabel.text = operation
        }.store(in: &subscriptions)
        
    }
    
    var subscriptions = Set<AnyCancellable>()

}
