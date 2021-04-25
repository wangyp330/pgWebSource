Pod::Spec.new do |spec|
  spec.name         = "ypWebSource"
  spec.version      = "0.0.1"
  spec.summary      = "ypWebSource for webKit load localResource"
  spec.description  = <<-DESC
                      example Document's image and videoweb加载本地资源，web加载沙盒中的资源。
                   DESC

  spec.homepage     = "https://github.com/wangyp330/pgWebSource"
  spec.license      = "MIT"
  spec.author       = { "wangy330" => "523476884@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/wangyp330/pgWebSource.git", :tag => "#{spec.version}" }
  spec.source_files  = "DCWeb", "DCWeb/*.{h,m}"
  spec.requires_arc = true
end
