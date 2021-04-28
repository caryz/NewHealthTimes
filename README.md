# NewHealthTimes

Sample app using NYT's Top Stories API focused on the "Health" section.

## Setup
1. Open the `.xcodeproj` file
2. Dependencies use Swift Package Manager. Go to `File -> Swift Packages -> Update to Latest Package Versions`
3. In `APIConstants.swift`, assign your API key value to `apiKey`
4. Run the project :)

## Architecture
The following external dependencies are used:
- Alamofire
  - Rather than working with `URLSession` directly, I opted for Alamofire for the ease of use and development
- KingFisher
  - I originally had an `UIImageView` extension for asynchronously downloading images, but found it lacking
  - In addition to built-in caching, KF also offers placeholder images with spinners during load

The application uses the following design patterns:

- Coordinator
  - In this app I used the Coordinator pattern to abstract out navigation and API calls from the main view
  - There are also some sample functions in `MainCoordinatorDelegate` that showcases other potential uses for the coordinator
- MVVM
  - The ViewModels all take a raw data model and convert it into relevant objects for respective views to consume
  - This is particularly important for displaying the home page (`HomeViewController`), as the `HomeViewModel` is assigned _after_ the API loads, thereby triggering an update on the view