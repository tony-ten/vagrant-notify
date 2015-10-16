
require 'open3'

module Vagrant
  module Notify
    module Action
      module Windows
        class ProcessKill
          def self.kill_win_proc(pid, env)
            cmd = "c\:/Windows/System32/tskill.exe #{pid}"

            Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
              exit_status = wait_thr.value
              if exit_status.exitstatus == 0
                env[:machine].ui.success("Stopped vagrant-notify-server pid: #{pid}")
              else
                env[:machine].ui.error("Failed to kill vagrant-notify-server pid: #{pid}")
              end
            end
          end
        end
      end
    end
  end
end
