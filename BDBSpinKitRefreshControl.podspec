Pod::Spec.new do |s|
  s.name      = 'BDBSpinKitRefreshControl'
  s.version   = '1.0.1'
  s.license   = 'MIT'
  s.summary   = 'A UIRefreshControl replacement that utilizes the fantastic SpinKit progress indicators.'
  s.homepage  = 'https://github.com/bdbergeron/BDBSpinKitRefreshControl'
  s.social_media_url = 'https://twitter.com/bradbergeron'
  s.authors   = { 'Bradley David Bergeron' => 'brad@bradbergeron.com' }
  s.source    = { :git => 'https://github.com/bdbergeron/BDBSpinKitRefreshControl.git', :tag => s.version.to_s }
  s.requires_arc = true
  
  s.platform = :ios, '7.0'
  
  s.source_files = 'BDBSpinKitRefreshControl/*.{h,m}'
  
  s.dependency 'SpinKit', '~> 1.0'
end
