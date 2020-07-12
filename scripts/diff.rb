#!/usr/bin/env ruby
# coding: utf-8
def diff(arr1, arr2)
  (arr1 - arr2).each { |v| puts "<< #{v}" }
  (arr2 - arr1).each { |v| puts ">> #{v}" }
end

if ARGV.size != 2
  puts "dos archivos necesarios"
  exit
end

file1 = File.open (ARGV[0])
file2 = File.open (ARGV[1])

diff(file1, file2)
