#
# Be sure to run `pod lib lint TTImagePickerManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TTImagePickerManager'
  s.version          = '0.1.0'
  s.summary          = '相册获取基础管理类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       '相册获取基础管理类'
                       DESC

  s.homepage         = 'https://github.com/woshicainiaoma/TTImagePickerManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'woshicainiaoma' => 'chmatcha00@gmail.com' }
  s.source           = { :git => 'https://github.com/woshicainiaoma/TTImagePickerManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TTImagePickerManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TTImagePickerManager' => ['TTImagePickerManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'Photos'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.ios.deployment_target = '9.0'
  s.default_subspec = 'Manager'
  
  # 图片资源管理类
  s.subspec 'Manager' do |manager|
    manager.source_files = 'TTImagePickerManager/Classes/Manager/*.{h,m}'
    manager.dependency 'TTImagePickerManager/Model'
  end
  
  # 图片资源模型数据
  s.subspec 'Model' do |model|
    model.source_files = 'TTImagePickerManager/Classes/Model/*.{h,m}'
  end
  
end
