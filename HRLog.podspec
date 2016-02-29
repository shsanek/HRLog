#
# Be sure to run `pod lib lint HRLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.platform = :osx, '9.0'
  s.platform = :osx, '10.11'
  s.name             = "HRLog"
  s.version          = "0.1.0"
  s.summary          = "ASLDKLAMSLKD SDLKAMSLDKMLAS LKASMLDKMALSKMD"
  s.description      = "Description OSIJD OIJASD OISADJ AOSIDJ AOISJD OSAIDJ OAISJD OAISJD OAISJD OIASJD "
  s.homepage         = "https://github.com/shsanek/HRLog"
  s.license          = 'MIT'
  s.author           = { "Alexander Shipin" => "shipin@sibers.com" }
  s.source           = { :git => "https://github.com/shsanek/HRLog.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HRLog' => ['Pod/Assets/*.png']
  }
  s.public_header_files = 'Pod/Classes/**/*.h'
end
