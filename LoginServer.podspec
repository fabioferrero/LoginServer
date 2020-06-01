
Pod::Spec.new do |spec|

  spec.name         = "LoginServer"
  spec.version      = "0.0.1"
  spec.summary      = "Small module that helps create a simple testing login flow"

  spec.description  = "LoginServer is a small module that helps Training Devs to create a simple testing login flow"

  spec.homepage     = "https://github.com/fabioferrero/LoginServer"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Fabio Ferrero" => "f.ferrero@reply.it" }

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/fabioferrero/LoginServer.git", :tag => "#{spec.version}" }
  spec.swift_version = '5.1'

  spec.source_files  = "LoginServer/**/*.{h,m,swift}"

end
