//
//  TextView.swift
//  Write
//
//  Created by Muhamed Niyazov on 07.04.2021.
//

import UIKit

class TextView: UITextView, UITextViewDelegate  {
    //MARK: - Initilizer
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        self.configureView()
        observersTextView()
        closeKeyboardButtonConfigure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    //MARK: - Helpers
    func configureView() {
        backgroundColor = UIColor.rgb(red: 244, green: 244, blue: 244)
        textColor = .black
        keyboardDismissMode = .interactive
        isScrollEnabled = true
        showsVerticalScrollIndicator = true
        indicatorStyle = .black
        font = UIFont.systemFont(ofSize: 17)
//        font = UIFont.init(name: "PlayfairDisplay-Medium", size: 17)
        textContainerInset = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        keyboardAppearance = .dark
        layer.cornerRadius = 10
    }
    
    @objc func handleCloseKeyboard() {
        self.endEditing(true)
    }
    
    func closeKeyboardButtonConfigure() {
        inputAccessoryView = CloseKeyboardButton()

        // NotifiСenter for ClosKeyboardButton
        let notifiCenter = NotificationCenter.default
        notifiCenter.addObserver(self, selector: #selector(handleCloseKeyboard), name: NSNotification.Name(rawValue: "closeKeyboard"), object: nil)
    }
}


//MARK: - Observers
extension TextView {
    
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
            contentInset = UIEdgeInsets(top: 0, left: 0
                , bottom: 0, right: 0)
        } else {
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        }
    
    }
}
