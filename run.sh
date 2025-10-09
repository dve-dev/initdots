#!/bin/sh
echo
echo "Setup dotfiles:"
echo
if [[ -d ~/.ssh ]]; then
  echo "[*] Directory present: ~/.ssh"
  chmod 700 ~/.ssh
  echo
else
  echo "[!] Directory NOT present: ~/.ssh"
  echo
  echo "Create it or get it from the pendrive!"
  echo "Bye..."
  exit 1
fi
if [[ -f ~/.ssh/config ]]; then
  echo "[*] File present: ~/.ssh/config"
  echo
else
  echo "[!] File NOT present: ~/.ssh/config"
  echo
  echo "Create it or get it from the pendrive!"
  echo "Bye..."
  exit 1
fi
if [[ -f ~/.ssh/gitdvedev ]]; then
  echo "[*] File present: ~/.ssh/gitdvedev"
  chmod 600 ~/.ssh/gitdvedev
  echo
else
  echo "[!] File NOT present: ~/.ssh/gitdvedev"
  echo
  echo "Create it or get it from the pendrive!"
  echo "Bye..."
  exit 1
fi
if [[ -f ~/.ssh/gitdvedev.pub ]]; then
  echo "[*] File present: ~/.ssh/gitdvedev.pub"
  chmod 644 ~/.ssh/gitdvedev.pub
  echo
else
  echo "[!] File NOT present: ~/.ssh/gitdvedev.pub"
  echo
  echo "Create it or get it from the pendrive!"
  echo "Bye..."
  exit 1
fi
echo
echo "Add ssh key to agent:"
echo
sudo systemctl enable sshd
sudo systemctl start sshd
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/gitdvedev
echo
echo "[*] ssh key shoud be up and running."
echo
echo "Download dotfiles from github:"
echo
if [[ -d ~/code ]]; then
  echo "[*] Directory present: ~/code"
  echo
else
  echo "[+] Create directory: ~/code"
  mkdir ~/code
fi
if [[ -d ~/code/dotfiles ]]; then
  echo "[*] Directory present: ~/code/dotfiles"
  echo
  echo "No github action for now. Remove dir, or pull for yourself!"
  echo "Bye..."
  exit 1
else
  echo "[+] Clone directory from github: ~/code/dotfiles"
  cd ~/code
  pwd
  git clone git@github.com:dve-dev/dotfiles.git
fi
if [[ -d ~/code/dotfiles/.git ]]; then
  echo "[*] Directory present: ~/code/dotfiles/.git"
  echo
  echo "So we have dotfiles downloaded, lets setup stow!"
  echo
  omarchy-pkg-add stow
  echo
  echo "And copy .stowrc to its place:"
  cp ~/code/dotfiles/stow/.stowrc ~/
  echo
else
  echo "[!] Directory NOT present: ~/code/dotfiles/.git"
  echo
  echo "Something went rong, sorry."
  echo "Bye..."
  exit 1
fi
echo
echo "Done."
echo
