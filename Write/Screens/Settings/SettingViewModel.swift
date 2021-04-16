//
//  SettingViewModel.swift
//  Write
//
//  Created by Muhamed Niyazov on 15.04.2021.
//

import Foundation
import UIKit

// MARK: - Protocols
protocol SettingsViewModelDelegate: class {
    func aboutCellTapped()
    func logOutCellTapped()
}
// MARK: - ViewModels
struct SettingsSection {
    var title: String
    var cells: [SettingsItem]
}

struct SettingsItem {
    var createdCell: () -> UITableViewCell
    var action: ((SettingsItem) -> Swift.Void)?
}

// MARK: Main Class
class SettingsViewModel: NSObject {
    // MARK: - Properties
    static let ReuseIdentifier = "SettingsCell"
    private weak var delegate: SettingsViewModelDelegate?
    private var tableViewSections = [SettingsSection]()
    
    // MARK: - Initilization
    init(delegate: SettingsViewModelDelegate) {
        super.init()
        self.delegate = delegate
        configureDatasource()
    }
    
    // MARK: - Helpers
    private func configureDatasource() {
        let getInTouchSection = SettingsSection(
            title: "OTHER",
            cells: [
                SettingsItem(
                    createdCell: {
                        return self.settingCell(title: "About")
                    },
                    action: { [weak self] _ in self?.delegate?.aboutCellTapped() }
                ),
                SettingsItem(
                    createdCell: {
                        let cell = self.settingCell(title: "Log Out")
                        cell.textLabel?.textColor = .systemRed
                        return cell
                    },
                    action: { [weak self] _ in self?.delegate?.logOutCellTapped() }
                ),
            ]
        )
        
        tableViewSections = [getInTouchSection]
    }
    
    
    func settingCell(title: String) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Self.ReuseIdentifier)
        cell.textLabel?.text = title
        cell.backgroundColor = .tabBar
        cell.textLabel?.textColor = .white
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.darkGray
        cell.selectedBackgroundView = bgColorView
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return cell
    }
    
}


// MARK: - TableView delegate and datasource
extension SettingsViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewSections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        return cell.createdCell()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableViewSections[indexPath.section].cells[indexPath.row]
        cell.action?(cell)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewSections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
           headerView.textLabel?.textColor = UIColor.lightText
            headerView.textLabel?.font = UIFont.systemFont(ofSize: 13)
            headerView.tintColor = .black
        }
    }
}
