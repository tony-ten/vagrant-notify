
require 'open3'

module Vagrant
    module Notify
        module Action
            module Windows
                class ProcessKill
                    def self.kill_win_proc(pid)
                        cmd = "tskill #{pid}"
                        msg = Vagrant::UI::Basic.new()

                        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
                            exit_status = wait_thr.value
                            if exit_status.exitstatus == 0
                                msg.say(@stdout, "Stopped vagrant-notify-server pid: #{pid}")
                            else
                                msg.say(@stderr, "Failed to kill vagrant-notify-server pid: #{pid}")
                            end
                        end
                    end
                end
            end
        end
    end
end
