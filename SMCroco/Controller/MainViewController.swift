//
//  MainViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 17.04.2023.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - Elements
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let crocoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Croco")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var startButton: UIButton = {
       let button = UIButton()
        button.setTitle("Старт игры", for: .normal)
        button.backgroundColor = Theme.appColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Theme.accentColor.cgColor
        button.addTarget(self, action: #selector(goToTeams), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rulesButton: UIButton = {
       let button = UIButton()
        button.setTitle("Правила", for: .normal)
        button.backgroundColor = Theme.appColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Theme.accentColor.cgColor
        button.addTarget(self, action: #selector(goToRules), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resultButton: UIButton = {
       let button = UIButton()
        button.setTitle("Результаты", for: .normal)
        button.backgroundColor = Theme.orangeColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = Theme.accentColor.cgColor
        button.addTarget(self, action: #selector(goToResults), for: .touchUpInside)
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
        view.addSubview(crocoImageView)
        view.addSubview(startButton)
        view.addSubview(rulesButton)
        view.addSubview(resultButton)
    }
    
    @objc private func goToTeams() {
        print("Start")
        let vc = TeamsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToRules() {
        print("Rules")
        let vc = RulesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToResults() {
        print("Rules")
        let vc = BestGamesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Constraints
extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            crocoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 172),
            crocoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            crocoImageView.heightAnchor.constraint(equalToConstant: 322),
            crocoImageView.widthAnchor.constraint(equalToConstant: 268),
            
            startButton.heightAnchor.constraint(equalToConstant: 83),
            startButton.widthAnchor.constraint(equalToConstant: 274),
            startButton.topAnchor.constraint(equalTo: crocoImageView.bottomAnchor, constant: 100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rulesButton.heightAnchor.constraint(equalToConstant: 73),
            rulesButton.widthAnchor.constraint(equalToConstant: 240),
            rulesButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            rulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultButton.heightAnchor.constraint(equalToConstant: 73),
            resultButton.widthAnchor.constraint(equalToConstant: 240),
            resultButton.topAnchor.constraint(equalTo: rulesButton.bottomAnchor, constant: 20),
            resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}
