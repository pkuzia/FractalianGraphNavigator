platform :ios, '16.0'
use_frameworks!

def common_pods
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint'
  pod 'SwifterSwift'
end

target 'FractalianGraphNavigator' do
  common_pods
end

target 'FractalianGraphNavigatorTests' do
  common_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end