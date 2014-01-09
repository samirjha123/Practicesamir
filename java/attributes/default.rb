default['java']['install_flavor'] = "openjdk"
default['java']['jdk_version'] = '6'
default['java']['arch'] = kernel['machine'] =~ /x86_64/ ? "x86_64" : "i586"

case platform
when "centos","redhat","fedora"
  default['java']['java_home'] = "/usr/lib/jvm/java"
when "freebsd"
  default['java']['java_home'] = "/usr/local/openjdk#{java['jdk_version']}"
when "arch"
  default['java']['java_home'] = "//usr/lib/jvm/java-#{java['jdk_version']}-openjdk"
else
  default['java']['java_home'] = "/usr/lib/jvm/default-java"
end

# jdk6 attributes
# x86_64                                      
default['java']['jdk']['6']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin'
default['java']['jdk']['6']['x86_64']['checksum'] = '6b493aeab16c940cae9e3d07ad2a5c5684fb49cf06c5d44c400c7993db0d12e8'
default['java']['oracle']['accept_oracle_download_terms']= true

# i586
default['java']['jdk']['6']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/6u30-b12/jdk-6u30-linux-i586.bin'
default['java']['jdk']['6']['i586']['checksum'] = 'b551be83a690bc9fec0107d9aa4f828cd47e150fa54cbedbfa8f80c99e2f18b5'
default['java']['oracle']['accept_oracle_download_terms']= true

# jdk7 attributes
# x86_64
default['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u2-b13/jdk-7u2-linux-x64.tar.gz'
default['java']['jdk']['7']['x86_64']['checksum'] = '411a204122c5e45876d6edae1a031b718c01e6175833740b406e8aafc37bc82d'
default['java']['oracle']['accept_oracle_download_terms']= true

# i586
default['java']['jdk']['7']['i586']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u2-b13/jdk-7u2-linux-i586.tar.gz'
default['java']['jdk']['7']['i586']['checksum'] = '74faad48fef2c368276dbd1fd6c02520b0e9ebdcb1621916c1af345fc3ba65d1'
default['java']['oracle']['accept_oracle_download_terms']= true
