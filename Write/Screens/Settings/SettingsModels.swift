//
//  SettingsModels.swift
//  Write
//
//  Created by Muhamed Niyazov on 30.04.2021.
//

import UIKit

enum SettingsModels {
    
    // MARK: - Models
    struct SettingsSection {
        var title: String
        var items: [SettingsItem]
    }
    
    struct SettingsItem {
        var title: String
        var id: SettingsItemID
    }
    
    enum SettingsItemID {
        case about
        case logout
    }
    
    // MARK: - View Models
    struct TableViewViewModel {
        private var sections = [SettingsSection]()
        
        lazy var sectionsCount = sections.count
        
        func rowInSection(indexPath: IndexPath) -> SettingsItem {
            return sections[indexPath.section].items[indexPath.row]
        }
        
        func numberOfRowInSection(section: Int) -> Int {
            return sections[section].items.count
        }
        
        func titleForHeaderInSection(section: Int) -> String {
            return sections[section].title
        }
        
        func selectedRow(indexPath: IndexPath) -> SettingsItem {
            return sections[indexPath.section].items[indexPath.row]
        }
        
        init() {
            //Create sections & items
            let otherSectionItems: [SettingsItem] = [
                .init(title: "About", id: .about),
                .init(title: "Log Out", id: .logout)
            ]
            
            let otherSection = SettingsSection(
                title: "OTHER", items: otherSectionItems
            )
            
            self.sections = [otherSection]
        }
    }
}
