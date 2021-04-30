//
//  SettingsView.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import SnapKit
import UIKit

protocol SettingsViewLogic: UIView {
    var delegate: SettingsViewDelegate? { get set }
}

protocol SettingsViewDelegate: AnyObject {
    func aboutCellTapped()
    func logOutCellTapped()
}

final class SettingsView: UIView {
    weak var delegate: SettingsViewDelegate?
    let ReuseIdentifier = "SettingsCell"
    var viewModel: SettingsModels.TableViewViewModel = .init()
    
    // MARK: - Views
    lazy var tableView: UITableViewController = {
        let tableViewController = UITableViewController()
        tableViewController.view.backgroundColor = .black
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        return tableViewController
    }()
    
    // MARK: - Init
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    func generateCell(settingsItem: SettingsModels.SettingsItem) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: ReuseIdentifier)
        cell.textLabel?.text = settingsItem.title
        cell.backgroundColor = .bgGray
        cell.textLabel?.textColor = .white
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        guard settingsItem.id == .logout else { return cell }
        cell.textLabel?.textColor = .systemRed
        return cell
    }
    
    // MARK: - Private Methods
    private func configure() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(tableView.view)
    }
    
    private func addConstraints() {
        tableView.view.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: - SettingsViewLogic

extension SettingsView: SettingsViewLogic {
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = viewModel.selectedRow(indexPath: indexPath)
        
        switch row.id {
        case .about:        delegate?.aboutCellTapped()
        case .logout:       delegate?.logOutCellTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = generateCell(settingsItem: viewModel.rowInSection(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = UIColor.lightText
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 13)
            headerView.tintColor = .black
        }
    }
    
}
