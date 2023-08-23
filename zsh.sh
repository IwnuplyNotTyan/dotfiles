# !/usr/bin/sh
echo " > Installing Dep"
nix-channel --update &> /dev/null
nix-env -iA nixpkgs.nix-zsh-completions &> /dev/null
nix-env -iA nixpkgs.git &> /dev/null
nix-env -iA nixpkgs.fzf &> /dev/null
doas dnf5 install zsh chsh &> /dev/null
doas chsh /usr/bin/zsh &> /dev/null
echo " > Installing ZSH Plugin"
rm -rf ~/.zsh/
mkdir -p ~/.zsh/
cd ~/.zsh/
echo " > lukechilds/zsh-nvm"
git clone https://github.com/lukechilds/zsh-nvm.git &> /dev/null
echo " > lukechilds/zsh-better-npm-completion"
git clone https://github.com/lukechilds/zsh-better-npm-completion &> /dev/null
echo " > hlissner/zsh-autopair"
git clone https://github.com/hlissner/zsh-autopair &> /dev/null
echo " > wfxr/formarks"
git clone https://github.com/wfxr/formarks &> /dev/null
echo " > arzzen/calc.plugin.zsh"
git clone https://github.com/arzzen/calc.plugin.zsh &> /dev/null
echo " > chisui/zsh-nix-shell"
git clone https://github.com/chisui/zsh-nix-shell &> /dev/null
echo " > zshzoo/cd-ls"
git clone https://github.com/zshzoo/cd-ls &> /dev/null
echo " > MenkeTechnologies/zsh-cargo-completion"
git clone https://github.com/MenkeTechnologies/zsh-cargo-completion &> /dev/null
echo " > chrisands/zsh-yarn-completions"
git clone https://github.com/chrisands/zsh-yarn-completions &> /dev/null
echo " > thetic/extract"
git clone https://github.com/thetic/extract &> /dev/null
echo " > nix-community/nix-zsh-completions"
git clone https://github.com/nix-community/nix-zsh-completions &> /dev/null
echo " > pkulev/zsh-rustup-completion"
git clone https://github.com/pkulev/zsh-rustup-completion &> /dev/null
echo " > zuxfoucault/colored-man-pages_mod"
git clone https://github.com/zuxfoucault/colored-man-pages_mod &> /dev/null
echo " > ChrisPenner/copy-pasta"
git clone https://github.com/ChrisPenner/copy-pasta &> /dev/null
echo " > zsh-users/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions &> /dev/null
echo " > zdharma-continuum/fast-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting &> /dev/null
echo " > zsh-users/zsh-completions"
git clone https://github.com/zsh-users/zsh-completions &> /dev/null
