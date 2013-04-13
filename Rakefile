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
        out = ERB.new( template, nil, '%' ).result b

        Pathname.new(dst).dirname.mkpath
        File.open dst, 'w' do |fh|
            fh.write out
        end
    end

    def self.build *args
        self.new(*args).build
    end
end

def eruby h
  src = h.keys[0]
  dst = h[src]
  file dst => src do |task|
    ERuby.build task
  end
  dst
end

desc "Configuration for i3 window manager"
task :i3
task :i3 => eruby('i3/wm' => "#{home}/.config/i3/config")
task :i3 => eruby('i3/status' => "#{home}/.config/i3status/config")
