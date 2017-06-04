# MVP-FlowControllers-Swift

🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧

After read [@merowing_](https://twitter.com/merowing_) post about FlowControllers and [this](https://github.com/digoreis/ExampleMVVMFlow) example about FlowControllers and MVVM, I decided to create a simple example using MVP and FlowControllers.

The main idea is to create an open project so that everyone can give his point of view on this architecture, because at this moment I have not found any good example.

🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧

## FlowControllers

### FlowController.swift

Direct inspired by @digoreis example, in this file there are defined the `FlowController` and the `FlowConfigure`.
The first one is the interface of any FlowControllers. The second is the configuration necessary to configure a new child FlowController.

```swift
import UIKit

enum FlowType {
    case main
    case navigation
}

struct FlowConfigure {
    let window: UIWindow?
    let navigationController: UINavigationController?
    let parent: FlowController?
    
    func whichFlowAmI() -> FlowType? {
        if window != nil { return .main }
        if navigationController != nil { return .navigation }
        return nil
    }
}

protocol FlowController {
    init(configure: FlowConfigure)
    func start()
}
```

### FlowInizializer.swift

The `FlowInizializer` is called in the `AppDelegate` and it has the scope to instanziate the first FlowController.

```swift
struct FlowInizializer {
    func configure(_ window: UIWindow?) {
        let configure = FlowConfigure(window: window, navigationController: nil, parent: nil)
        let mainFlow = MainFlowController(configure: configure)
        mainFlow.start()
    }
}
```

### MainFlowController.swift

This is the first FlowController instanziated in your project. It dosen't create any `ViewController` and `Presenter` couple, but just a FlowController child.

```swift
class MainFlowController: FlowController {
    let configure: FlowConfigure
    var childFlow: FlowController?
    
    required init(configure: FlowConfigure) {
        self.configure = configure
    }
    
    func start() {
        let navigationController = UINavigationController()
        if let frame = configure.window?.bounds {
            navigationController.view.frame = frame
        }

        configure.window?.rootViewController = navigationController
        configure.window?.makeKeyAndVisible()
        
        let dashConf = FlowConfigure(window: nil, navigationController: navigationController, parent: self)
        childFlow = DashboardFlowController(configure: dashConf)
        childFlow?.start()
    }
}
```

### DashboardFlowController.swift

This is an FlowController example. It controls the flow of two (the only two 😅) viewcontroller in the project, `DashboardViewController` and `SecondViewController`. 
In the functions `configureFirst()` and `configureSecond()` the FlowController instantiates the viewcontrollers and their presenters and pushes them in the `navigationController`. 

```swift
enum DashboardFlowState: Int {
    case main
    case detail
}

class DashboardFlowController: FlowController {
    fileprivate let configure: FlowConfigure
    fileprivate var state: DashboardFlowState
    
    required init(configure: FlowConfigure) {
        self.configure = configure
        self.state = .main
    }
    
    func start() {
        switch self.state {
        case .main:
            guard let viewController = configureFirst() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: true)
        case .detail:
            guard let viewController = configureSecond() else { return }
            
            configure.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    fileprivate func configureFirst() -> UIViewController? {
        guard let viewController = R.storyboard.main.firstViewController() else { return nil }

        viewController.presenter = DashboardPresenterImplementation(view: viewController)
        viewController.configure = ConfigureDashboardViewController(delegate: self)
        return viewController
    }
    
    fileprivate func configureSecond() -> UIViewController? {
        guard let viewController = R.storyboard.main.secondViewController() else { return nil }

        viewController.presenter = SecondPresenterImplementation(view: viewController)
        viewController.configure = ConfigureSecondViewController(delegate: self)
        return viewController
    }
}

extension DashboardFlowController: ConfigureDashboardViewControllerDelegate {
    func showNextViewController() {
        state = .detail
        
        start()
    }
}

extension DashboardFlowController: ConfigureSecondViewControllerDelegate {
    func backToFirstViewController() {
        state = .main
    }
}
```

`ConfigureDashboardViewControllerDelegate` and `ConfigureSecondViewControllerDelegate` are the delagates used by the viewcontrollers to comunicate with the FlowController.
