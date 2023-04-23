//
//  TeamsTableViewCell.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit
import SnapKit

class TeamsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: TeamsTableViewCell.self)
    
    //  MARK: - Elements
    private lazy var playerImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var playerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Marker Felt Thin", size: 40)
        return label
    }()
    
    var removeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")
        button.isHidden = true
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        return button
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
    
    //MARK: - Methods
    func configure(playerName: String, imageName: UIImage) {
        playerLabel.text = playerName
        playerImage.image = imageName
    }
    
    private func setViews() {
        addSubview(playerImage)
        addSubview(playerLabel)
        addSubview(removeButton)
    }
}

//  MARK: -  Constraints
extension TeamsTableViewCell {
    private func setConstraints() {
        removeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(playerLabel.snp.centerY)
            make.height.width.equalTo(40)
        }
        
        playerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        playerImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(17)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(56)
        }
    }
}
