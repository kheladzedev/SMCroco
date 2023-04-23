//
//  CorrectViewController.swift
//  SMCroco
//
//  Created by Damir Zaripov on 17.04.2023.
//

import UIKit

class CorrectViewController: UIViewController {
    
    //MARK: - Elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BlankBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TeamImage")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.zPosition = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let whiteCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let greenRectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.appColor
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ковбои"
        label.textAlignment = .center
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalScoreNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 65)
        label.layer.zPosition = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляем"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "ОЧКИ"
        label.textColor = .yellow
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.layer.zPosition = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let receiveLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы получаете"
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextTurnLabel: UILabel = {
        let label = UILabel()
        label.text = "Следующий ход - 'Стройняшки'"
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Star")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var changeTurnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Передать ход", for: .normal)
        button.backgroundColor = Theme.appColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(teamViewControllerScreenPrint), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraints()
    }
    
    //MARK: - Private Methods
    private func setLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(teamImageView)
        view.addSubview(whiteCellView)
        view.addSubview(totalScoreNumberLabel)
        view.addSubview(totalScoreLabel)
        view.addSubview(greenRectangleView)
        view.addSubview(teamNameLabel)
        view.addSubview(congratulationsLabel)
        view.addSubview(receiveLabel)
        view.addSubview(scoreLabel)
        view.addSubview(scoreNumberLabel)
        view.addSubview(nextTurnLabel)
        view.addSubview(starImageView)
        view.addSubview(changeTurnButton)
        
    }
    
    @objc private func teamViewControllerScreenPrint() {
        print("Change turn")
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            teamImageView.heightAnchor.constraint(equalToConstant: 56),
            teamImageView.widthAnchor.constraint(equalToConstant: 56),
            teamImageView.topAnchor.constraint(equalTo: whiteCellView.topAnchor, constant: 20),
            teamImageView.leadingAnchor.constraint(equalTo: whiteCellView.leadingAnchor, constant: 15),
            teamImageView.trailingAnchor.constraint(equalTo: whiteCellView.trailingAnchor, constant: -280),
            teamImageView.bottomAnchor.constraint(equalTo: whiteCellView.bottomAnchor, constant: -20),
            teamImageView.centerXAnchor.constraint(equalTo: whiteCellView.centerXAnchor),
            
            teamNameLabel.heightAnchor.constraint(equalToConstant: 22),
            teamNameLabel.widthAnchor.constraint(equalToConstant: 71),
            teamNameLabel.centerYAnchor.constraint(equalTo: whiteCellView.centerYAnchor),
            teamNameLabel.centerXAnchor.constraint(equalTo: whiteCellView.centerXAnchor),
            teamNameLabel.topAnchor.constraint(equalTo: whiteCellView.topAnchor, constant: 37),
            teamNameLabel.bottomAnchor.constraint(equalTo: whiteCellView.bottomAnchor, constant: -37),
            teamNameLabel.leadingAnchor.constraint(equalTo: whiteCellView.leadingAnchor, constant: 105),
            teamNameLabel.trailingAnchor.constraint(equalTo: whiteCellView.trailingAnchor, constant: -175),
            
            totalScoreNumberLabel.heightAnchor.constraint(equalToConstant: 46),
            totalScoreNumberLabel.widthAnchor.constraint(equalToConstant: 57),
            totalScoreNumberLabel.centerYAnchor.constraint(equalTo: whiteCellView.centerYAnchor),
            totalScoreNumberLabel.centerXAnchor.constraint(equalTo: whiteCellView.centerXAnchor),
            totalScoreNumberLabel.topAnchor.constraint(equalTo: whiteCellView.topAnchor, constant: 15),
            totalScoreNumberLabel.bottomAnchor.constraint(equalTo: whiteCellView.bottomAnchor, constant: -19),
            totalScoreNumberLabel.leadingAnchor.constraint(equalTo: whiteCellView.leadingAnchor, constant: 290),
            totalScoreNumberLabel.trailingAnchor.constraint(equalTo: whiteCellView.trailingAnchor, constant: -4),
            
            totalScoreLabel.heightAnchor.constraint(equalToConstant: 22),
            totalScoreLabel.widthAnchor.constraint(equalToConstant: 38),
            totalScoreLabel.centerYAnchor.constraint(equalTo: whiteCellView.centerYAnchor),
            totalScoreLabel.centerXAnchor.constraint(equalTo: whiteCellView.centerXAnchor),
            totalScoreLabel.topAnchor.constraint(equalTo: whiteCellView.topAnchor, constant: 66),
            totalScoreLabel.bottomAnchor.constraint(equalTo: whiteCellView.bottomAnchor, constant: -8),
            totalScoreLabel.leadingAnchor.constraint(equalTo: whiteCellView.leadingAnchor, constant: 297),
            totalScoreLabel.trailingAnchor.constraint(equalTo: whiteCellView.trailingAnchor, constant: -10),
            
            
            changeTurnButton.heightAnchor.constraint(equalToConstant: 60),
            changeTurnButton.widthAnchor.constraint(equalToConstant: 351),
            changeTurnButton.topAnchor.constraint(equalTo: greenRectangleView.bottomAnchor, constant: 144),
            changeTurnButton.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -46),
            changeTurnButton.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 12),
            changeTurnButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -12),
            changeTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            whiteCellView.heightAnchor.constraint(equalToConstant: 96),
            whiteCellView.widthAnchor.constraint(equalToConstant: 351),
            whiteCellView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            whiteCellView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 84),
            whiteCellView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -637),
            whiteCellView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 12),
            whiteCellView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -12),
            whiteCellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            greenRectangleView.heightAnchor.constraint(equalToConstant: 301),
            greenRectangleView.widthAnchor.constraint(equalToConstant: 351),
            greenRectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greenRectangleView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 266),
            greenRectangleView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -250),
            greenRectangleView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 12),
            greenRectangleView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -12),
            greenRectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            congratulationsLabel.heightAnchor.constraint(equalToConstant: 22),
            congratulationsLabel.widthAnchor.constraint(equalToConstant: 203),
            congratulationsLabel.centerYAnchor.constraint(equalTo: greenRectangleView.centerYAnchor),
            congratulationsLabel.centerXAnchor.constraint(equalTo: greenRectangleView.centerXAnchor),
            congratulationsLabel.topAnchor.constraint(equalTo: greenRectangleView.topAnchor, constant: 43),
            congratulationsLabel.bottomAnchor.constraint(equalTo: greenRectangleView.bottomAnchor, constant: -236),
            congratulationsLabel.leadingAnchor.constraint(equalTo: greenRectangleView.leadingAnchor, constant: 82),
            congratulationsLabel.trailingAnchor.constraint(equalTo: greenRectangleView.trailingAnchor, constant: -66),
            
            receiveLabel.heightAnchor.constraint(equalToConstant: 22),
            receiveLabel.widthAnchor.constraint(equalToConstant: 301),
            receiveLabel.centerYAnchor.constraint(equalTo: greenRectangleView.centerYAnchor),
            receiveLabel.centerXAnchor.constraint(equalTo: greenRectangleView.centerXAnchor),
            receiveLabel.topAnchor.constraint(equalTo: greenRectangleView.topAnchor, constant: 89),
            receiveLabel.bottomAnchor.constraint(equalTo: starImageView.topAnchor, constant: -3.48),
            receiveLabel.leadingAnchor.constraint(equalTo: greenRectangleView.leadingAnchor, constant: 28.57),
            receiveLabel.trailingAnchor.constraint(equalTo: greenRectangleView.trailingAnchor, constant: -21.43),
            
            scoreLabel.heightAnchor.constraint(equalToConstant: 22),
            scoreLabel.widthAnchor.constraint(equalToConstant: 69),
            scoreLabel.centerYAnchor.constraint(equalTo: greenRectangleView.centerYAnchor),
            scoreLabel.centerXAnchor.constraint(equalTo: greenRectangleView.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: greenRectangleView.topAnchor, constant: 203),
            scoreLabel.bottomAnchor.constraint(equalTo: greenRectangleView.bottomAnchor, constant: -50),
            scoreLabel.leadingAnchor.constraint(equalTo: greenRectangleView.leadingAnchor, constant: 149),
            scoreLabel.trailingAnchor.constraint(equalTo: greenRectangleView.trailingAnchor, constant: -133),
            
            scoreNumberLabel.heightAnchor.constraint(equalToConstant: 46),
            scoreNumberLabel.widthAnchor.constraint(equalToConstant: 58.16),
            scoreNumberLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            scoreNumberLabel.centerXAnchor.constraint(equalTo: starImageView.centerXAnchor),
            scoreNumberLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 42.52),
            scoreNumberLabel.bottomAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: -30),
            scoreNumberLabel.leadingAnchor.constraint(equalTo: starImageView.leadingAnchor, constant: 21.18),
            scoreNumberLabel.trailingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: -30.75),
            
            nextTurnLabel.heightAnchor.constraint(equalToConstant: 22),
            nextTurnLabel.widthAnchor.constraint(equalToConstant: 301),
            nextTurnLabel.centerYAnchor.constraint(equalTo: greenRectangleView.centerYAnchor),
            nextTurnLabel.centerXAnchor.constraint(equalTo: greenRectangleView.centerXAnchor),
            nextTurnLabel.topAnchor.constraint(equalTo: greenRectangleView.topAnchor, constant: 233),
            nextTurnLabel.bottomAnchor.constraint(equalTo: greenRectangleView.bottomAnchor, constant: -10),
            nextTurnLabel.leadingAnchor.constraint(equalTo: greenRectangleView.leadingAnchor, constant: 31.63),
            nextTurnLabel.trailingAnchor.constraint(equalTo: greenRectangleView.trailingAnchor, constant: -18.37),
            
            
            starImageView.heightAnchor.constraint(equalToConstant: 98.04),
            starImageView.widthAnchor.constraint(equalToConstant: 110.09),
            starImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            starImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starImageView.topAnchor.constraint(equalTo: greenRectangleView.topAnchor, constant: 114.48),
            starImageView.bottomAnchor.constraint(equalTo: greenRectangleView.bottomAnchor, constant: -88.48),
            starImageView.leadingAnchor.constraint(equalTo: greenRectangleView.leadingAnchor, constant: 128.82),
            starImageView.trailingAnchor.constraint(equalTo: greenRectangleView.trailingAnchor, constant: -112.09),
            
        ])
    }
}
