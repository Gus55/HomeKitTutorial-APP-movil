import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navigation = window!.rootViewController! as! UINavigationController
    
    //Reedirige a al HomeViewController
    let target = navigation.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    navigation.pushViewController(target, animated: false)
    return true
  }
}
