//
//  GameResultsTableViewCell.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit

class GameResultsTableViewCell: UITableViewCell {
    
    //MARK: - Elements
    var teamLogo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt Thin", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt Thin", size: 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Marker Felt Thin", size: 15)
        label.textAlignment = .center
        label.text = "Point(s)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Methods
    func setLayout() {
        contentView.addSubview(teamLogo)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(pointsLabel)
    }
    
    func set(buttonImage: String) {
        teamLogo.image = UIImage(named: buttonImage)
    }
    
    func set(teamName: String){
        teamNameLabel.text = teamName
    }
}

//MARK: - Constraints
extension GameResultsTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            teamLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            teamLogo.widthAnchor.constraint(equalToConstant: 56),
            teamLogo.heightAnchor.constraint(equalToConstant: 56),
            teamLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            teamLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            teamNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            teamNameLabel.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 34),
            teamNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            teamNameLabel.widthAnchor.constraint(equalToConstant: 160),
            
            scoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            scoreLabel.widthAnchor.constraint(equalToConstant: 57),
            
            pointsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 0),
            pointsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pointsLabel.widthAnchor.constraint(equalToConstant: 57)
        ])
    }
}
