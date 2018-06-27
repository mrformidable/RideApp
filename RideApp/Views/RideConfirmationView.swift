//
//  RideConfirmationView.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import UIKit

protocol RideConfirmationViewDelegate: class {
    func confirmPaymentButtonTapped()
    func taxiIconButtonTapped()
    func poolIconButtonTapped()
}

class RideConfirmationView: UIView {
    
    weak var delegate: RideConfirmationViewDelegate?
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Choose Your Ride"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        return title
    }()
    
    lazy var paymentTypeIconImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        v.image = #imageLiteral(resourceName: "visaCard_icon")
        return v
    }()
    
    lazy var taxiRideIconView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "taxi")
        v.contentMode = .scaleAspectFill
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(taxiIconTapped)))
        return v
    }()
    
    lazy var poolRideIconView: UIImageView = {
        let v = UIImageView()
        v.image = #imageLiteral(resourceName: "sedan")
        v.contentMode = .scaleAspectFill
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(poolIconTapped)))
        return v
    }()
    
    private let dividerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    let poolCostLabel: UILabel = {
        let title = UILabel()
        title.text = "£6.30"
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        title.textAlignment = .center
        return title
    }()
    
    let taxiCostLabel: UILabel = {
        let title = UILabel()
        title.text = "£8.70"
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        title.textAlignment = .center
        return title
    }()
    
    lazy var confirmRideButton: UIButton = {
        let btn = UIButton()
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 19), NSAttributedStringKey.foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: "Confirm Ride", attributes: attributes)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.themeIndigoDark()
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(confirmRideButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    @objc func confirmRideButtonTapped() {
        delegate?.confirmPaymentButtonTapped()
    }
    
    @objc func poolIconTapped() {
        delegate?.poolIconButtonTapped()
    }
    
    @objc func taxiIconTapped() {
        delegate?.taxiIconButtonTapped()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(poolRideIconView)
        addSubview(taxiRideIconView)
        addSubview(poolCostLabel)
        addSubview(taxiCostLabel)
        addSubview(dividerView)
        addSubview(paymentTypeIconImageView)
        addSubview(confirmRideButton)
        
        titleLabel.anchorConstraints(topAnchor: topAnchor, topConstant: 10, leftAnchor: leftAnchor, leftConstant: 0, rightAnchor: rightAnchor, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        poolRideIconView.anchorConstraints(topAnchor: titleLabel.bottomAnchor, topConstant: 0, leftAnchor: leftAnchor, leftConstant: 50, rightAnchor: nil, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 35, widthConstant: 80)
        
        taxiRideIconView.anchorConstraints(topAnchor: titleLabel.bottomAnchor, topConstant: 0, leftAnchor: nil, leftConstant: 40, rightAnchor: rightAnchor, rightConstant: -50, bottomAnchor: nil, bottomConstant: 0, heightConstant: 38, widthConstant: 80)
        
        poolCostLabel.anchorConstraints(topAnchor: poolRideIconView.bottomAnchor, topConstant: 0, leftAnchor: poolRideIconView.leftAnchor, leftConstant: 0, rightAnchor: poolRideIconView.rightAnchor, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        
        taxiCostLabel.anchorConstraints(topAnchor: taxiRideIconView.bottomAnchor, topConstant: 0, leftAnchor: taxiRideIconView.leftAnchor, leftConstant: 0, rightAnchor: taxiRideIconView.rightAnchor, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        
        dividerView.anchorConstraints(topAnchor: taxiCostLabel.bottomAnchor, topConstant: 5, leftAnchor: leftAnchor, leftConstant: 10, rightAnchor: rightAnchor, rightConstant: -10, bottomAnchor: nil, bottomConstant: 0, heightConstant: 1, widthConstant: 0)
        
        paymentTypeIconImageView.anchorConstraints(topAnchor: dividerView.bottomAnchor, topConstant: 5, leftAnchor: leftAnchor, leftConstant: 10, rightAnchor: nil, rightConstant: 0, bottomAnchor: confirmRideButton.topAnchor, bottomConstant: -5, heightConstant: 0, widthConstant: 0)
        
        confirmRideButton.anchorConstraints(topAnchor: nil, topConstant: 0, leftAnchor: leftAnchor, leftConstant: 10, rightAnchor: rightAnchor, rightConstant: -20, bottomAnchor: bottomAnchor, bottomConstant: -15, heightConstant: 45, widthConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
