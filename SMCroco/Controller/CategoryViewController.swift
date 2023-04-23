//
//  CategoryViewController.swift
//  SMCroco
//
//  Created by Alexander Altman on 18.04.2023.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    //  MARK: - Elements
    private let backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "BackgroundWithoutGrass")
        return element
    }()
    
    private let categoryLabel: UILabel = {
        let element = UILabel()
        element.text = "Категории"
        element.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return element
    }()
    
    private lazy var categoryTableView: UITableView = {
        let element = UITableView()
        element.rowHeight = 96
        element.backgroundColor = .clear
        element.layer.cornerRadius = 10
        element.isScrollEnabled = false
        element.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        return element
    }()
    
    private lazy var startButton: UIButton = {
        let element = UIButton(type: .system)
        element.backgroundColor = #colorLiteral(red: 0.4534765482, green: 0.6565048099, blue: 0.187305212, alpha: 1)
        element.setTitle("Начать игру", for: .normal)
        element.tintColor = .white
        element.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        element.layer.cornerRadius = 10
        element.addTarget(self, action: #selector(showNext), for: .touchUpInside)
        return element
    }()
    
    let categoryNames = [0: animalsArray, 1: foodArray, 2: peopleArray, 3: hobbyArray]
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraints()
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
    
    private func setLayout() {
        view.addSubview(backgroundImage)
        view.addSubview(categoryLabel)
        view.addSubview(categoryTableView)
        view.addSubview(startButton)
    }
    
    func prepareWordsArray() {
        
    }
    
    @objc private func showNext(sender: UIButton) {
        let gameVC = GameViewController()
//        let resultVC = RoundResultsViewController()
        let number = sender.tag
        gameVC.word = categoryNames[number]?.randomElement() ?? ""
        gameVC.index = number
//        resultVC.index = number
        navigationController?.pushViewController(gameVC, animated: true)
    }
}

//  MARK: - TableViewDataSource, TableViewDelegate
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else { return UITableViewCell() }
        cell.layer.cornerRadius = 10
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = Theme.pink
            cell.configure(categoryPicture: "frog", categoryText: "Животные")
        case 1:
            cell.backgroundColor = Theme.yellow
            cell.configure(categoryPicture: "food", categoryText: "Еда")
        case 2:
            cell.backgroundColor = Theme.blue
            cell.configure(categoryPicture: "people", categoryText: "Личности")
        default:
            let color = Theme.red
            cell.backgroundColor = color
            cell.configure(categoryPicture: "hobby", categoryText: "Хобби")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hearderView = UIView()
        return hearderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return }
        cell.showImage()
        print(cell.imageCheched())
        if cell.imageCheched() {
            startButton.tag = indexPath.section
            let vc = GameViewController()
            let tag = startButton.tag
            vc.index = tag
            print(vc.index)
        }
    }
}

//  MARK: -  Constraints
extension CategoryViewController {
    
    private func setConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(45)
        }
        
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(96)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.greaterThanOrEqualTo(startButton.snp.top)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(62)
            make.height.equalTo(63)
        }
    }
}
