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
  bin_cmds = node['java']['jdk']['6']['bin_cmds']
when "7"
  tarball_url = node['java']['jdk']['7'][arch]['url']
  tarball_checksum = node['java']['jdk']['7'][arch]['checksum']
  bin_cmds = node['java']['jdk']['7']['bin_cmds']
end

if tarball_url =~ /example.com/
  Chef::Application.fatal!("You must change the download link to your private repository. You can no longer download java directly from http://download.oracle.com without a web broswer")
end

include_recipe "java::set_java_home"

java_ark "jdk" do
  url tarball_url
  checksum tarball_checksum
  app_home java_home
  bin_cmds bin_cmds
  alternatives_priority 1062
  action :install
end
