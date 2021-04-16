//
//  SettingsController.swift
//  Write
//
//  Created by Muhamed Niyazov on 20.03.2021

import Foundation
import UIKit

class SettingsController: UITableViewController {
    // MARK: - Properties
    private var viewModel: SettingsViewModel!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        
        viewModel = SettingsViewModel(delegate: self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
    }
    // MARK: - Helpers
    
    func configureNavigationBar() {
        let navigationTitle = UILabel()
        navigationTitle.font = UIFont.boldSystemFont(ofSize: 20)
        navigationTitle.text = "Settings"
        navigationTitle.textColor = .white
        navigationItem.titleView = navigationTitle
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    func configureUI(){
        view.backgroundColor = .black
    }
}

//MARK: - SettingsViewModelDelegate
extension SettingsController: SettingsViewModelDelegate {
    func logOutCellTapped() {
        AuthService.instance.logUserOut { (error) in
            guard  error == nil else { return print("DEBUG: \(error!) ") }
            let loginController = UINavigationController(rootViewController: LoginController())
            loginController.modalPresentationStyle = .fullScreen
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    func aboutCellTapped() {
        print("DEBUG: FUCl")
    }
}
