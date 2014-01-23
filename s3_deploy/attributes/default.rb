efault[:s3_deploy][:access_key_id] = "YOUR_KEY_HERE"
default[:s3_deploy][:secret_access_key] = "YOUR_SECRET_KEY_HERE"
default[:s3_deploy][:bucket_name] = "elasticbeanstalk-ap-northeast-1-724566739352"
default[:s3_deploy][:artifactId] = "samir" # The maven artifactId for your war application
default[:s3_deploy][:groupId] = "samir" # The maven groupId for your war application
default[:s3_deploy][:version] = "0.0.1-SNAPSHOT" # The version number NOTE: in the maven distribution sections, unsure uniqueVersion is false!
default[:s3_deploy][:war_name] = "samir.war" # The name of the file as it will reside in the webapps directory and by default, the context name for the application
