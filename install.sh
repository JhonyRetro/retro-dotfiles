#!/bin/bash

set -e
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "
       ____                      ____       __            _          ____        __  _____ __         
      / / /_  ____  ____  __  __/ __ \___  / /__________ ( )_____   / __ \____  / /_/ __(_) /__  _____
 __  / / __ \/ __ \/ __ \/ / / / /_/ / _ \/ __/ ___/ __ \|// ___/  / / / / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / / / / /_/ / / / / /_/ / _, _/  __/ /_/ /  / /_/ / (__  )  / /_/ / /_/ / /_/ __/ / /  __(__  ) 
\____/_/ /_/\____/_/ /_/\__, /_/ |_|\___/\__/_/   \____/ /____/  /_____/\____/\__/_/ /_/_/\___/____/  
                       /____/                                                                        

" 
read -p "Do you want to install 'retro-dotfiles' on your system? (y/N): " confirmar
if [[ ! "$confirmar" =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 0
fi

sudo -v
echo -e "\nSetting up installation scripts..."
chmod +x scripts/install-packages.sh
chmod +x scripts/etup-configs.sh
chmod +x scripts/setup-system.sh
echo "Scripts are now executable."

echo -e "\nExecuting step 1..."
./scripts/install_packages.sh

echo -e "\nExecuting step 2..."
./scripts/setup_configs.sh

echo -e "\nExecuting step 3..."
./scripts/setup_system.sh

echo -e "
╔══════════════════════════════════════╗
║                                      ║
║        Installation finished!        ║
║                                      ║
╚══════════════════════════════════════╝
"

read -p "It is recommended to restart your system to make sure everything works. Do you want to restart (y/N)" confirmar 
if [[ "$confirmar" =~ ^[Yy]$ ]]; then
    sudo systemctl reboot
    exit 0
fi

