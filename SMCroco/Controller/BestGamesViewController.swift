//
//  BestGamesViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit

class BestGamesViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    //MARK: - Instances
    var teamLogos = [UIImage(named: "food"), UIImage(named: "frog"), UIImage(named: "hobby"), UIImage(named: "people")]
    var teamName = ["Ковбои", "Красотки", "Челики", "Жуки", "Киборги", "Роботы"]
    lazy var shuffledTeamNames = teamName.shuffled()
    lazy var shuffledTeamLogos = teamLogos.shuffled()
    var points = String(5)
    
    //MARK: - Elements
    private lazy var clearResultsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Очистить", for: .normal)
        button.backgroundColor = Theme.appColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearResultsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelResult: UILabel = {
        let label = UILabel()
        label.text = "Таблица лидеров"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "BackgroundWithoutGrass")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var teamsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameResultsTableViewCell.self, forCellReuseIdentifier: "team")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraints()
    }
    
    //MARK: - Methods
    private func setLayout () {
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
        view.addSubview(backgroundImage)
        view.addSubview(labelResult)
        view.addSubview(teamsTableView)
        view.addSubview(clearResultsButton)
    }
    
    @objc func clearResultsTapped () {
        teamName = []
    }
}

extension BestGamesViewController {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            labelResult.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            labelResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            teamsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            teamsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teamsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teamsTableView.bottomAnchor.constraint(equalTo: clearResultsButton.topAnchor, constant: -20),
            teamsTableView.heightAnchor.constraint(equalToConstant: CGFloat(5*130)),
            
            clearResultsButton.heightAnchor.constraint(equalToConstant: 40),
            clearResultsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            clearResultsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            clearResultsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

extension BestGamesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        teamName.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath) as? GameResultsTableViewCell else {
            return UITableViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        switch indexPath.section {
            
        default:
            
            cell.teamLogo.image = shuffledTeamLogos.randomElement()!
            cell.teamNameLabel.text = shuffledTeamNames.randomElement() ?? "Look"
            cell.scoreLabel.text = points
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //      tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hearderView = UIView()
        return hearderView
    }
    
}
