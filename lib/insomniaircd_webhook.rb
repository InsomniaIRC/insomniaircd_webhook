require 'json'
require 'rack/utils'
require 'sinatra'

FileUtils.mkdir_p 'repos'

post '/webhook' do
  payload = request.body.read
  verify_signature(payload)
  data = JSON.parse(payload)

  event = request.env['HTTP_X_GITHUB_EVENT']
  if event == "ping"
    ping data

  elsif event == "push"
    push data

  else
    404
  end
end

def ping(data)
  "pong"
end

def push(data)
  ref = data["ref"]
  who = data["sender"]["login"]
  repo = data["repository"]["name"]
  url = data["repository"]["clone_url"]

  puts "#{who} pushed to #{ref} on repository #{repo}"

  if ref == 'refs/heads/master'
    if generate_config repo, url
      200
    else
      500
    end
  end
end

def verify_signature(payload_body)
  if ENV['SECRET_TOKEN']
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET_TOKEN'], payload_body)
    return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end
end
