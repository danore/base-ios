# Xcode
#
# gitignore contributors: remember to update Global/Xcode.gitignore, Objective-C.gitignore & Swift.gitignore
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.2'

target 'base' do
  use_frameworks!

  pod 'Alamofire', '~> 5.0.0-beta.3'
  pod 'AlamofireImage', '~> 4.0.0-beta.1'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Crashlytics', '~> 3.10.7'
  pod "SharkORM", '~> 2.1.3', :inhibit_warnings => true
end

post_install do |installer|
    print "Setting the default SWIFT_VERSION to 5.0\n"
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '5.0'
    end

    installer.pods_project.targets.each do |target|

    plist_buddy = "/usr/libexec/PlistBuddy"
    plist = "Pods/Target Support Files/#{target}/Info.plist"

    puts "Add arm64 to #{target} to make it pass iTC verification."

    `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities array" "#{plist}"`
    `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities:0 string arm64" "#{plist}"`

    if ['SomeTarget-iOS', 'SomeTarget-watchOS'].include? "#{target}"
            print "Setting #{target}'s SWIFT_VERSION to 3.0\n"
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        else
            print "Setting #{target}'s SWIFT_VERSION to Undefined (Xcode will automatically resolve)\n"
            target.build_configurations.each do |config|
                config.build_settings.delete('SWIFT_VERSION')
            end
        end
    end
end
