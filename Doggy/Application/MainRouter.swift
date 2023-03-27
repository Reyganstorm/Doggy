//
//  MainRouter.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import UIKit

protocol Routable: UIViewController {
    var router: MainRouter? { get set }
}

class MainRouter: NSObject {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: true)
        self.navigationController = navigationController
    }
    
    // MARK: - PUSH ViewController
    
    func pushWelcomeVC() {
//        let vc = WelcomeViewController()
//        pushViewController(vc: vc, animated: true)
        let vc = ViewController()
        pushViewController(vc: vc, animated: true)
    }
    
    

    // MARK: - Pablic func
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    // MARK: - Private Func
    
    private func pushViewController(vc: Routable, animated: Bool) {
        vc.router = self
        navigationController.pushViewController(vc, animated: animated)
    }
}

