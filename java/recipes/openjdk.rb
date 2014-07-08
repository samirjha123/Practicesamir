unless node.recipe?('java::default')
  Chef::Log.warn("Using java::default instead is recommended.")

  # Even if this recipe is included by itself, a safety check is nice...
  [ node['java']['openjdk_packages'], node['java']['java_home'] ].each do |v|
    if v.nil? or v.empty?
      include_recipe "java::set_attributes_from_version"
    end
  end
end

jdk = Opscode::OpenJDK.new(node)

if platform_requires_license_acceptance?
  file "/opt/local/.dlj_license_accepted" do
    owner "root"
    group "root"
    mode "0400"
    action :create
    only_if { node['java']['accept_license_agreement'] }
  end
end

node['java']['openjdk_packages'].each do |pkg|
  package pkg
end

if platform_family?('debian', 'rhel', 'fedora')
  java_alternatives 'set-java-alternatives' do
    java_location jdk.java_home
    default node['java']['set_default']
    priority jdk.alternatives_priority
    case node['java']['jdk_version'].to_s
    when "6"
      bin_cmds node['java']['jdk']['6']['bin_cmds']
    when "7"
      bin_cmds node['java']['jdk']['7']['bin_cmds']
    end
    action :set
  end
end

if node['java']['set_default'] and platform_family?('debian')
  include_recipe 'java::default_java_symlink'
end

# We must include this recipe AFTER updating the alternatives or else JAVA_HOME
# will not point to the correct java.
include_recipe 'java::set_java_home'
