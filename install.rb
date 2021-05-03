#!/usr/bin/env ruby

require 'fileutils'

# conseguir los submodulos
# git submodule update --init --recursive
# git submodule update --recursive --remote

# git pull --recurse-submodules

def move (orig, destino)
  dir = File.dirname(destino)
  unless File.exists?(dir)
    FileUtils.mkdir_p dir
  end
  FileUtils.mv(orig, destino)
end

def hacer_link(path_origen)

  origen  = Dir.pwd  + path_origen[1..]
  destino = Dir.home + path_origen[1..]

  dir_destino = File.dirname(destino) # "$(dirname "destino")"

  puts "\n=> #{origen} -> #{destino}" # == #{dir_destino}"

  unless File.symlink?(destino)
    if File.exists?(destino)
      puts "ya existe, moviendo a backup"
      move(destino, "./backup/#{origen}")
    end

    puts "link"
    File.symlink(origen, dir_destino)
  else
    puts "ya existe #{destino}"
    # rm "$destino"
  end
end

exclude = [
    './.',
    './..',
    './.git',
    './README.md',
    './install.sh',
    './install.rb',
    './.config',
    './backup'
]

copy = Dir["./{*,.*}"]
copy += Dir["./.config/*"]
copy -= exclude

copy.each { |file| hacer_link file }
