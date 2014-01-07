apt_repository "oracle-java-6" do
  uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "EEA14886"
  action :add
end
