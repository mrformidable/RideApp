//
//  LocationSelectionView.swift
//  mytaxi
//
//  Created by Michael A on 2018-06-10.
//  Copyright © 2018 AI Labs. All rights reserved.
//

import Foundation
import UIKit

class LocationSelectionView: UIView {
    
    lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 5
        return v
    }()
    
    private let dividerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.groupTableViewBackground
        return v
    }()
    
    private let startIconIv: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    private let dottedPathIv: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Line")
        return iv
    }()
    
    private let endIconIv: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    lazy var startLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Pickup Address"
        tf.isEnabled = false
        return tf
    }()
    
    lazy var endLocationTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.placeholder = "Dropoff Address"
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(startLocationTextField)
        containerView.addSubview(endLocationTextField)
        containerView.addSubview(dividerView)
        containerView.addSubview(startIconIv)
        containerView.addSubview(dottedPathIv)
        containerView.addSubview(endIconIv)
        
        containerView.anchorConstraints(topAnchor: topAnchor, topConstant: 0, leftAnchor: leftAnchor, leftConstant: 0, rightAnchor: rightAnchor, rightConstant: 0, bottomAnchor: bottomAnchor, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        
        startLocationTextField.anchorConstraints(topAnchor: containerView.topAnchor, topConstant: 0, leftAnchor: startIconIv.rightAnchor, leftConstant: 15, rightAnchor: rightAnchor, rightConstant: 0, bottomAnchor: dividerView.bottomAnchor, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        
        startIconIv.anchorConstraints(topAnchor: nil, topConstant: 0, leftAnchor: containerView.leftAnchor, leftConstant: 7, rightAnchor: nil, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 10, widthConstant: 10)
        startIconIv.anchorCenterConstraints(centerXAnchor: nil, xConstant: 0, centerYAnchor: startLocationTextField.centerYAnchor, yConstant: 0)
        
        dottedPathIv.anchorConstraints(topAnchor: startIconIv.bottomAnchor, topConstant: 4, leftAnchor: startIconIv.centerXAnchor, leftConstant: -1, rightAnchor: nil, rightConstant: 0, bottomAnchor: endIconIv.topAnchor, bottomConstant: -4, heightConstant: 0, widthConstant: 2)
        
        dividerView.anchorCenterConstraints(centerXAnchor: nil, xConstant: 0, centerYAnchor: containerView.centerYAnchor, yConstant: 0)
        dividerView.anchorConstraints(topAnchor: nil, topConstant: 0, leftAnchor: dottedPathIv.leftAnchor, leftConstant: 10, rightAnchor: containerView.rightAnchor, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 0.5, widthConstant: 0)
        
        endLocationTextField.anchorConstraints(topAnchor: dividerView.topAnchor, topConstant: 0, leftAnchor: endIconIv.rightAnchor, leftConstant: 15, rightAnchor: rightAnchor, rightConstant: 0, bottomAnchor: containerView.bottomAnchor, bottomConstant: 0, heightConstant: 0, widthConstant: 0)
        
        endIconIv.anchorCenterConstraints(centerXAnchor: nil, xConstant: 0, centerYAnchor: endLocationTextField.centerYAnchor, yConstant: 0)
        endIconIv.anchorConstraints(topAnchor: nil, topConstant: 0, leftAnchor: containerView.leftAnchor, leftConstant: 7, rightAnchor: nil, rightConstant: 0, bottomAnchor: nil, bottomConstant: 0, heightConstant: 10, widthConstant: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
