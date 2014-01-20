# include_recipe "tomcat"

# Make sure gem is installed
# r = gem_package "aws-s3" do
#  action :nothing
#end
#r.run_action(:install)
#require 'rubygems'
#Gem.clear_paths
#require 'aws/s3'

# Build the URL based on Maven2 Repository Layout
props = node["mvn_s3_deploy"];
file_name = props["artifactId"] + ".war"
#file_name = props["artifactId"] + "-" + props["version"] + ".war"
full_url = "s3://#{props['bucket_name']}/#{file_name}"
#full_url = "s3://#{props['bucket_name']}/release/#{props['groupId'].gsub('.','/')}/#{props['artifactId']}/#{props['version']}/#{file_name}"
file_path = node["tomcat"]["webapp_dir"] + "/"  + (props["war_name"] || file_name)

# Run the file download
mvn_s3_deploy file_path do
  #access_key_id node["mvn_s3_deploy"]["access_key_id"]
  #secret_access_key node["mvn_s3_deploy"]["secret_access_key"]
  source full_url
  backup false
  mode "0644"
  notifies :restart, resources(:service => "tomcat")
end
