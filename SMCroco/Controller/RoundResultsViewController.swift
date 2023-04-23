//
//  RoundResultsViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 18.04.2023.
//

import UIKit
import AVFoundation

class RoundResultsViewController: UIViewController {
    
    //MARK: - Instances
    var audioSession = AVAudioSession.sharedInstance()
    var index = 0
    
    //MARK: - Elements
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "BackgroundWithoutGrass"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var teamView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var teamLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TeamImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "\(teams[DataManager.shared.currentTeam].name)"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamScore: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var teamScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.text = "\(teams[DataManager.shared.currentTeam].points)"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scoreTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.text = "Point(s)"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var roundResults: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.appColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var congratutalionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "Поздравляем"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var getPointsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Вы получаете"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Star"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 70)
        label.text = "1"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "ОЧКИ"
        label.textColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "следующий ход - \(teams[1].name)"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passTurnButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 351, height: 60)
        button.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1)
        button.setTitle("Передать ход", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled  = true
        button.addTarget(self, action: #selector(tapPassButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultsButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.frame = CGRect(x: 0, y: 0, width: 351, height: 60)
        button.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1)
        button.setTitle("Результаты", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled  = true
        button.addTarget(self, action: #selector(resultsTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subviews()
        setupConstraints()
        navigationItem.hidesBackButton = true
        reloadButton()
        print(index)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        do {
            try audioSession.setCategory(.ambient, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        teamNames()
    }
    
    //MARK: - Methods
    private func subviews() {
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(teamView)
        backgroundImage.addSubview(roundResults)
        backgroundImage.addSubview(passTurnButton)
        backgroundImage.addSubview(resultsButton)
        teamView.addSubview(teamLogo)
        teamView.addSubview(teamNameLabel)
        teamView.addSubview(teamScore)
        teamScore.addSubview(teamScoreLabel)
        teamScore.addSubview(scoreTopLabel)
        roundResults.addSubview(congratutalionLabel)
        roundResults.addSubview(getPointsLabel)
        roundResults.addSubview(starImage)
        starImage.addSubview(resultLabel)
        roundResults.addSubview(scoreLabel)
        roundResults.addSubview(nextTeamLabel)
    }
    
    func teamNames() {
        let currentTeam = DataManager.shared.currentTeam
        let nextTeam = (currentTeam + 1) % teams.count
        
        teamNameLabel.text = teams[currentTeam].name
        nextTeamLabel.text = "Следующий ход - \(teams[nextTeam].name)"
    }
    
    func reloadButton(){
        if DataManager.shared.totalRounds == teams.count * 5 {
            DataManager.shared.totalRounds = 0
            passTurnButton.isHidden = true
            resultsButton.isHidden = false
        }
    }
    
    @objc func tapPassButton() {
        if DataManager.shared.totalRounds <= teams.count * 5 {
            let nextTeam = (DataManager.shared.currentTeam + 1) % teams.count
            DataManager.shared.currentTeam = nextTeam
            let gameVC = GameViewController()
            gameVC.index = index
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
    @objc func resultsTapped() {
        let VC = GameTotalResultsViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK: - Constraints
extension RoundResultsViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            teamView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            teamView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 12),
            teamView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -12),
            teamView.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            teamLogo.leadingAnchor.constraint(equalTo: teamView.leadingAnchor, constant: 15),
            teamLogo.topAnchor.constraint(equalTo: teamView.topAnchor, constant: 15),
            teamLogo.bottomAnchor.constraint(equalTo: teamView.bottomAnchor, constant: -15),
            teamLogo.widthAnchor.constraint(equalToConstant: 80),
            teamLogo.heightAnchor.constraint(equalToConstant: 80),
            
            teamNameLabel.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 15),
            teamNameLabel.centerYAnchor.constraint(equalTo: teamLogo.centerYAnchor),
            
            teamScore.trailingAnchor.constraint(equalTo: teamView.trailingAnchor, constant: -40),
            teamScore.centerYAnchor.constraint(equalTo: teamLogo.centerYAnchor),
            
            teamScoreLabel.topAnchor.constraint(equalTo: teamScore.topAnchor),
            teamScoreLabel.centerXAnchor.constraint(equalTo: teamScore.centerXAnchor),
            
            scoreTopLabel.topAnchor.constraint(equalTo: teamScoreLabel.bottomAnchor),
            scoreTopLabel.centerXAnchor.constraint(equalTo: teamScore.centerXAnchor),
            scoreTopLabel.bottomAnchor.constraint(equalTo: teamScore.bottomAnchor),
            
            roundResults.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            roundResults.topAnchor.constraint(equalTo: teamView.bottomAnchor, constant: 86),
            roundResults.heightAnchor.constraint(equalToConstant: 301),
            roundResults.widthAnchor.constraint(equalToConstant: 351),
            
            congratutalionLabel.topAnchor.constraint(equalTo: roundResults.topAnchor, constant: 43),
            congratutalionLabel.centerXAnchor.constraint(equalTo: roundResults.centerXAnchor),
            
            getPointsLabel.topAnchor.constraint(equalTo: congratutalionLabel.bottomAnchor, constant: 24),
            getPointsLabel.centerXAnchor.constraint(equalTo: roundResults.centerXAnchor),
            
            starImage.topAnchor.constraint(equalTo: getPointsLabel.bottomAnchor, constant: 4),
            starImage.centerXAnchor.constraint(equalTo: roundResults.centerXAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 100),
            starImage.heightAnchor.constraint(equalToConstant: 100),
            
            resultLabel.centerXAnchor.constraint(equalTo: starImage.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            scoreLabel.centerXAnchor.constraint(equalTo: roundResults.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: starImage.bottomAnchor),
            
            nextTeamLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5),
            nextTeamLabel.centerXAnchor.constraint(equalTo: roundResults.centerXAnchor),
            
            passTurnButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            passTurnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passTurnButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 12),
            passTurnButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -12),
            passTurnButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultsButton.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 12),
            resultsButton.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -12),
            resultsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

