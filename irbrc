# vim: ft=ruby fdm=marker
# $Id$

HISTFILE = "~/.irb.hist"
MAXHISTSIZE = 100

# Have :_ refer to value returned by previous command
IRB.conf[:EVAL_HISTORY] = 1000

# These were added sometime in ruby 1.9 series
#IRB.conf[:SAVE_HISTORY] = 100
#IRB.conf[:HISTORY_FILE] = "~/.irb.hist"

IRB.conf[:AUTO_INDENT] = true

# To use to_s instead of inspect for returned values
# IRB.conf[:INSPECT_MODE] = false

# Change the prompt {{{
def term_color(color, rl_ignore=false) #{{{
  color = color.intern if color.is_a? String
  color =
  case color
  when :black
    30
  when :red
    31
  when :green
    32
  when :yellow
    33
  when :blue
    34
  when :magenta
    35
  when :cyan
    36
  when :white
    37
  when :normal
    22
  else
    color
  end

  r = "\033[0;#{color}m"
  r = "\001\001#{ r }\001\002" if rl_ignore
  r
end #}}}
prompt_color = term_color :magenta, true
reset_color  = term_color :normal, true

IRB.conf[:IRB_RC] = proc do |conf|
  lead = " " * conf.irb_name.length
  conf.prompt_i      = "#{prompt_color}#{conf.irb_name} -->#{reset_color} "
  conf.prompt_s      = lead + " #{prompt_color}\-%l #{reset_color}"
  conf.prompt_c      = lead + " #{prompt_color}\-+ #{reset_color}"
  conf.return_format = lead + " #{term_color :red}==>#{term_color :normal} %s\n"
end #}}}

begin # IRb shouldn't fail if can't get completion
  require 'irb/completion'
rescue Exception
end

begin
  if defined? Readline::HISTORY
    # Load history at startup {{{
    histfile = File::expand_path( HISTFILE )
    if File::exists?( histfile )
      lines = IO::readlines( histfile ).collect {|line| line.chomp}
      puts "Read %d saved history commands from %s." %
      [ lines.nitems, histfile ] if $DEBUG || $VERBOSE
      Readline::HISTORY.push( *lines )
    else
      puts "History file '%s' was empty or non-existant." %
      histfile if $DEBUG || $VERBOSE
    end #}}}

    # Save history before exiting {{{
    Kernel::at_exit {
      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
      lines = lines[ -100, 100 ] if lines.nitems > 100
      $stderr.puts "Saving %d history lines to %s." %
      [ lines.length, histfile ] if $VERBOSE || $DEBUG
      File::open( histfile, File::WRONLY|File::CREAT|File::TRUNC ) {|ofh|
        lines.each {|line| ofh.puts line }
      }
    } #}}}
  end
end

# Define "ri" command {{{
# Tell less to pass control characters and not complain about binary files.
ENV['LESS'] = '-fR'
def ri( *names )
  system %Q<ri -fansi #{names.map{|n| n.to_s} * ' '}>
end #}}}
