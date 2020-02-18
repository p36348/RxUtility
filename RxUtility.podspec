Pod::Spec.new do |s|
  s.name             = "RxUtility"
  s.version          = "0.1"
  s.summary          = "RxSwift component develop kit"
  s.description      = <<-DESC
Set of blocking operators for RxSwift. These operators are mostly intended for unit/integration tests
with a couple of other special scenarios where they could be useful.

E.g.

Waiting for observable sequence to complete before exiting command line application.
                        DESC
  s.homepage         = "https://github.com/p36348/RxUtility.git"
  s.license          = 'MIT'
  s.author           = { "P36348" => "p36348@gmail.com" }
  s.source           = { :git => "https://github.com/p36348/RxUtility.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '9.0'

  s.source_files          = 'Sources/**/*.swift', 'Platform/**/*.swift'
#   s.exclude_files         = 'Sources/??/**/*.swift'

  s.dependency 'RxSwift', '>=4.5'
  s.dependency 'RxCocoa', '>=4.5'
  s.swift_version = '4.2'
end