#! /bin/bash

dotfile_dir=$(cd $(dirname '$1') && pwd) 
replace_dot_files=(".bashrc" ".bash_profile" ".bash_aliases")
for file in ${replace_dot_files[@]} $(ls -d .config/*);do
  if [ -f ~/${file} ] && ! [ -L ~/${file} ]; then
    mv ~/${file} ~/${file}.bk
  fi
  ln -sf ${dotfile_dir}/${file} ~/${file}
done
