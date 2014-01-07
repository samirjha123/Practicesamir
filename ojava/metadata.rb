maintainer       "Protec Innovations"
maintainer_email "dev@protecinnovations.co.uk"
license          "BSD"
description      "Installs/Configures Oracle Java 6/7/8"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"


%w{ apt }.each do |cb|
  depends cb
end
