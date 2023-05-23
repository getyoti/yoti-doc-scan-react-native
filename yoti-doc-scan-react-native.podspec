require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |spec|
  spec.name                 = "yoti-doc-scan-react-native"
  spec.summary              = package["description"]
  spec.homepage             = package["homepage"]
  spec.license              = package["license"]
  spec.author               = package["author"]
  spec.version              = package["version"]
  spec.pod_target_xcconfig  = { "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/**" }
  spec.source               = { :git => "https://github.com/getyoti/yoti-doc-scan-react-native.git", :tag => "#{spec.version}" }
  spec.source_files         = "ios/**/*.{h,m}"
  spec.platform             = :ios, "11.0"
  spec.dependency           "React"
  spec.dependency           "YotiSDKNetwork"
  spec.dependency           "YotiSDKCommon"
  spec.dependency           "YotiSDKCore"
end
