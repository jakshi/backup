begin
  use_inline_resources
rescue
end

action :setup do
  %w{keys models logs}.each do |p|
    directory "#{new_resource.base_dir}/#{p}" do
      action :create
      recursive true
    end
  end
  
  template "#{new_resource.base_dir}/config.rb" do
    source new_resource.source
    cookbook new_resource.cookbook
    variables({
                :encryption_password => new_resource.encryption_password
              })
  end
end

action :remove do
  directory new_resource.base_dir do
    action :remove
    recursive true
  end
end

