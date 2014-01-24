def initialize(new_resource, run_context)
    #super(new_resource, run_context)
    @s3 = S3Deploy.new(new_resource, run_context)
end

# Override
def load_current_resource
  @s3.load_current_resource 
end

# Delegate everything else
def method_missing(name, *args)
  @s3.send(name, *args)
end
