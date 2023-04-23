//
//  CategoryCell.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit
import SnapKit

class CategoryCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    
    //  MARK: - Elements
    private lazy var categoryLogo: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var categoryName: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.numberOfLines = 0
        element.font = UIFont.systemFont(ofSize: 22)
        element.textColor = .white
        return element
    }()
    
    private lazy var selectionBox: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "checkmark.circle.fill")
        element.tintColor = .white
        element.backgroundColor = .clear
        element.layer.cornerRadius = 15
        element.clipsToBounds = true
        element.isHidden = true
        return element
    }()
    
    //  MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Methods
    func configure(categoryPicture: String, categoryText: String) {
        categoryLogo.image = UIImage(named: categoryPicture)
        categoryName.text = categoryText
    }
    
    func showImage() {
        selectionBox.isHidden.toggle()
    }
    
    func imageCheched() -> Bool {
        !selectionBox.isHidden
    }
    
    //MARK: - Methods
    private func setViews() {
        addSubview(categoryLogo)
        addSubview(categoryName)
        addSubview(selectionBox)
    }
}

//  MARK: -  Constraints
extension CategoryCell {
    private func setConstraints() {
        selectionBox.snp.makeConstraints { make in
            make.centerY.equalTo(categoryName.snp.centerY)
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().inset(20)
        }
        
        categoryName.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        categoryLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(56)
            make.leading.equalToSuperview().inset(17)
        }
    }
}
