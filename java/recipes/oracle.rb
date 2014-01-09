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
  # tarball_accept_oracle_download_terms = node['java']['oracle']['accept_oracle_download_terms']
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
end

execute "jdk" do
  url = node['java']['jdk']['7'][arch]['url']
  checksum = node['java']['jdk']['7'][arch]['checksum']
 # accept_oracle_download_terms tarball_accept_oracle_download_terms
 # username tarball_username
 # password tarball_password
  app_home java_home
  bin_cmds ["java"]
  action :install
end
