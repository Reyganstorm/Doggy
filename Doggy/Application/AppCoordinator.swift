//
//  AppCoordinator.swift
//  Doggy
//
//  Created by Руслан Штыбаев on 27.03.2023.
//

import Foundation
import UIKit


class AppCoordinator: NSObject {
    var window: UIWindow
    var router: MainRouter?
    
    init(window: UIWindow?) {
        self.window = window!
        super.init()
        startScreenFlow()
    }
    
    func didFinishLaunchingWithOptions(_ aplication: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? ) {
        
    }
    
    private func startScreenFlow() {
        let navController = UINavigationController()
        router = MainRouter(navigationController: navController)
//        router?.pushTabBar()
        router?.pushWelcomeVC()
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }
}
