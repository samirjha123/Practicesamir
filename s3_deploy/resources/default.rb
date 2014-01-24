def initialize(*args)
  @action = :create
  super
  end

attribute :path, :kind_of => String, :name_attribute => true
attribute :access_key_id, :kind_of => String, :required => true
attribute :secret_access_key, :kind_of => String, :required => true
attribute :source, :kind_of => String, :required => true
attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]
attribute :mode, :kind_of => String
attribute :checksum, :regex => /^[a-zA-Z0-9]{64}$/
attribute :backup, :kind_of => [Integer, FalseClass]
attribute :content, :kind_of => String
