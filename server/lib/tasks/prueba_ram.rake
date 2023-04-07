#!/home/alex/.rvm/rubies/ruby-2.5.1/bin/ruby
#
namespace :prueba do
  desc "Prueba la RAM"
    task ram: :environment do

      array = [] 
      100_000_000.times do |i| 
	array << i 
      end
      ram = Integer(`ps -o rss= -p #{Process.pid}`) * 0.001 
      puts "Process: #{Process.pid}: #{ram} mb"
      Process.fork do 
	ram = Integer(`ps -o rss= -p #{Process.pid}`) * 0.001 
	puts "Process: #{Process.pid}: #{ram} mb" 
      end
    end
end
