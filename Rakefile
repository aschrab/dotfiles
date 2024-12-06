# frozen_string_literal: true

ENV['DISPLAY'] = ':0'
home = ENV['HOME']

task default: [:kitty]

# Helper class for doing ERuby expansion
class ERuby
  attr_reader :task, :data

  def initialize(task, data = {})
    require 'erb'
    require 'pathname'

    @task = task
    @data = data
    @data.each { |k, v| instance_variable_set "@#{k}", v }
  end

  def src
    task.prerequisites[0]
  end

  def dst
    task.name
  end

  def build
    puts "#{src} => #{dst}"

    b = binding
    rendered = File.open(src, 'r') { |f| ERB.new(f.read, trim_mode: '%-').result b }

    Pathname.new(dst).dirname.mkpath
    File.open(dst, 'w') { |fh| fh.write rendered }
  end

  def self.build *args
    new(*args).build
  end
end

def eruby(hsh, data = {})
  src = hsh.keys[0]
  dst = hsh[src]
  file dst => src do |task|
    ERuby.build task, data
  end
  dst
end

desc 'Configuration for i3 window manager'
task i3: 'i3:reload'

namespace :i3 do
  desc 'Window manager'
  task wm: eruby({ 'i3/wm' => "#{home}/.config/i3/config" }, { wm: 'i3' })
  desc 'Status bar'
  task status: eruby('i3/status' => "#{home}/.config/i3status/config")

  desc 'Reload'
  task reload: %i[wm status] do
    sh 'i3-msg reload'
  end
end

desc 'Configuration for sway'
task sway: 'sway:reload'
namespace :sway do
  desc 'Compositor'
  task compositor: eruby({ 'i3/wm' => "#{home}/.config/sway/i3" }, { wm: 'sway' })

  desc 'Reload'
  task reload: [:compositor] do
    sh 'swaymsg reload'
  end
end

desc 'Configuration for kitty terminal emulator'
task kitty: 'kitty:config'
namespace :kitty do
  conf = 'config/kitty/kitty.conf'
  task config: eruby("#{conf}.eruby" => conf)
end
