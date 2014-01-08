java_home = node['java']["java_home"]
arch = node['java']['arch']
jdk_version = node['java']['jdk_version']

#convert version number to a string if it isn't already
if jdk_version.instance_of? Fixnum
  jdk_version = jdk_version.to_s
end

case jdk_version
when "6"
  tarball_url = node['java']['jdk']['6'][arch]['url']
  tarball_checksum = node['java']['jdk']['6'][arch]['checksum']
when "7"
  tarball_url = node['java']['jdk']['7'][arch]['url']
  tarball_checksum = node['java']['jdk']['7'][arch]['checksum']
end

ruby_block  "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = java_home
  end
end

ojava_ark "jdk" do
  url tarball_url
  checksum tarball_checksum
  app_home java_home
  bin_cmds ["java"]
  action :install
end
