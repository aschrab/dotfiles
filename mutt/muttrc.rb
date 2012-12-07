def mlist mbox, opts={} #{{{
  case mbox
  when Hash
    opts = mbox
  else
    opts[:mbox] = mbox
  end

  unless opts[:address]
    opts[:address] =
      case opts[:mbox]
      when %r<^debian/>
        opts[:mbox].sub(%r</>,'-')
      else
        opts[:mbox].sub(%r<.*/>,'')
      end
  end

  out = []
  out << "mailboxes =L/#{opts[:mbox]}"
  out << "subscribe #{opts[:address]}"
  out << "mbox-hook L/#{opts[:mbox]} =Read/#{opts[:mbox]}"
  if opts[:from]
    out << "send-hook #{opts[:address]} my_hdr From: #{opts[:from]}"
  end

  if opts[:nomove]
    out << "folder-hook L(ists)?/#{opts[:mbox]} 'set move=no'"
  end

  out << ''

  out.join "\n"
end #}}}

# Find the currently executing mutt binary
def mutt_binary #{{{
  return ENV['MUTT_BINARY'] if ENV['MUTT_BINARY']
  mutt_pid = ENV['MUTT_PID'] || Process.ppid
  link = "/proc/#{mutt_pid}/exe"
  dest = File.readlink(link)

  # Make sure that the found item is a mutt (and not just something in
  # a "mutt" directory.
  exit 1 unless dest and dest[%r{mutt[^/]*$}i]
  link
end #}}}

# Return a comparable version number for the given string.
# If no string is given, uses version of #mutt_binary
def mutt_version vers=nil #{{{
  vers ||= mutt_verbose_version[/\AMutt\s+([\d.]+)(?:\+\d+)?\s/,1]
  vers = vers.split('.').map{ |x| x.to_i }
  vers.extend Comparable
end #}}}

# Get output of calling #mutt_binary with given flags
def mutt_output flags #{{{
  IO.popen("#{mutt_binary} -F /dev/null #{flags} 2> /dev/null"){ |x| x.read }
end #}}}

# Get results of mutt -v
def mutt_verbose_version #{{{
  $mutt_verbose_version ||= mutt_output '-v'
end #}}}

# Get list of all mutt settings
def mutt_settings #{{{
  $mutt_settings ||= mutt_output '-D'
end #}}}

# Check if current mutt was compiled with the named feature
# by looking for "+#{name}" in `mutt -v` output
def mutt_feature name #{{{
  mutt_verbose_version[/\+#{name.to_s.upcase}(\s|$)/]
end #}}}

# Check if current mutt was compiled with the named patch
def mutt_patch match #{{{
  mutt_verbose_version[match]
end #}}}

# Check if current mutt knows about the named variable
def mutt_variable name #{{{
  mutt_settings[/^#{name}[ =]/]
end #}}}

# vim: foldmethod=marker
