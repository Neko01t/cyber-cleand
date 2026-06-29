#!/bin/bash
# instslling script
echo "Creating configuration .... "
config="$HOME/.config/cyber-cleand"
mkdir -p "$config"
touch "$config/rules.conf"
cat ./config/rules.conf >"$config/rules.conf"

echo "Installing the scripts "
app_dir="$HOME/.local/share/cyber-cleand"

mkdir -p $app_dir

cp ./scanner.sh "$app_dir/scanner.sh"
cp ./cyber-cleand.sh "$app_dir/cyber-cleand.sh"

echo "setting perms"

chmod +x "$app_dir/scanner.sh"
chmod +x "$app_dir/cyber-cleand.sh"

echo "command script...."
echo "not yet developed"

# instaltion script
