#!/usr/bin/env ruby
usr = 'daniel'

`nmap -sn 192.168.0.1/24`
  .split("\n")
  .reject { |value| value.include? '[host down]' }
  .select { |value| value.include? 'scan report for' }
  .each do  |value|
  value.delete('^0-9. ')
  puts "#{value}"
  # res = `ssh #{usr}@#{direccion}`
end
