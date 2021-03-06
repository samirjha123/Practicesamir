
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
require 'rest-client'
require 'time'
require 'openssl'
require 'base64'

module S3FileLib
  RestClient.proxy = ENV['http_proxy']
  
  def self.build_headers(date, authorization, token)
    headers = {
      :date => date,
      :authorization => authorization
    }
    if token
      headers['x-amz-security-token'] = token
    end
        
    return headers
  end
  
  def self.get_md5_from_s3(bucket,path,aws_access_key_id,aws_secret_access_key,token)
    return get_digests_from_s3(bucket,path,aws_access_key_id,aws_secret_access_key,token)["md5"]
  end
  
  def self.get_digests_from_s3(bucket,path,aws_access_key_id,aws_secret_access_key,token)
    now, auth_string = get_s3_auth("HEAD", bucket,path,aws_access_key_id,aws_secret_access_key, token)
    
    headers = build_headers(now, auth_string, token)
    response = RestClient.head('https://%s.s3.amazonaws.com%s' % [bucket,path], headers)
    
    etag = response.headers[:etag].gsub('"','')
    digest = response.headers[:x_amz_meta_digest]
    digests = digest.nil? ? {} : Hash[digest.split(",").map {|a| a.split("=")}]

    return {"md5" => etag}.merge(digests)
  end

  def self.get_from_s3(bucket,path,aws_access_key_id,aws_secret_access_key,token)   
    now, auth_string = get_s3_auth("GET", bucket,path,aws_access_key_id,aws_secret_access_key, token)
    
    headers = build_headers(now, auth_string, token)
#    response = RestClient.get('https://%s.s3.amazonaws.com%s' % [bucket,path], headers)
    response = RestClient::Request.execute(:method => :get, :url => 'https://%s.s3.amazonaws.com%s' % [bucket,path], :raw_response => true, :headers => headers)

    return response
  end

  def self.get_s3_auth(method, bucket,path,aws_access_key_id,aws_secret_access_key, token)
    now = Time.now().utc.strftime('%a, %d %b %Y %H:%M:%S GMT')
    string_to_sign = "#{method}\n\n\n%s\n" % [now]
    
    if token
      string_to_sign += "x-amz-security-token:#{token}\n"
    end
    
    string_to_sign += "/%s%s" % [bucket,path]

    digest = digest = OpenSSL::Digest::Digest.new('sha1')
    signed = OpenSSL::HMAC.digest(digest, aws_secret_access_key, string_to_sign)
    signed_base64 = Base64.encode64(signed)

    auth_string = 'AWS %s:%s' % [aws_access_key_id,signed_base64]
        
    [now,auth_string]
  end
end
