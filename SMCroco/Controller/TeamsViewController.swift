//
//  TeamsViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 18.04.2023.
//

import UIKit
import SwiftUI
import SnapKit

class TeamsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    //  MARK: - Elements
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BackgroundWithoutGrass")
        return imageView
    }()
    
    private let teamsLabel: UILabel = {
        let label = UILabel()
        label.text = "Кто играет?"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    private let teamsTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 100
        table.backgroundColor = .clear
        table.register(TeamsTableViewCell.self, forCellReuseIdentifier: TeamsTableViewCell.reuseIdentifier)
        table.layer.cornerRadius = 10
        return table
    }()
    
    private lazy var addTeamButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Theme.orangeColor
        button.setTitle("Добавить игроков", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var readyButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = Theme.appColor
        element.setTitle("Игроки готовы", for: .normal)
        element.tintColor = .white
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        element.layer.cornerRadius = 10
        element.addTarget(self, action: #selector(tapReadyButton), for: .touchUpInside)
        return element
    }()
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setLayout()
        setConstraints()
        setDelegates()
    }
    
    //MARK: - Methods
    private func setLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(teamsLabel)
        view.addSubview(teamsTableView)
        view.addSubview(addTeamButton)
        view.addSubview(readyButton)
    }
    
    private func setDelegates() {
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
    }
    
    @objc func tapReadyButton() {
        let VC = CategoryViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func tapAddButton() {
        let ac = UIAlertController(title: "Введите имя команды", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Имя команды"
        }
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
            guard let textField = ac.textFields?.first else { return }
            let name = textField.text
            if let name = name {
                teams.append(Team(name: name, points: 0,avatarName: (teamLogos.randomElement()!)))
                self.teamsTableView.reloadData()
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        let VC = MainViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        teams.remove(at: sender.tag)
        teamsTableView.reloadData()
    }
    
    func changeName(at indexPath: IndexPath) {
        let ac = UIAlertController(title: "Введите новое имя команды", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Имя команды"
        }
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "ОК", style: .default, handler: { [weak self] (action) in
            guard let textField = ac.textFields?.first,
                  let newName = textField.text,
                  !newName.isEmpty else {
                return
            }
            teams[indexPath.section].name = newName
            self?.teamsTableView.reloadData()
        }))
        present(ac, animated: true, completion: nil)
    }
}

//  MARK: - TableViewDataSource, TableViewDelegate
extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.reuseIdentifier, for: indexPath) as? TeamsTableViewCell else { return UITableViewCell() }
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        let team = teams[indexPath.section]
        cell.configure(playerName: team.name, imageName: team.avatarName!)
        cell.removeButton.isHidden = teams.count <= 2
        cell.removeButton.tag = indexPath.section
        cell.removeButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeName(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hearderView = UIView()
        hearderView.backgroundColor = .clear
        return hearderView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            teams.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
    }
}
//  MARK: -  Constraints
extension TeamsViewController {
    private func setConstraints() {
        
        teamsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(45)
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        teamsTableView.snp.makeConstraints { make in
            make.top.equalTo(teamsLabel.snp.bottom).inset(36)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        addTeamButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(readyButton.snp.top).offset(-18)
            make.height.equalTo(63)
        }
        
        readyButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
            make.height.equalTo(63)
        }
    }
}
