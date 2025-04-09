#!/bin/bash

# Update and install sudo if not present
apt update && apt install -y sudo

# Update again and install required packages
sudo apt update && sudo apt install -y python3 python3-venv python3-pip curl wget screen git lsof

# Add Yarn package source and install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn

# Run Gensyn node setup script
curl -sSL https://raw.githubusercontent.com/ABHIEBA/Gensyn/main/node.sh | bash

# Clone rl-swarm repo
cd $HOME
[ -d rl-swarm ] && rm -rf rl-swarm
git clone https://github.com/ABHIEBA/rl-swarm.git
cd rl-swarm

# Start a new screen session for gensyn
screen -dmS gensyn bash -c "
python3 -m venv .venv && \
. .venv/bin/activate && \
./run_rl_swarm.sh
"

echo "Setup complete. Use 'screen -r gensyn' to attach to the Gensyn session."
