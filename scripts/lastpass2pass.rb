#!/usr/bin/env ruby

#
# Option Parsing
#

require 'optparse'
options = OptionParser.new do |opts|
  opts.banner = "Usage: #{ARGV[0]} [options] filename"

  $force         = false
  $default_group = ""

  opts.on("-f", "--force", "Overwrite existing entries") { $force = true }
  opts.on("-d", "--default GROUP", "Place uncategorised entries into GROUP") { |group| $default_group = group }
  opts.on("-h", "--help", "Display this screen") { puts opts; exit }
end.parse!

#
# Usage Checks
#

$filename = ARGV.join(" ")

# Check for a filename.
if $filename.empty?
  puts options
  exit 0
end

class Store < Array
  def save
    succeeded = []
    failed    = []

    each do |entry|
      print "insert #{entry.name}"

      IO.popen("pass insert -m #{"-f" if $force} '#{entry.name}' > /dev/null", 'w') do |io|
        io.puts entry
      end

      if $? == 0
        puts " ok"
        succeeded << entry
      else
        puts " fail"
        failed << entry
      end
    end

    [succeeded, failed]
  end
end

class Entry
  attr_accessor :name, :url, :username, :password, :extra, :fav

  def to_pass
    s = ""
    s += "#{@password}\n\n"
    s += "#{@name}\n"
    # Generate a line that is as long as the name.
    s += "#{@name.gsub(/./, "-")}\n"
    s += "[username]: #{@username}\n" unless @username.empty?
    s += "[password]: #{@password}\n" unless @password.empty?
    s += "[url]: #{@url}\n" unless @url =~ /http:\/\/(sn)?/
    s += "#{@extra}\n" unless @extra.nil?

    s
  end

  def to_s
    to_pass
  end
end

# Extract individual entries
entries = []
begin
  print "read #{$filename}"

  file  = File.open($filename)
  entry = ""

  file.each do |line|
    if line =~ /^(https?|ftps?)/
      entries.push(entry)
      entry = ""
    end
    entry += line
  end
  entries.push(entry)
  entries.shift
  puts " ok"
rescue
  puts " fail (no such file)"
  exit 1
end

# Parse entries and create Entry objects
store = Store.new
entries.each do |e|
  entry = Entry.new

  args = e.split(",")

  entry.url      = args.shift
  entry.username = args.shift
  entry.password = args.shift
  entry.fav      = args.pop
  group = args.pop
  if group.empty?
    group = $default_group
  end
  entry.name  = "#{group.gsub '\\', '/'}/#{args.pop}"
  extra = args.join("")
  if extra =~ /^"/
    entry.extra = extra[1...-1]
  else
    entry.extra = extra
  end

  store << entry
end

succeeded, failed = store.save

puts ""
puts "total #{store.length}"
puts "succeeded #{succeeded.length}"
puts "failed #{failed.length}"
