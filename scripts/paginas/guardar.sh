#!/bin/sh

# consigue el archivo de recuperacion de firefox
export opentabs=$(find ~/.mozilla/firefox*/*.default*/sessionstore-backups/recovery.jsonlz4);

archivo="$HOME/.paginas"

# convierte el json en links en texto plano
python3 <<< $'
import os, json, lz4.block
f = open(os.environ["opentabs"], "rb")
magic = f.read(8)
jdata = json.loads(lz4.block.decompress(f.read()).decode("utf-8"))
f.close()

for win in jdata.get("windows"):
	for tab in win.get("tabs"):
		i = int(tab.get("index")) - 1
		urls = tab.get("entries")[i].get("url")
		print ( urls )
' >> "$archivo" ## lo guarda en el archivo

cat "$archivo" | sort | uniq | tee "$archivo"
