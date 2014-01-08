java_home = node['java']["java_home"]

case node['java']['jdk_version']
when "6"
  tarball_url = node['java']['jdk']['6']['i586']['url']
  tarball_checksum = node['java']['jdk']['6']['i586']['checksum']
when "7"
  tarball_url = node['java']['jdk']['7']['i586']['url']
  tarball_checksum = node['java']['jdk']['7']['i586']['checksum']
end

ruby_block  "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = java_home
  end
end

yum_package "glibc" do
  arch "i686"
#  provider Chef::Provider::Package::Yum
end

java_ark "jdk-alt" do
  url tarball_url
  checksum tarball_checksum
  app_home java_home
  default false
  action :install
end
