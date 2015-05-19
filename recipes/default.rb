chef_server_ingredient 'opscode-analytics' do
  version node['chef-analytics']['version']
  action [:install]
end

directory '/etc/opscode-analytics' do
  recursive true
end

# write out /etc/opscode/opscode-analytics.rb 
# opscode-analytics-ctl reconfigure
template '/etc/opscode-analytics/opscode-analytics.rb' do
  source 'opscode-analytics.rb.erb'
  owner 'root'
  group 'root'
  action :create
  notifies :reconfigure, 'chef_server_ingredient[opscode-analytics]'
  only_if do ::File.exists?('/etc/opscode-analytics/actions-source.json') end
end