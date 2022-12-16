//
//  ViewController.swift
//  Calc
//
//  Created by Amini on 04/08/22.
//

import UIKit
import EMTNeumorphicView
import SnapKit
import Combine

class ViewController: UIViewController {
    
    let calculatorViewModel = CalculatorViewModel()
    
    private let splitPads: UIStackView = {
        let splitPads = UIStackView()
        splitPads.axis = .horizontal
        splitPads.distribution = .fillEqually
        splitPads.spacing = 10
        return splitPads
    }()
    
    public let pagedView = PagedView()
    
    var scientificsButton: ButtonPads = ButtonPads(.Scientifics, CalculatorViewModel())
    var manButotn: ButtonPads = ButtonPads(.MainCalc, CalculatorViewModel())
    
    private var splitState = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .offWhite
        
        scientificsButton = ButtonPads(.Scientifics, calculatorViewModel)
        manButotn = ButtonPads(.MainCalc, calculatorViewModel)
        
        navigationController?.navigationBar.backgroundColor = .offWhite
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: nil)

        if self.view.traitCollection.horizontalSizeClass == .compact &&
            self.view.traitCollection.verticalSizeClass == .regular {
            
        }
        
        // main stack
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 8
        
        // result stack
        let viewbg = ResultView(calculatorViewModel)
        
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        let width = guide.layoutFrame.size.width
        
        viewbg.snp.makeConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height/4)
        }
        
        pageControl.snp.makeConstraints { make in
            make.width.height.equalTo(34)
        }
        
//        if splitState {
//            splitPads.addArrangedSubview(scientificsButton)
//            splitPads.addArrangedSubview(manButotn)
//        } else {
//            splitPads.addArrangedSubview(manButotn)
//        }
        
        pagedView.pages = [
            scientificsButton,
            manButotn
        ]
        
        mainStackView.addArrangedSubview(viewbg)
        mainStackView.addArrangedSubview(pagedView)
        mainStackView.addArrangedSubview(pageControl)
                
        pagedView.delegate = self
        
        view.addSubview(mainStackView)
        
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
}

extension ViewController: PagedViewDelegate {
    func didMoveToPage(index: Int) {
        
    }
}

extension UIColor {
    static let offWhite = UIColor.init(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
}

extension Thread {
    class func printCurrent() {
        print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
    }
}

