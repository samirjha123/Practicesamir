java_home = node['java']["java_home"]
arch = node['java']['arch']
jdk_version = node['java']['jdk_version']
java_home = node['java']['java_home']

#convert version number to a string if it isn't already
if jdk_version.instance_of? Fixnum
  jdk_version = jdk_version.to_s
end

case jdk_version
when "6"
  tarball_url = node['java']['jdk']['6'][arch]['url']
  tarball_checksum = node['java']['jdk']['6'][arch]['checksum']
  accept_oracle_download_terms = node['java']['oracle']['accept_oracle_download_terms']
  # tarball_username = node['java']['oracle']['username']
  # tarball_password = node['java']['oracle']['password']
  
when "7"
  tarball_url = node['java']['jdk']['7'][arch]['url']
  tarball_checksum = node['java']['jdk']['7'][arch]['checksum']
 # tarball_accept_oracle_download_terms = node['java']['oracle']['accept_oracle_download_terms']
end

ruby_block  "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = java_home
  end


java_ark "jdk" do
 url tarball_url
 checksum tarball_checksum
 app_home java_home
 bin_cmds ["java"]
 action :install
end
#bash "jdk" do
  #code "wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "https://edelivery.oracle.com/otn-pub/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz""
  #action :install
#end
