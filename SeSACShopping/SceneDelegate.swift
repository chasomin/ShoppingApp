//
//  SceneDelegate.swift
//  SeSACShopping
//
//  Created by 차소민 on 1/18/24.
//

protocol SominDelegate: NSObject {
    func didBecomeActive()
}

final class Somin {
    static let shared = Somin()
    
    private init() { }
    
    weak var delegate: SominDelegate?
    
    func didBecomeActive() {
        delegate?.didBecomeActive()
    }
}

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        //FIXME: 지울 코드
//        UserDefaultsManager.shared.userState = false
        
        print(UserDefaultsManager.shared.userState)
        print(UserDefaultsManager.shared.nickname)

        if UserDefaultsManager.shared.userState == false || UserDefaultsManager.shared.nickname == "" {
            
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
                        
            let vc = OnboardingViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            window?.rootViewController = nav
            
            window?.makeKeyAndVisible()
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            
            let tabbar = UITabBarController()

            let searchViewController = UINavigationController(rootViewController: SearchViewController())
            let settingViewController = UINavigationController(rootViewController: SettingViewController())

            searchViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"),selectedImage: UIImage(systemName: "magnifyingglass"))
            settingViewController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"),selectedImage: UIImage(systemName: "person"))

            
            tabbar.viewControllers = [searchViewController, settingViewController]
            
            window?.rootViewController = tabbar
            window?.makeKeyAndVisible()
            
            
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = 0     // 0이면 리무브
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        Somin.shared.didBecomeActive()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        if !UserDefaultsManager.shared.like.isEmpty {
            
            let content = UNMutableNotificationContent()
            content.title = "'좋아요'한 상품을 구매해보세요"
            content.body = "\(UserDefaultsManager.shared.like.count)개의 상품이 기다리고 있어요!"
            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
            
            var component = DateComponents()
            component.hour = 12
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
            
            let request = UNNotificationRequest(identifier: "wishList", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
        }
    }


}

