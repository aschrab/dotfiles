Pry.config.editor = 'vim'
Pry.config.color = true

def term_color(name, text) #{{{
  Pry.color ? Pry::Helpers::Text.send(name, text) : text
end #}}}
def prompt_color(name, text) #{{{
  if Pry.color
    "\001#{term_color(name, '{text}')}\002".sub( '{text}', "\002#{text}\001" )
  else
    text
  end
end #}}}

Pry.config.prompt = [
  proc do |object, nest_level, pry|
    prompt  = prompt_color :magenta, Pry.view_clip(object)
    prompt += ":#{nest_level}" if nest_level > 0
    prompt += prompt_color :cyan, ' » '
  end,
  proc { |object,nest_level,pry| prompt_color :cyan, '» ' }
]

# use awesome print for output if available
begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
end

# Setup hirb if it's available
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end
if defined? Hirb
  # Dirty hack to support in-session Hirb.disable/enable
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @default_print ||= Pry.config.print
      Pry.config.print = proc do |output, value, pry|
        Hirb::View.view_or_page_output(value) || @default_print.call(output, value, pry)
      end
    end

    def disable_output_method
      Pry.config.print = @default_print
      @output_method = nil
    end
  end

  Hirb.enable
end

if defined?(PryByebug)
  #Pry.commands.alias_command 'c', 'continue'
  #Pry.commands.alias_command 's', 'step'
  #Pry.commands.alias_command 'n', 'next'
  #Pry.commands.alias_command 'f', 'finish'
  # Hit Enter to repeat last command
  Pry::Commands.command(/^$/, "repeat last command") do
    _pry_.run_command Pry.history.to_a.last
  end
end

# Methods to generate "toy" Hash or Array objects{{{
  # Copied from https://gist.github.com/807492
  class Array
    def self.toy(n=10, &block)
      block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
    end
  end

  class Hash
    def self.toy(n=10)
      Hash[Array.toy(n){|c| (96+(c+1)).chr.to_sym }.zip(Array.toy(n))]
    end
  end
#}}}

class Integer
  def inspect
    to_s.split('').reverse.each_slice(3).map{ |x| x.reverse.join '' }.reverse.join('_')
  end
end

# Add `where_is` method to show location where a method or class is defined
# From https://gist.github.com/wtaysom/1236979
module Where
  class <<self
    def is_proc(proc)
      source_location(proc)
    end

    def is_method(klass, method_name)
      source_location(klass.method(method_name))
    end

    def is_instance_method(klass, method_name)
      source_location(klass.instance_method(method_name))
    end

    def are_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end

    def are_instance_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end

    def is_class(klass)
      methods = defined_methods(klass)
      file_groups = methods.group_by{|sl| sl[0]}
      file_counts = file_groups.map do |file, sls|
        lines = sls.map{|sl| sl[1]}
        count = lines.size
        line = lines.min
        {file: file, count: count, line: line}
      end
      file_counts.sort_by!{|fc| fc[:count]}
      source_locations = file_counts.map{|fc| [fc[:file], fc[:line]]}
      source_locations
    end

    # Raises ArgumentError if klass does not have any Ruby methods defined in it.
    def is_class_primarily(klass)
      source_locations = is_class(klass)
      if source_locations.empty?
        methods = defined_methods(klass)
        raise ArgumentError, (methods.empty? ?
          "#{klass} has no methods" :
          "#{klass} only has built-in methods (#{methods.size} in total)"
        )
      end
      source_locations[0]
    end

  private

    def source_location(method)
      method.source_location || (
        method.to_s =~ /: (.*)>/
        $1
      )
    end

    def are_via_extractor(extractor, klass, method_name)
      methods = klass.ancestors.map do |ancestor|
        method = ancestor.send(extractor, method_name)
        if method.owner == ancestor
          source_location(method)
        else
          nil
        end
      end
      methods.compact!
      methods
    end

    def defined_methods(klass)
      methods = klass.methods(false).map{|m| klass.method(m)} +
        klass.instance_methods(false).map{|m| klass.instance_method(m)}
      methods.map!(&:source_location)
      methods.compact!
      methods
    end
  end
end
def where_is(klass, method = nil)
  if method
    begin
      Where.is_instance_method(klass, method)
    rescue NameError
      Where.is_method(klass, method)
    end
  else
    Where.is_class_primarily(klass)
  end
end

# vim: ft=ruby
