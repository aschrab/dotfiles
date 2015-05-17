Pry.config.editor = 'vim'
Pry.config.prompt = Pry::NAV_PROMPT

# use awesome print for output if available
begin
  require 'awesome_print'
  AwesomePrint.pry!
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
