target 'DopodCinema' do
  use_frameworks!

    # Networks
    pod 'Alamofire'
    pod 'SDWebImage'
    
    # Encrypt
    pod 'CryptoSwift', '~> 1.4.1'

    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod "RxGesture"
    
    # Animation
    pod 'lottie-ios'
    
    pod "MXParallaxHeader"
    
    # Firebase
    pod 'FirebaseRemoteConfig', :git => 'https://github.com/firebase/firebase-ios-sdk.git', :branch => 'master'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.1'
    end
  end
end
