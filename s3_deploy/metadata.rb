maintainer       "Nathan Pahucki"
maintainer_email "n8@radi.cl"
license          "Apache 2.0"
description      "Deploys a war stored in a private S3 bucket"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"
depends          "tomcat"

%w{ s3_file }.each do |cookbook|

  depends cookbook
end

%w{ centos redhat fedora amazon}.each do |os|

  supports os
end


