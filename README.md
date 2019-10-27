# Rewards App
A fun app made with ❤️ to demonstrate some examples of **clean architecture**, code organisation, loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

App Goal:
 - Make OTP based login
 - Handle input validation, error handling, api call, processing indicators
 - Get your reward (an animation starts playing)

![](/Screenshots/normal-flow.gif "")

A simple login API is which is dummy and returns a simple `{"status": "ok"}` as 200 response for the POST call. If login fails, it returns 401 `unauthorized` response as body contains the string as well. 
API endpoint: http://floral-cherry-7673.getsandbox.com/login


## Installation

- Xcode **11**(required)
- Clean `/DerivedData` folder if any
- Run the Carthage (version 0.32 or later) update command to install the dependent libraries in the `Cartfile`
 > **`carthage update --platform iOS`** 
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`RxSwift`** - to make `Reactive` binding of API call and response 😇
 - **`Alamofire`** - to call API very easily 😀
 - **`SnapKit`** - to snap auto layout constraints with ease 🤓
 - **`PKHUD`** - to show loading activity indicator like a pro 🙈
 - **`SkyFloatingLabelTextField`** - to get all the fanciness of pretty Text field 🧙
 - **`Lottie`** - to animate like a breeze 🧜
 - **`Quick`** - to unit test as much as possible 🤫
 - **`Nimble`** - to pair with Quick 👬

## Clean Architecture
 - **VIPER** & **MVP** - A hybrid
 - Clean communication between **`Display`**, **`Presenter`** and **`Router`** in the view/scene stack
 - Communication between  **`Interactor`**, **`Service`** in the lower stacks of domain & network layers
 - Connectivity of this components are achieved via protocol instances to achieve loose coupling and unit testability
 - `View` (i.e. View Controller) is `Display` itself and contacts its `Presenter`
 - `Presenter` may perform view related logic and immediately talk back to `Display` (for example, input validation, button active/inactive state management etc.)
 - `Presenter` can communicate with underlying `Interactor` layer for more complex task
 - `Interactor` decides all Domain level business logic to take care of
 - `Interactor` communicates with underlying `Service` layer
 - `Service` communicates to its underlying `HttpClient` which handles all networking
 - `Interactor` gets back information via Rx binding from `Service`
 - `Interactor` parses the data and apply any necessary data transformation
 - `Interactor` gives outcome back to `Presenter` via callbacks
 - `Presenter` handles all the presentation reated logic nesessary for the view
 - `Presenter` talks back to `Display`
 - `Presenter` also talks to `Router` to navigate from one scene to another when needed
 
 ## Code Organisation / Layers / Grouping
 
 > Folder / Grouping are done as per below:
 
 Project has 3 targets:
  - **Rewards** - The main code
  - **RewardsTest** - **Unit testing** of all layers using Quick/Nimble
  - **RewardsUITest** - Some **automated XCUITest**
  
 ![](/Screenshots/app-layers.png "")
 
 > The codebase is grouped into 3 layers - `PresentationLayer`, `DomainLayer`, & `NetworkLayer`
 
 
 #### Presentation Layer
 
  > It has all the presnetation logic
  
 ![](/Screenshots/presentation-layer.png "")
 
 - Has helpers such as Theme, Localization, Utils etc.
 - Has Scenes:
 - `OTPLogin`: The starting page of the app for OTP login
 - `Reward`: The Reward page is navigated when the login succeeds
 > Breakdown of each `Scene` stack:
  - `ViewController`
  - `Presenter`
  - `Display`
  - `Router`
  Presenter, Display and Router communication logic are unit tested.
  
 #### Domain Layer
 
  > It has all domain level logic via the Interactor
 
 ![](/Screenshots/domain-layer.png "")
  
 - `LoginInteractor` is nesessary for OTP login 
 - Data model used - `LoginState`
 ```
 enum LoginState {
    case loggedIn
    case loginFailed
    
    // TODO: Case for Password Reset or other potential states around  reset/recovery
}
```
 - Logic is Unit tested
 
  #### Network Layer
  
 ![](/Screenshots/network-layer.png "")
 
  > It has all domain level logic via Interactor
 
 - `BaseRequest`, `OTPLoginRequest`, `IdentityService`
 - `HTTPClient` uses Alamofire to make a POST network call
 - `ObservableDataSource` is used to provide a layer abstraction and to be able to unit test
 -  `Encodable` Data model used `OTPLoginInput`
 -  `Decodable` Data model used `LoginToken`
 ```
 struct OTPLoginInput: Encodable {
 
    /// The user typed code to send for authentication
    let code: String
 }

 struct LoginToken: Decodable {
 
    /// The status string which says "Ok" if succeeds
    let status: String
    
    ...
 }
```
 - Most of the logic are unit tested
 
 ![](/Screenshots/testing-groups.png "")
 
 
 #### App Demo
 
 App is landscape mode supported. `KeyboardTracker` util helps scrollview adjustment when keyboard shows/hides.
 
 ![](/Screenshots/landscape-mode.gif "")
 
 ![](/Screenshots/normal-flow.gif "")
 
Inline Error handling applied and only upto 4 digit entry is accepted. The submit button is enabled/disabled based on input, i.e. when all 4 digits are entered. 

**Error Handling**
 - `Network connection unavailable` error is shown separately
 - Any other error leads in to a generic error message
 - 401 unauthorized state means `LoginFailed` which is treated differently as Login success/failure outcome with inline error message in red
 
  ![](/Screenshots/network-error.gif "")
  ![](/Screenshots/unknown-error.gif "")
  
  iPhone-5 screens:
  
  ![](/Screenshots/iphone5-1.png "")
  ![](/Screenshots/iphone5-2.png "")
  ![](/Screenshots/iphone5-3.png "")
  
  iPad Pro screens:
  
  ![](/Screenshots/ipad-1.png "")
  ![](/Screenshots/ipad-2.png "")
  
 
 
