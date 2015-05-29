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
rescue LoadError
  AwesomePrint.pry!
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
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
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

# vim: ft=ruby
