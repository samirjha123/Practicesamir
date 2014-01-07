include_recipe 'oracle-java::ppa'

execute "accept-oracle-license" do
  command "echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
  action :run
end

package "oracle-java7-installer" do
  action :install
end

package "oracle-java7-set-default" do
  action :install
end

execute "update-java-alternatives-7" do
  command "update-java-alternatives -s java-7-oracle"
  action :run
end
