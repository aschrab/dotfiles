ENV['DISPLAY'] = ':0'
home = ENV['HOME']

class ERuby
    attr_reader :task, :data

    def initialize task, data={}
        @task = task
        @data = data
    end

    def build
        require 'erb'
        require 'pathname'

        src = task.prerequisites[0]
        dst = task.name
        puts "#{src} => #{dst}"

        data.each do |k,v|
            instance_variable_set "@#{k}", v
        end

        template = File.open(src) { |fh| fh.read }
        b = binding
        out = ERB.new( template, nil, '%-' ).result b

        Pathname.new(dst).dirname.mkpath
        File.open dst, 'w' do |fh|
            fh.write out
        end
    end

    def self.build *args
        self.new(*args).build
    end
end

def eruby h, data={}
  src = h.keys[0]
  dst = h[src]
  file dst => src do |task|
    ERuby.build task, data
  end
  dst
end

desc "Configuration for i3 window manager"
task :i3 => 'i3:reload'

namespace :i3 do
  desc "Window manager"
  task :wm => eruby({ 'i3/wm' => "#{home}/.config/i3/config" }, { wm: 'i3' })
  desc "Status bar"
  task :status => eruby('i3/status' => "#{home}/.config/i3status/config")

  desc "Reload"
  task :reload => [ :wm, :status ] do
    sh "i3-msg reload"
  end
end

desc "Configuration for sway"
task :sway => 'sway:reload'
namespace :sway do
  desc "Compositor"
  task :compositor => eruby({ 'i3/wm' => "#{home}/.config/sway/i3" }, { wm: 'sway' })

  desc "Reload"
  task :reload => [ :compositor ] do
    sh "swaymsg reload"
  end
end

namespace :ssh do
  dst = "#{home}/.ssh/config"

  task :unlink do
    if File.symlink?(dst)
      $stderr.puts "Removing symlink '#{dst}'"
      File.unlink dst
    end
  end

  task :config => :unlink
  task :config => eruby('ssh/config' => dst)
end if false

desc "Configuration for kitty terminal emulator"
task :kitty => 'kitty:config'
namespace :kitty do
  conf = 'config/kitty/kitty.conf'
  task :config => eruby("#{conf}.eruby" => conf)
end
