#
#  Be sure to run `pod spec lint HRLog.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.name         = "HRLog"
  s.version      = "0.1.1"
  s.summary      = "HRLog pof for custom loger"
  s.description  = "HRLog pod for custom log and visual debuger and sending bag reports"
  s.license      = "MIT"
  s.author             = { "shsanek" => "shipin@sibers.com" }
  s.source       = { :git => "https://github.com/shsanek/HRLog.git", :tag => "0.0.1" }
  s.source_files  = "HRLog", "HRLog/**/*.{h,m}"
  s.public_header_files = "HRLog/**/*.h"
  s.homepage = "https://github.com/shsanek/HRLog";
  s.dependency 'HRSocket'
end
