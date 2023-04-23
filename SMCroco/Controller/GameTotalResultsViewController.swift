//
//  GameTotalResultsViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit

class GameTotalResultsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    //MARK: - Elements
    private lazy var resultsLabel: UILabel = {
       let label = UILabel()
        label.text = "Результаты"
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
    
    private lazy var teamsTable: UITableView = {
        let tableView = UITableView()
        tableView.register(GameResultsTableViewCell.self, forCellReuseIdentifier: "team")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var playAgainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Начать заново", for: .normal)
        button.backgroundColor = Theme.appColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        return button
    }()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetResults()
    }

    //MARK: - Methods
    private func setupView () {
        self.navigationItem.hidesBackButton = true
        teamsTable.dataSource = self
        teamsTable.delegate = self
        view.addSubview(backgroundImage)
        view.addSubview(resultsLabel)
        view.addSubview(teamsTable)
        view.addSubview(playAgainButton)
    }
    
    @objc func playAgain () {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func resetResults() {
        for i in 0..<teams.count {
            teams[i].points = 0
        }
    }
}

extension GameTotalResultsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            resultsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            resultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            teamsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            teamsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            teamsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            teamsTable.bottomAnchor.constraint(equalTo: playAgainButton.topAnchor, constant: -20),
            teamsTable.heightAnchor.constraint(equalToConstant: 80),

            playAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            playAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            playAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            playAgainButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

//MARK: - TableViewDelegate, TableViewDataSource
extension GameTotalResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        teams.count
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
            let team = teams[indexPath.section]
            cell.teamLogo.image = team.avatarName
            cell.teamNameLabel.text = team.name
            cell.scoreLabel.text = String(team.points)
        }
        return cell
      }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let hearderView = UIView()
      return hearderView
    }

}
