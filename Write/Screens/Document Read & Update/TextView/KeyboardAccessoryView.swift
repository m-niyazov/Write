//
//  KeyboardAccessoryView.swift
//  Write
//
//  Created by Muhamed Niyazov on 07.04.2021.
//

import Foundation
import UIKit
import SnapKit

class KeyboardAccessoryView: UIView {
    // MARK: - Properties
    lazy var stackViewButtons: UIStackView = {
        let stackView = UIStackView()
        let buttons = generateTextEditorButtons()
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution =  .equalSpacing
        return stackView
    }()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 42))
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init
    func configureUI() {
        backgroundColor = UIColor.gray
        addSubview(stackViewButtons)
        stackViewButtons.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        }
    }
    
    func readyTextEditorButton(icon: String) -> UIButton {
        let button = UIButton()
        let image = UIImage(named: "t-\(icon)-icon")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 5
        button.isSelected = false
    
        button.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(30)
            make.height.greaterThanOrEqualTo(30)
        }
        
        return button
    }
    
    @objc func handleSelectButton(sender: UIButton) {
        sender.backgroundColor = .blue
    }
    @objc func handleUnselectButton(sender: UIButton) {
        sender.backgroundColor = .none
    }
    
    
    func generateTextEditorButtons() -> [UIButton] {
        let buttonNames = ["bold", "italic", "underlined", "align-left", "align-center", "align-right"]
        var buttonsArray = [UIButton]()
        for iconName in buttonNames {
            let button = readyTextEditorButton(icon: iconName)
            button.addTarget(self, action: #selector(handleSelectButton(sender:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(handleUnselectButton(sender:)), for: .touchDown)
            buttonsArray.append(button)
        }
        return buttonsArray
        
    }
    
}
