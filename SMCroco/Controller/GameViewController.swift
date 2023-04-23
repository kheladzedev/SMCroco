//
//  GameViewController.swift
//  SMCroco
//
//  Created by Damir Zaripov on 18.04.2023.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    //MARK: - Instances
    var timer = Timer()
    var counter = 60
    var player: AVAudioPlayer!
    var index = 0
    var audioSession = AVAudioSession.sharedInstance()
    let categoryNames = [0: animalsArray, 1: foodArray, 2: peopleArray, 3: hobbyArray]
    lazy var word = categoryNames[index]?.randomElement() ?? ""
    
    //MARK: - Elements
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "BackgroundWithoutGrass"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let crocoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "RectangleCroco"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.text = "1:00"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimer), userInfo:nil, repeats: true)
        return label
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ruleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = howToExplainArray.randomElement()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.appColor
        button.setTitle("Правильно", for: .normal)
        button.setTitleColor(.white, for: .normal)
        switch button.state {
        case .normal: button.alpha = 1
        case .selected, .highlighted, .disabled: button.alpha = 0.8
        default:
            button.alpha = 1
        }
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(correctButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled  = true
        return button
    }()
    
    private lazy var wrongButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.red
        button.setTitle("Нарушил правила", for: .normal)
        button.setTitleColor(.white, for: .normal)
        switch button.state {
        case .normal: button.alpha = 1
        case .selected, .highlighted, .disabled: button.alpha = 0.8
        default:
            button.alpha = 1
        }
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(wrongButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled  = true
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.neutralColor
        button.setTitle("Сбросить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        switch button.state {
        case .normal: button.alpha = 1
        case .selected, .highlighted, .disabled: button.alpha = 0.8
        default:
            button.alpha = 1
        }
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled  = true
        return button
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setupConstraints()
        navigationItem.hidesBackButton = true
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        wordLabel.text = word
        print("Index for words array is \(index)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
  
    //MARK: - Methods
    private func setLayout() {
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(crocoImage)
        backgroundImage.addSubview(timerLabel)
        backgroundImage.addSubview(wordLabel)
        backgroundImage.addSubview(ruleLabel)
        backgroundImage.addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(rightButton)
        buttonsStack.addArrangedSubview(wrongButton)
        buttonsStack.addArrangedSubview(resetButton)
    }
    func updateUI() {
        wordLabel.text = word
        print("Index for words array is \(index)")
    }
    
    func playMusicFile(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateTimer() {
        switch counter {
        case 1...10:
            counter -= 1
            timerLabel.text = "0:0\(counter.description)"
        case 11:
            playMusicFile(soundName: "10sec")
            counter -= 1
            timerLabel.text = "0:\(counter.description)"
        case 12...60:
            counter -= 1
            timerLabel.text = "0:\(counter.description)"
        case 0:
            timerLabel.text = "Время вышло"
            playMusicFile(soundName: "game-lost")
            timerLabel.textColor = .red
        default:
            timer.invalidate()
        }
    }
    
    @objc func correctButtonTapped() {
        let dataManager = DataManager.shared
        if dataManager.currentTeam > dataManager.numberOfTeams {
            dataManager.currentTeam += 1
        }
        dataManager.totalRounds += 1
        teams[dataManager.currentTeam].points += 1
        
        timer.invalidate()
        let vc = RoundResultsViewController()
        vc.index = index
        playMusicFile(soundName: "pravilnyiy-otvet")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func wrongButtonTapped() {
        let dataManager = DataManager.shared
        if dataManager.currentTeam > dataManager.numberOfTeams {
            dataManager.currentTeam += 1
        }
        dataManager.totalRounds += 1
        let vc = RoundResultsViewController()
        vc.congratutalionLabel.text = "УВЫ И АХ!"
        vc.getPointsLabel.text = "Вы не отгадали слово и не получаете очков!"
        vc.resultLabel.text = "0"
        vc.roundResults.backgroundColor = Theme.red
        timer.invalidate()
        vc.index = index
        playMusicFile(soundName: "game-lost")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func resetButtonTapped() {
        let ac = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить Вашу игру и вернуться в главное меню?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
        ac.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { (action: UIAlertAction!) in
            self.timer.invalidate()
            let VC = MainViewController()
            self.navigationController?.pushViewController(VC, animated: true)
            for i in 0..<teams.count {
                teams[i].points = 0
            }
        }))
    }
}

//MARK: - Constraints
extension GameViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            crocoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            crocoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: crocoImage.bottomAnchor, constant: 57),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            timerLabel.heightAnchor.constraint(equalToConstant: 45),
            
            wordLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 90),
            wordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            wordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            wordLabel.bottomAnchor.constraint(equalTo: ruleLabel.topAnchor, constant: -20),
            
            ruleLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 10),
            ruleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ruleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            buttonsStack.topAnchor.constraint(equalTo: ruleLabel.bottomAnchor, constant: 100),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            buttonsStack.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
