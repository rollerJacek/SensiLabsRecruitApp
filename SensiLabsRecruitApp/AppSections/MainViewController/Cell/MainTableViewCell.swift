//
//  MainTableViewCell.swift
//  SensiLabsRecruitApp
//
//  Created by Jacek Stąporek on 12/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    lazy var container: UIView = UIView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var arrow: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = ">"
        label.font = .systemFont(ofSize: 25, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        constraintView()
        addShadow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintView() {
        container.edgesToSuperview(insets: .uniform(10), usingSafeArea: true)
        
        titleLabel.top(to: container, offset: 20)
        titleLabel.left(to: container, offset: 20)
        titleLabel.bottom(to: container, container.centerYAnchor, offset: 5)
        
        descriptionLabel.top(to: container, container.centerYAnchor, offset: 5)
        descriptionLabel.left(to: titleLabel, offset: 5)
        descriptionLabel.bottom(to: container, offset: -20)
        
        arrow.top(to: container)
        arrow.right(to: container)
        arrow.bottom(to: container)
        arrow.leftToRight(of: titleLabel)
        arrow.leftToRight(of: descriptionLabel)
        arrow.width(30)
    }
    
    func addSubviews() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(arrow)
    }
    
    func addShadow() {
        backgroundColor = .clear
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = false
        container.layer.shadowOpacity = 0.1
        container.layer.shadowRadius = 4
        container.layer.shadowOffset = CGSize(width: 0, height: 3)
        container.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
}
