//
//  TextEditorView.swift
//  Write_
//
//  Created by Muhamed Niyazov on 12.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import UIKit
import SnapKit

class TextEditorView: UIView {
    // MARK: - Properties
    //
    //    lazy var textBoldButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "bold")
    //        return button
    //    }()
    //
    //    lazy var textItalicButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "italic")
    //        return button
    //    }()
    //
    //    lazy var textUnderlinedButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "underlined")
    //        return button
    //    }()
    //
    //    lazy var textColordButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "color")
    //        return button
    //    }()
    //
    //    lazy var textAlignLeftButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "align-left")
    //        return button
    //    }()
    //
    //    lazy var textAlignCenterButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "align-center")
    //        return button
    //    }()
    //
    //    lazy var textAlignRightButton: UIButton = {
    //        var button = readyTextEditorButton(icon: "align-right")
    //        return button
    //    }()
    
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
        backgroundColor = .grayLight
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
        button.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(30)
            make.height.greaterThanOrEqualTo(30)
        }
        
        return button
    }
    
    func generateTextEditorButtons() -> [UIButton] {
        let buttonNames = ["bold", "italic", "underlined", "align-left", "align-center", "align-right"]
        var buttonsArray = [UIButton]()
        for iconName in buttonNames {
            let button = readyTextEditorButton(icon: iconName)
            buttonsArray.append(button)
        }
        return buttonsArray
        
    }
    
}
