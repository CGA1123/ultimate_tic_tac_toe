require "rspec/core/rake_task"
require "standard/rake"

RSpec::Core::RakeTask.new(:spec)

namespace :grpc do
  desc "Generate gRPC files for tic-tac-toe services"
  task :generate_tic_tac_toe do
    path = File.expand_path("./lib/protocol_buffers", __dir__)

    `bundle exec grpc_tools_ruby_protoc -I#{path} --ruby_out=#{path} --grpc_out=#{path} #{path}/tic_tac_toe.proto`

    Rake::Task["standard:fix"].invoke
  end
end

task default: :spec
