//
//  TabBarViewController.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureViewControllers()

    }
    
    // MARK: - Helpers
    fileprivate func configureTabBar() {
        self.tabBar.clipsToBounds = false
        self.tabBar.tintColor = .blue
        self.tabBar.accessibilityIgnoresInvertColors = true
        self.tabBar.isTranslucent = true
        self.tabBar.barTintColor = .white
    }
    
    fileprivate func configureViewControllers() {
        // Configure the tabBar viewControllers
        guard let intraday = UIImage(systemName: "note.text") else { return }
        guard let dailyAdjusted = UIImage(systemName: "cloud.fill") else { return }
        guard let setting = UIImage(systemName: "person.fill") else { return }
        
        let intra = navigationControllerTemplate(
            tag: 0,
            title: "Intraday",
            tabBarIcon: intraday,
            IntradayViewController()
        )
        // Add button
        let daily = navigationControllerTemplate(
            tag: 1,
            title: "DailyAdjusted",
            tabBarIcon: dailyAdjusted,
            DailyAdjustedViewController()
        )
        
        let settings = navigationControllerTemplate(
            tag: 2,
            title: "Setting",
            tabBarIcon: setting,
           SettingViewController()
        )
        
        viewControllers = [intra, daily, settings]
    }
    
    fileprivate func navigationControllerTemplate(tag: Int, title: String, tabBarIcon: UIImage,_ rootViewController: UIViewController) -> UINavigationController {
        
        // A code template to add navigationController to every tabBarController viewControllers
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = tabBarIcon
        navigation.tabBarItem.title = title
        return navigation
    }
    
    
    // MARK: - Selectors
    
}

extension TabBarViewController: JumpToController {
    func jumpToController(_ controller: UIViewController) {
        if let navigations = self.viewControllers?.first as? UINavigationController {
            if let mealsController = navigations.viewControllers.first as? IntradayViewController {
                // Check if tabBarController.selectedIndex is selected the Main screen or not
                // If not then switch to the correct index then push the destination view controller
                if self.selectedIndex != 0 {
                    self.selectedIndex = 0
                    mealsController.navigationController?.pushViewController(controller, animated: true)
                } else {
                    mealsController.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
}

