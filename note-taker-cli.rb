#!/usr/bin/ruby

require 'csv'
require 'colorize'

abort "No CSV specified" unless ARGV[0]

Thread.new do
  exit_requested = false
  Kernel.trap( "INT" ) { exit_requested = true }
  loop do
    if exit_requested
      puts "Exit was requested by user\n".red
      exit
    end
  end
end


def write_to_csv(front, back)
  CSV.open(ARGV[0], "a") do |csv|
    csv << [front,back]
  end
end

while true
  puts "\nFront:".blue
  STDOUT.flush
  front = STDIN.gets.chomp
  puts "Back:".blue
  STDOUT.flush
  back = STDIN.gets.chomp
  if front.empty? or back.empty?
    puts front
    puts back
    puts "Empty field, ignoring".red
  else
    write_to_csv(front, back)
    puts "Written to #{ARGV[0]}\n".green
  end
end

