require "net/http"
require "json"

if ENV["YOTI_FACETEC_VERSION"].to_s.empty?
  begin
    response = Net::HTTP.get(URI("https://api.github.com/repos/getyoti/yoti-doc-scan-ios/releases/latest"))
    ENV["YOTI_FACETEC_VERSION"] = JSON.parse(response).fetch("tag_name").sub(/\Av/, "")
  rescue
    raise "Unable to fetch the latest version. Set ENV['YOTI_FACETEC_VERSION'] to pin one."
  end
end

Pod::Spec.new do |spec|
  spec.name                = "FaceTecSDKForDevelopment"
  spec.summary             = "Shared framework for Yoti SDKs. Not intended for direct use."
  spec.author              = "Yoti Ltd"
  spec.version             = ENV["YOTI_FACETEC_VERSION"]
  spec.platform            = :ios, "11.0"
  spec.homepage            = "https://github.com/getyoti/yoti-doc-scan-ios"
  spec.license             = { :type => "Copyright", :text => "https://www.yoti.com/terms/identity-verification" }
  spec.source              = { :http => "https://github.com/getyoti/yoti-doc-scan-ios/releases/download/v#{spec.version}/#{spec.name}.zip" }
  spec.prepare_command     = "mv #{spec.name}/#{spec.name}.xcframework #{spec.name}/FaceTecSDK.xcframework"
  spec.vendored_frameworks = "#{spec.name}/FaceTecSDK.xcframework"
end
