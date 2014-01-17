default[:mvn_s3_deploy][:access_key_id] = "YOUR_KEY_HERE"
default[:mvn_s3_deploy][:secret_access_key] = "YOUR_SECRET_KEY_HERE"
default[:mvn_s3_deploy][:bucket_name] = "BUCKET_NAME_HERE"
default[:mvn_s3_deploy][:artifactId] = "ARTIFACT_ID" # The maven artifactId for your war application
default[:mvn_s3_deploy][:groupId] = "GROUP_ID" # The maven groupId for your war application
default[:mvn_s3_deploy][:version] = "0.0.1-SNAPSHOT" # The version number NOTE: in the maven distribution sections, unsure uniqueVersion is false!
default[:mvn_s3_deploy][:war_name] = "autorepo.war" # The name of the file as it will reside in the webapps directory and by default, the context name for the application
