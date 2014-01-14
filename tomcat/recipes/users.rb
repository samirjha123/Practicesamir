template "#{node["tomcat"]["config_dir"]}/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  owner "root"
  group "root"
  mode "0644"
#  variables(
#    :users => TomcatCookbook.users,
#    :roles => TomcatCookbook.roles
#  )
  variables(
    :users => [ {:id => "admin", :password => "password", :roles => ["admin", "manager"]},
                {:id => "admin", :password => "password", :roles => ["admin", "manager"]}],
    :roles => ["manager", "admin"]
  )
  notifies :restart, "service[tomcat]"
end
