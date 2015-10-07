
require_relative 'action'

module Vagrant
  module Notify
    class Command < Vagrant.plugin('2', :command)

      # Show description when `vagrant list-commands` is triggered
      def self.synopsis
        "plugin: vagrant-notify: forwards notify-send from guest to host machine and notifies provisioning status"
      end

      def execute
        options = {}
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant notify --status'
          o.separator ''
          o.version = Vagrant::Notify::VERSION
          o.program_name = 'vagrant notify'

          o.on('--status', String, 'Show vagrant-notify-server daemon status. (default)')
        end

        argv = parse_options(opts)
        options[:provider] ||= @env.default_provider

        with_target_vms(argv, options) do |machine|
          unless argv.nil?
            @env.action_runner.run(Vagrant::Notify::Action.action_status_server, {
              :machine => machine,
            })
          end
        end

      end

    end
  end
end
