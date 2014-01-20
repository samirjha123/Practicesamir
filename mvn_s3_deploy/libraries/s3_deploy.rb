require 'chef/provider/remote_file'

class S3Deploy < Chef::Provider::RemoteFile
  def action_create
    Chef::Log.debug("Checking #{@new_resource} for changes")

    if current_resource_matches_target_checksum?
      Chef::Log.debug("File #{@new_resource} checksum matches target checksum (#{@new_resource.checksum}), not updating")
    else
      Chef::Log.debug("File #{@current_resource} checksum didn't match target checksum (#{@new_resource.checksum}), updating")
      fetch_from_s3(@new_resource.source) do |raw_file|
        if matches_current_checksum?(raw_file)
          Chef::Log.debug "#{@new_resource}: Target and Source checksums are the same, taking no action"
        else
          backup_new_resource
          Chef::Log.debug "copying remote file from origin #{raw_file.path} to destination #{@new_resource.path}"
          FileUtils.cp raw_file.path, @new_resource.path
          @new_resource.updated_by_last_action(true)
        end
      end
    end
    enforce_ownership_and_permissions

    @new_resource.updated
  end

  def fetch_from_s3(source)
    begin
      protocol, bucket, name = URI.split(source).compact
      name = name[1..-1]
      #AWS::S3::Base.establish_connection!(
          #:access_key_id => @new_resource.access_key_id,
          #:secret_access_key => @new_resource.secret_access_key
      #)
      obj = AWS::S3::S3Object.find name, bucket
      Chef::Log.debug("Downloading #{name} from S3 bucket #{bucket}")
      file = Tempfile.new("chef-s3-file")
      file.write obj.value
      Chef::Log.debug("File #{name} is #{file.size} bytes on disk")
      begin
        yield file
      ensure
        file.close
      end
    rescue URI::InvalidURIError
      Chef::Log.warn("Expected an S3 URL but found #{source}")
      nil
    end
  end
end
