# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def shared_pods
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod 'SkeletonView'
    pod 'RxAlamofire'
end

target 'CandidateTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!
  # Pods for CandidateTest
  use_modular_headers!
  shared_pods

  target 'CandidateTestTests' do
    inherit! :search_paths
      shared_pods
    # Pods for testing
  end

end
