#!/usr/bin/ruby

require 'csv'

abort "No CSV specified" unless ARGV[0]

Thread.new do
  exit_requested = false
  Kernel.trap( "INT" ) { exit_requested = true }
  loop do
    exit if exit_requested
  end
end


def write_to_csv(front, back)
  CSV.open(ARGV[0], "a") do |csv|
    csv << [front,back]
  end
end

while true
  puts "\nFront:"
  STDOUT.flush
  front = STDIN.gets.chomp
  puts "Back:"
  STDOUT.flush
  back = STDIN.gets.chomp
  if front.empty? or back.empty?
    puts front
    puts back
    puts "Empty field, ignoring"
  else
    write_to_csv(front, back)
    puts "Written to #{ARGV[0]}\n"
  end
end
print "Exit was requested by user\n"

