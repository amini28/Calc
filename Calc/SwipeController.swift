//
//  SwipeController.swift
//  Calc
//
//  Created by Amini on 05/08/22.
//

import UIKit
import SnapKit

class SwipeController: UIViewController, UISheetPresentationControllerDelegate {
    
    var height: CGFloat = 0
    
    private let scientificsButton = ButtonPads(.Scientifics, CalculatorViewModel())
    private let bottomView = UIView()
    
    private let upView: UIImageView = {
        let upview = UIImageView()
        upview.image = UIImage(systemName: "chevron.compact.down")
        upview.contentMode = .scaleAspectFit
        return upview
    }()
    
    private let baseView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let sheetPresentationController = presentationController as? UISheetPresentationController {
            sheetPresentationController.detents = [
                .large()
            ]
            sheetPresentationController.delegate = self
            sheetPresentationController.selectedDetentIdentifier = .large
            sheetPresentationController.prefersGrabberVisible = false
            sheetPresentationController.preferredCornerRadius = 0
        }
        
        
        view.backgroundColor = .clear
        
        view.addSubview(baseView)
        
        baseView.backgroundColor = .offWhite
        baseView.layer.cornerRadius = 10
        
        baseView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(26+height+34)
        }
        
        baseView.addSubview(upView)
        baseView.addSubview(scientificsButton)
        baseView.addSubview(bottomView)
        
        
        
        upView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(8)
            make.bottom.equalTo(scientificsButton.snp.top)
            make.height.equalTo(26)
        }
        
        
        scientificsButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(height)
        }
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(34)
        }
        
        baseView.isUserInteractionEnabled = true
        let swipeGestureRecognizezrDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizezrDown.direction = .down

        baseView.addGestureRecognizer(swipeGestureRecognizezrDown)
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true)
    }
    
}

