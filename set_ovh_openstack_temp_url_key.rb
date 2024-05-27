#!/usr/bin/env ruby

unless ARGV.length == 1
  print "Usage: #{$PROGRAM_NAME} temp_url_key\n"
  exit 1
end

require 'dotenv'
Dotenv.load

%w[
  OVH_OPENSTACK_URL
  OVH_OPENSTACK_REGION_NAME
  OVH_OPENSTACK_USER
  OVH_OPENSTACK_PASSWORD
].each do |key|
  if ENV[key].nil?
    print "Required key '#{key}' is missing\n"
    exit 1
  end
end

connection_params = {
  openstack_auth_url:   ENV['OVH_OPENSTACK_URL'],
  openstack_username:   ENV['OVH_OPENSTACK_USER'],
  openstack_api_key:    ENV['OVH_OPENSTACK_PASSWORD'],
  openstack_region:     ENV['OVH_OPENSTACK_REGION_NAME'],
}

require 'fog/openstack'

begin
  connection = Fog::OpenStack::Storage.new(connection_params)
  connection.post_set_meta_temp_url_key(ARGV[0])
  print "OK, please change OVH_OPENSTACK_TEMP_URL_KEY env variable with the following value: #{ARGV[0]}"
rescue Excon::Error::Unauthorized
  print 'Unauthorized, check your credentials'
  exit 2
end
