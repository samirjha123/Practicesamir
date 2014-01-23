# Make sure gem is installed
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
# Gem.clear_paths
require 'aws/s3'

# Build the URL based on Maven2 Repository Layout
props = node["s3_deploy"];
file_name = props["artifactId"] + ".war"
#file_name = props["artifactId"] + "-" + props["version"] + ".war"
full_url = "s3://#{props['bucket_name']}/#{file_name}"
#full_url = "s3://#{props['bucket_name']}/release/#{props['groupId'].gsub('.','/')}/#{props['artifactId']}/#{props['version']}/#{file_name}"
file_path = node["tomcat"]["webapp_dir"] + "/"  + (props["war_name"] || file_name)

# Run the file download
s3_deploy file_path do
  access_key_id node["s3_deploy"]["access_key_id"]
  secret_access_key node["s3_deploy"]["secret_access_key"]
  source full_url
  backup false
  mode "0644"
  notifies :restart, resources(:service => "tomcat")
end