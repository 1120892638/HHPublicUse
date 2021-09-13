Pod::Spec.new do |s|
s.name        = "HHPublicUseService"
s.version      = "0.0.1"
s.summary      = "Daily development tools"
s.description  = <<-DESC
Daily development tools For Myself
DESC
s.homepage    = "https://github.com/1120892638/HHPublicUse.git"
s.license      = "MIT"
s.author            = { "贺华" => "1120892638@qq.com" }
s.platform    = :ios, "9.0"
s.source      = { :git => "https://github.com/1120892638/HHPublicUse.git", :tag => "#{s.version}" }

s.source_files  =  "HHPublicUseService/*.{h,m}"


s.dependency "AFNetworking", "~> 4.0"
s.dependency "MBProgressHUD"
end
