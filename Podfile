# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Jobsity Challenge' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Jobsity Challenge
  pod 'Alamofire', '~> 4.3'
  pod 'AlamofireImage', '~> 3.1'
  pod 'PagingMenuController'
  pod 'SmileLock'

  post_install do |installer|
   installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
       config.build_settings['SWIFT_VERSION'] = '3.0'
     end
   end
  end

  target 'Jobsity ChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
