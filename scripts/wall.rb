#!/usr/bin/env ruby

require 'json'

# contener la direccion a varios fondos de pantalla
class WallFile
  def initialize(dir)
    @nombre = dir
    file = File.open(@nombre).read
    @walp = JSON.parse(file)
  end

  # poner el fondo de pantalla en FILE
  def _wallpaper(name)
    puts "setting #{name}"
    system("feh --bg-fill #{@walp[name]}")
  end

  # guardar los cambios hechos
  def store
    File.open(@nombre.to_s, 'w') do |file|
      file.write(@walp.to_json)
    end
  end

  def add_wallp(name, dir)
    @walp[name] = dir
  end

  def prt_wallp
    puts @walp
  end

  def show_name
    puts @nombre
  end

  # pone el primer wallpaper encontrado
  def first
    @walp.each do |key, _val|
      _wallpaper(key)
      break
    end
  end
end

# me gustaria por aqui poner para que cuadre las pantallas automaticamente con xrandr o algo por el estilo

wal_config = '/home/daniel/.wallp.json'
name = ARGV[0]
filename = ARGV[1]

unless File.file?(wal_config)
  File.open(wal_config, 'w') { |f| f.write('{ }')}
end

w = WallFile.new(wal_config)

if filename
  puts filename
  puts name
  if name
    w.add_wallp(name, filename)
    w.store
  else
    puts 'no name specified'
  end
elsif name
  w._wallpaper(name)
else
  w.first
end
