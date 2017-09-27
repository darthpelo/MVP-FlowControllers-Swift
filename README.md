![Swift-4](https://img.shields.io/badge/Swift-4.0-orange.svg)

# MVP-FlowControllers-Swift

After read [@merowing_](https://twitter.com/merowing_) post about FlowControllers and [this](https://github.com/digoreis/ExampleMVVMFlow) example about FlowControllers and MVVM, I decided to create a simple example using MVP and FlowControllers.

The main idea is to create an open project so that everyone can give his point of view on FlowControllers architecture, because at this moment I have not found any good example.

## Description

Each scenes of your application is managed by a FlowController. A FlowController can instantiates
one or more couple "Presenter/ViewController".
* The Dependency Injection is handled through the `init` of each Presenter.
* The Dependency Inversion through the Presenter and View protocols.
* Only the ViewContoller can communicates (pass generic data) to the FlowController, but using an interface.


![Schema](architecture-schema.png)

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

The `FlowInizializer` is called in the `AppDelegate` and it has the scope to instantiate the first FlowController.

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

This is the first (root) FlowController instantiated in your project. It doesn't create any `ViewController` and `Presenter` couple, but just one or more FlowController child. For example, the FC of the On Boarding of your application and the FC of the Main Scene of the application.

```swift
class MainFlowController: FlowController {
    let configure: FlowConfigure
    private var childFlow: FlowController?

    required init(configure: FlowConfigure) {
        self.configure = configure
    }

    deinit {
        childFlow = nil
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

This is an FlowController example. It controls the flow of 3 viewcontrollers: `DashboardViewController`, `SecondViewController` and `SecretViewController`.
In the functions `configureFirst()`, `configureSecond()` and `configureSecret()` the FlowController instantiates the viewcontrollers and their presenters and pushes them in the `navigationController`.

```swift
enum DashboardFlowState: Int {
    case main
    case detail
    case secret
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
        case .secret:
            guard let viewController = configureSecret() else { return }

            configure.navigationController?.pushViewController(viewController, animated: false)
        }
    }

    private func configureFirst() -> UIViewController? {
        guard let viewController = R.storyboard.main.firstViewController() else { return nil }

        viewController.presenter = DashboardPresenterImplementation(view: viewController)
        viewController.configure = ConfigureDashboardViewController(delegate: self)
        return viewController
    }

    private func configureSecond() -> UIViewController? {
        guard let viewController = R.storyboard.main.secondViewController() else { return nil }

        viewController.presenter = SecondPresenterImplementation(view: viewController)
        viewController.configure = ConfigureSecondViewController(delegate: self)
        return viewController
    }

    private func goNext() {
        switch state {
        case .main:
            self.state = .detail
        case .detail, .secret:
            return
        }
    }

    private func goPrevious() {
        switch state {
        case .main:
            return
        case .detail, .secret:
            self.state = .main
        }
    }

    private func goToSecret() {
        self.state = .secret
    }
}

extension DashboardFlowController: ConfigureDashboardViewControllerDelegate {
    func showNextViewController() {
        goNext()

        start()
    }
}

extension DashboardFlowController: ConfigureSecondViewControllerDelegate {
    func backToFirstViewController() {
        goPrevious()
    }
}
```

`ConfigureDashboardViewControllerDelegate` and `ConfigureSecondViewControllerDelegate` are the delegates used by the viewcontrollers to communicate with the FlowController.

## Presenters
Each presenters control only one viewcontroller. This control happens by an interface/protocol so you can test your presenter passing its a Mocked object conforms to this protocol.

### DashboardPresenter.swift

```swift
protocol DashboardView: class {
    func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String)
}

protocol DashboardPresenter {
    func setupUI()
}

class DashboardPresenterImplementation: DashboardPresenter {
    fileprivate weak var view: DashboardView?

    init(view: DashboardView?) {
        self.view = view
    }

    // MARK: - DashboardPresenter
    func setupUI() {
        view?.updateUI(withTitleLabel: "a", withDescriptionLabel: "aa", andButton: "next")
    }
}
```

### SecondPresenter.swift

Dependency Injection is handled in the `init` of the protocol implementation, using
the Swift's property of setting a default value for function parameters. With this solution,
the FlowController is decoupled with the Presenter.

```swift
protocol SecondView: class {
    func updateUI(withDescriptionLabel descriptionText: String)
}

protocol SecondPresenter {
    func setupUI()
}

class SecondPresenterImplementation: SecondPresenter {
    fileprivate weak var view: SecondView?
    fileprivate let dataManager: DataManager

    init(view: SecondView?, dataManager: DataManager = DataManagerImplementation()) {
        self.view = view
        self.dataManager = dataManager
    }

    // MARK: - DashboardPresenter
    func setupUI() {
        getObject()
    }
}
```

## ViewControllers

Also the ViewControllers have an interface/protocol as connection with respective presenters and with the FlowController.

### DashboardViewController.swift

`ConfigureDashboardViewControllerDelegate` it's the protocol that `DashboardFlowController` implements to receive the request to show the next viewcontroller.

```swift
struct ConfigureDashboardViewController {
    weak var delegate: ConfigureDashboardViewControllerDelegate?
}

protocol ConfigureDashboardViewControllerDelegate: class {
    func showNextViewController()
}

class DashboardViewController: UIViewController, DashboardView {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    var presenter: DashboardPresenter!
    var configure: ConfigureDashboardViewController!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.setupUI()
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        configure.delegate?.showNextViewController()
    }

    // MARK: - DashboardView protocol
    func updateUI(withTitleLabel titleText: String,
                  withDescriptionLabel descriptionText: String,
                  andButton title: String) {
        DispatchQueue.main.async {
            self.title = titleText
            self.descriptionLabel.text = descriptionText
            self.nextButton.setTitle(title, for: .normal)
        }
    }
}

```

### SecondViewController.swift

```swift
struct ConfigureSecondViewController {
    weak var delegate: ConfigureSecondViewControllerDelegate?
}

protocol ConfigureSecondViewControllerDelegate: class {
    func backToFirstViewController()
}

class SecondViewController: UIViewController {
    @IBOutlet weak var label: UILabel!

    var presenter: SecondPresenter!
    var configure: ConfigureSecondViewController!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.setupUI()
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)

        if parent == self.navigationController?.parent {
            configure.delegate?.backToFirstViewController()
        }
    }
}

extension SecondViewController: SecondView {
    func updateUI(withDescriptionLabel descriptionText: String) {
        DispatchQueue.main.async {
            self.label.text = descriptionText
        }
    }
}

```
