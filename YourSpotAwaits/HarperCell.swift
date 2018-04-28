//
//  HarperCell.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/28/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit


class HarperCell: UITableViewCell {
    
    var school: Institutions? {
        didSet {
            universityName.text = "Harper College"
            coverImageView.image = #imageLiteral(resourceName: "Harper-73")
        }
    }
    
    let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let universityName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(universityName)
        universityName.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        universityName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        universityName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        universityName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
