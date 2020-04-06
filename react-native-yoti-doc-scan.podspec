require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name           = 'react-native-yoti-doc-scan'
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = 'https://github.com/getyoti/yoti-doc-scan-react-native'
  s.source         = { :git => "https://github.com/lampkicking/yoti-docs-react-native.git", :tag => "#{s.version}" }
  s.source_files   = "ios/**/*.{h,m}"
  s.platform       = :ios, "11.0"
  s.dependency "React"
  s.dependency "YotiSDKDocument"
  s.dependency "YotiSDKZoom"
  s.pod_target_xcconfig = {
    'CLANG_ENABLE_MODULES' => 'NO'
  }
end
