Pod::Spec.new do |s|

  s.name         = "Packer"
  s.version      = "1.1"
  s.summary      = "One more network library in Swift."
  s.description  = "Packer is a networking library that makes your requests 'plug and play'. Easy!"

  s.homepage     = "https://github.com/jaisonv/Packer"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author    = "Jaison Vieira"
  s.social_media_url   = "http://twitter.com/jaisonnvieira"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/jaisonv/Packer.git", :tag => "#{s.version}" }

  s.source_files  = "Packer", "Packer/*.{h,swift}"

end
