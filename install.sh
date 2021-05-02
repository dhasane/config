
# conseguir los submodulos 
# git submodule update --init --recursive
# git submodule update --recursive --remote

git pull --recurse-submodules

# ./{*,.*}
# for f in {*,.*} 
# do 
#     echo "$f -> ~/$f"
# done

# find . -exec echo "File is {} -> ~/{}" \;

function move ()
{
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -a "$dir" ] ||
        mkdir -p "$dir" &&
        mv "$@"
}

hacer_link () {
    if [[ -f "$1" || -d "$1" ]]
    then
        # file exists, do something
        echo "ya existe, moviendo a backup"
        move "$1" "./backup/$1"
    fi

    if [[ ! -L "~/$1" ]]
    then
        # echo "$1 -> ~/$1" 
        ln -sv "$1" ~
    else
        echo "ya ~/$1"
    fi
}

exclude=(
    .
    .git
    README.md
    install.sh
    .config
    backup
)


copy=$(find -maxdepth 1 -printf '%f ' -path "." )

for del in ${exclude[@]}
do
    copy=("${copy[@]/$del}")
done

# home dot files
for file in ${copy[@]}
do 
    hacer_link "$file"
done

echo
echo ".config:"
echo


for_each_dir () {
    ls "$1" | while read file; do hacer_link "$1/$file" /; done
}

for_each_dir ".config"
