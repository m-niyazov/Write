//
//  Utilities.swift
//  Write
//
//  Created by Muhamed Niyazov on 21.03.2021.
//

import Foundation


final class Utilities {
    static let instance = Utilities()
    private init() {}
    
    //MARK - Authentication
    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
}
