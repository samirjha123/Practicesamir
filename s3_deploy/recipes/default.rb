# Make sure gem is installed\

#include_recipe "s3"
case node.platform
when "debian", "ubuntu"
  #include_recipe "apt"
  packages = ['libxml2-dev','libxslt-dev']
  packages.each do |pkg|
    package pkg do
      action :install
    end
  end
when "centos", "redhat", "fedora"
  packages = ['libxml2-devel','libxslt-devel']
  packages.each do |pkg|
    package pkg do
      action :install
    end
  end
else
  Chef::Log.error("Can't install on #{node.platform} yet.")
end

gem_package "aws-s3" do
  action :install
end

require 'rubygems'
Gem.clear_paths
require 'aws/s3'

# Build the URL based on Maven2 Repository Layout
props = node["s3_deploy"];
file_name = props["artifactId"] + ".war"
#file_name = props["artifactId"] + "-" + props["version"] + ".war"
#full_url = "s3://#{props['bucket_name']}/#{file_name}"
#full_url = "s3://#{props['bucket_name']}/release/#{props['groupId'].gsub('.','/')}/#{props['artifactId']}/#{props['version']}/#{file_name}"
file_path = node["tomcat"]["webapp_dir"] + "/"  + (props["war_name"] || file_name)

# Run the file download
s3_file file_path do
  #remote_path node['s3_deploy']['installer']['file']
  source "ap-northeast-1://samir-nrift-repo/samir.war"
  #bucket node['s3_deploy']['installer']['s3-bucket-name']
  access_key_id node['s3_deploy']['access_key_id']
  secret_access_key node['s3_deploy']['secret_access_key']
  #source full_url
  #backup false
  owner "root"
  group "root"
  mode "0644"
  action :create

  notifies :restart, resources(:service => "tomcat")
end
