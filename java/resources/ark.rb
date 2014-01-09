actions :install, :remove

attribute :url, :regex => /^http:\/\/.*(tar.gz|bin|zip)$/, :default => nil
attribute :mirrorlist, :kind_of => Array, :default => nil
attribute :checksum, :regex => /^[a-zA-Z0-9]{64}$/, :default => nil
attribute :app_home, :kind_of => String, :default => nil
attribute :app_home_mode, :kind_of => Integer, :default => 0755
attribute :bin_cmds, :kind_of => Array, :default => nil
attribute :owner, :default => "root"
attribute :accept_oracle_download_terms,  :equal_to => [true, false], :default => true
attribute :username, :default => samirkumarjha007@gmail.com
attribute :password, :default => samirJHA123
attribute :default, :equal_to => [true, false], :default => true

# we have to set default for the supports attribute
# in initializer since it is a 'reserved' attribute name
def initialize(*args)
  super
  @action = :install
  @supports = {:report => true, :exception => true}
end
