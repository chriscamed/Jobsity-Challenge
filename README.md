# Jobsity-Challenge

Pods folder excluded. Perform a `pod repo update` and `pod install` to successfully install repo dependencies.

List of pods used in the project:

1. pod 'Alamofire', '~> 4.3'.
  - I always use this library to perform network requests. It's easy to use and allows to handle errors by wrong request or timeout.

2. pod 'AlamofireImage', '~> 3.1'
  - This library allows to set an image to an UIImageView using a URL. It works on a different thread than the main.
  
3. pod 'PagingMenuController'
  - A library to add a paging functionality (like a top tab bar) with swipe gestures.
  
4. pod 'SmileLock'
  - Used to handle the authentication. It shows a numeric keyboard and if Touch ID is present in the device, allows the user to authenticate using his fingerprint.

Pods version: 1.2.0
