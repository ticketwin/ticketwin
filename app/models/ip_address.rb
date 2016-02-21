class IpAddress < ActiveRecord::Base
  lookup_by :ip_address, find_or_create: true
end
