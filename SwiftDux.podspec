Pod::Spec.new do |s|
  s.name = 'SwiftDux'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.version = '0.0.1'
  s.source = { :git => 'git@github.com:paulsp94/SwiftDux.git', :tag => s.version.to_s }
  s.authors = 'StevenLambion'
  s.homepage = 'https://stevenlambion.github.io/SwiftDux/'
  s.summary = 'Predictable state management for SwiftUI applications.'
  s.source_files = 'Sources/**/*.swift'
end
