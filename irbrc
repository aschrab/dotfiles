# $Id$

HISTFILE = "~/.irb.hist"
MAXHISTSIZE = 100

begin # Try to load YAML
  require 'yaml'
rescue Exception
end

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
  when :black:   30
  when :red:     31
  when :green:   32
  when :yellow:  33
  when :blue:    34
  when :magenta: 35
  when :cyan:    36
  when :white:   37
  when :normal:  22
  else color
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
if ENV['LESS'].to_s[/^-/]
  # If $LESS already set just make sure it contains options 'R' and 'f'.
  ENV['LESS'] = ENV['LESS'].sub(/^-/, '-fR')
else
  ENV['LESS'] = '-EfFRX'
end

def ri( *names )
  system %Q<ri -fansi #{names.map{|n| n.to_s} * ' '}>
end #}}}

# Show information about given class and its children
def class_tree(root, show_methods = true, colorize = true) #{{{
  # get children of root
  children = Hash.new()
  maxlength = root.to_s.length
  ObjectSpace.each_object(Class) do |aClass|
    if (root != aClass && aClass.ancestors.include?(root))
      children[aClass.superclass] = Array.new() if children[aClass.superclass] == nil
      children[aClass.superclass].push(aClass)
      maxlength = aClass.to_s.length if aClass.to_s.length > maxlength
    end
  end
  maxlength += 3

  # print nice ascii class inheritance tree
  indentation = " "*4
  c = Hash.new("")
  if colorize
    c[:lines]       = "\033[34;1m"
    c[:dots]        = "\033[31;1m"
    c[:classNames]  = "\033[33;1m"
    c[:moduleNames] = "\033[32;1m"
    c[:methodNames] = "\033[39;1m"
  end
  
  recursePrint = proc do |current_root,prefixString|
    if show_methods # show methods (but don't show mixed in modules)
      puts(prefixString.tr('`','|'))
      methods = (current_root.instance_methods - (begin current_root.superclass.instance_methods; rescue NameError; []; end))
      strings = methods.sort.collect {|m|
        prefixString.tr('`',' ') +
        ( children[current_root] == nil ? " "*maxlength : c[:lines]+indentation+"|"+" "*(maxlength-indentation.length-1)) +   
        c[:dots]+":.. " +
        c[:methodNames]+m.to_s
      }
      strings[0] = prefixString + c[:lines]+"- "+c[:classNames]+current_root.to_s
      strings[0] += " " + c[:dots]+"."*(maxlength-current_root.to_s.length) + " "+c[:methodNames]+methods[0] if methods[0] != nil
      strings.each {|aString| puts(aString) }
    else
      string = prefixString + c[:lines]+"- " +c[:classNames]+current_root.to_s
      modules = current_root.included_modules - [Kernel]
      if modules.size > 0
        string += " "*(maxlength-current_root.to_s.length)+c[:lines]+"[ "+c[:moduleNames]+
          modules.join( c[:lines]+", "+c[:moduleNames]) +
          c[:lines]+" ]"
      end
      puts(string)
    end
    if children[current_root] != nil
      children[current_root].sort! {|a, b| a.to_s <=> b.to_s}
      children[current_root].each do |child|
          recursePrint.call(
            child,
            prefixString.tr('`',' ') + indentation + c[:lines]+(child == children[current_root].last ? "`":"|"))
      end
    end
  end

  recursePrint.call(root,"")
end #}}}

# vim: filetype=ruby foldmethod=marker
