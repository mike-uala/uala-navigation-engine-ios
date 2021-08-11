//
//  OnboardingReusablePresent.swift
//  UalaUI
//
//  Created by Juan Emmanuel Cepeda on 10/03/21.
//

import Foundation
final class OnboardingReusablePresent {
    
    weak var view: OnboardingReusableViewProtocol?

    init(interface: OnboardingReusableViewProtocol) {
        self.view = interface
    }
}

extension OnboardingReusablePresent: OnboardingReusablePresenterProtocol {
    func didClickButton() {
        print("Implement router here to push next VC ")
    }
    
    func secondaryClickButton(){
        print("Implement router here to push next VC ")
    }
}
