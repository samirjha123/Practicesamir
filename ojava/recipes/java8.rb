include_recipe 'oracle-java::ppa'

execute "accept-oracle-license" do
  command "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
  action :run
end

package "oracle-java8-installer" do
  action :install
end

package "oracle-java8-set-default" do
  action :install
end

execute "update-java-alternatives-8" do
  command "update-java-alternatives -s java-8-oracle"
  action :run
end
