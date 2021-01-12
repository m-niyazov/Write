//
//  NewNoteController.swift
//  Write_
//
//  Created by Muhamed Niyazov on 10.01.2021.
//  Copyright © 2021 Muhamed Niyazov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class NewNoteController: UIViewController {
    //MARK: - Properties
    lazy var textView: UITextView = {
        let textView = UtilitiesUI.instance.readyTextView()
        return textView
    }()
    
    lazy var containerView: UIScrollView = {
        let containerView = UtilitiesUI.instance.readyContainerView()
        return containerView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        configureUI()
        observersTextView()
        
        let textEditView = TextEditorView()
        textView.inputAccessoryView = textEditView
    }
    
    // MARK: - Helpers
    func configureNavigationBar() {
        UtilitiesUI.instance.basicNavigationBarSettings(navigationController!, navigationItem)
        //rightBarButton
        let saveButton = UIBarButtonItem()
        saveButton.title = "Create"
        saveButton.tintColor = UIColor.textGreen
        navigationItem.rightBarButtonItem = saveButton
    }
    func configureUI() {
        view.backgroundColor = .black
        configureNavigationBar()
        //сontainerView
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets.mainInsets)
        }
        
        //texView
        containerView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(containerView)
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height).offset(10)
        }
    }
}

//MARK: - Observers
extension NewNoteController {
    
    func observersTextView() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 0)
            textView.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 15)
        } else {
            textView.contentInset = UIEdgeInsets(top: 20, left: 15, bottom: keyboardFrame.height - (tabBarController?.tabBar.frame.height)! + 20, right: 0)
            textView.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 15)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        //textView.scrollRangeToVisible(textView.selectedRange)
    }
}
