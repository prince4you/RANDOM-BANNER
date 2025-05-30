#!/bin/bash

# Define Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
p'='MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
PURPLE='\033[1;38;5;129m'
RANGE='\033[1;38;5;208m'
 PINK='\033[1;38;5;198m'
RESET='\033[0m'
BOLD='\033[1m'

# Check for nala
if ! command -v nala &> /dev/null; then
    echo -e "${YELLOW}✗ Nala not found! Installing now...${NC}"
    apt update -y && apt install nala
    echo -e "${GREEN}✓ Nala installed successfully!${NC}"
else
    echo -e "${GREEN}✓ Nala is already installed.${NC}"
fi
# Check for pv
if ! command -v pv &> /dev/null; then
    echo -e "${YELLOW}✗ pv not found! Installing now...${NC}"
    nala update && nala install pv
    echo -e "${GREEN}✓ pv installed successfully!${NC}"
else
    echo -e "${GREEN}✓ pv is already installed.${NC}"
fi
# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

#screen clear
clear

# Welcome Banner
echo -e "
${GREEN}██████╗  █████╗ ███╗   ██╗██████╗  ██████╗ ███╗   ███╗
██╔══██╗██╔══██╗████╗  ██║██╔══██╗██╔═══██╗████╗ ████║
██████╔╝███████║██╔██╗ ██║██║  ██║██║   ██║██╔████╔██║
${ORANGE}██╔══██╗██╔══██║██║╚██╗██║██║  ██║██║   ██║██║╚██╔╝██║
██║  ██║██║  ██║██║ ╚████║██████╔╝╚██████╔╝██║ ╚═╝ ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝ ╚═╝     ╚═╝
${RED}${BOLD}========>> Created by Sunil [ Prince4you ] <<========= 
${RESET}"
echo -e "${CYAN}[+]configure your terminal with a custom banner!${RESET}"

# User Input for Customization
#echo -e "${GREEN} [ Customize Your Terminal ]${RESET}"
read -p "$(echo -e "${YELLOW}Enter creator name [default: Sunil]: ${RESET}")" creator_name
creator_name=${creator_name:-Sunil}
read -p "$(echo -e "${YELLOW}Enter creator tagline [default: Prince4You]: ${RESET}")" creator_tag
creator_tag=${creator_tag:-Prince4You}
read -p "$(echo -e "${YELLOW}Enter welcome message [default: Welcome to Your Terminal]: ${RESET}")" welcome_msg
welcome_msg=${welcome_msg:-Welcome to Your Terminal}
# Default speed
default_speed=50

# Function to validate speed
validate_speed() {
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}✘ Invalid input! Please enter numbers only.${RESET}"
        return 1
    elif [[ "$1" -lt 1 || "$1" -gt 200 ]]; then
        echo -e "${RED}✘ Speed must be between 1 and 200.${RESET}"
        return 1
    fi
    return 0
}

# Loop until valid input
while true; do
    read -p "$(echo -e "${YELLOW}Enter animation speed (1-200, where higher = faster) [Default: ${default_speed}]: ${RESET}")" speed
    speed=${speed:-$default_speed}

    validate_speed "$speed" && break
done

pv_speed=$speed

# Preview the speed
echo -e "${CYAN}Previewing animation speed at ${pv_speed} bytes/sec...${RESET}"
echo "      Loading animation test..." | pv -qL "$pv_speed"
sleep 1

# Confirm and finalize
echo -e "${GREEN}✓ Customization saved! Animation speed set to ${pv_speed} bytes/sec.${RESET}"

# Update and upgrade packages
echo -e "${GREEN}[1/6]${RESET} ${YELLOW}Updating and upgrading packages...${RESET}"
if nala update && nala upgrade; then
    echo -e "${GREEN}✓ Package update complete!${RESET}\n"
else
    echo -e "${RED}✗ Package update failed. Continuing anyway...${RESET}\n"
fi
sleep 1

# Install required packages
echo -e "${GREEN}[2/6]${RESET} ${YELLOW}Installing required packages...${RESET}"
if pkg install -y toilet starship fish python neofetch pv wget git nala; then
    echo -e "${GREEN}✓ Packages installed successfully!${RESET}\n"
else
    echo -e "${RED}✗ Package installation failed. Some features might not work.${RESET}\n"
fi
sleep 1

# Install lolcat
echo -e "${GREEN}[3/6]${RESET} ${YELLOW}Installing lolcat...${RESET}"
if ! command_exists pip; then
    if ! pkg install -y python-pip; then
        echo -e "${RED}✗ Failed to install python-pip. lolcat won't be installed.${RESET}\n"
    fi
fi

if command_exists pip; then
    if pip install lolcat; then
        echo -e "${GREEN}✓ lolcat installed successfully!${RESET}\n"
    else
        echo -e "${RED}✗ Failed to install lolcat.${RESET}\n"
    fi
fi
sleep 1

# Change shell to fish
echo -e "${GREEN}[4/6]${RESET} ${YELLOW}Changing default shell to fish...${RESET}"
if command_exists chsh; then
    if chsh -s fish; then
        echo -e "${GREEN}✓ Default shell changed to fish!${RESET}"
    else
        echo -e "${RED}✗ Failed to change shell to fish.${RESET}"
    fi
else
    echo -e "${RED}✗ chsh command not found. Shell not changed.${RESET}"
fi
echo ""
sleep 1

# Create fish config directory
mkdir -p ~/.config/fish || echo -e "${RED}✗ Failed to create fish config directory.${RESET}"

# Social Media Setup
echo -e "${GREEN}[5/6]${RESET} ${YELLOW}Social Media Setup${RESET}"
echo -e "${CYAN}Enter your social media links (leave blank to skip):${RESET}\n"

SOCIAL_FILE="$HOME/social_media.txt"
> "$SOCIAL_FILE"  # Clear old content

platforms=(
    "YouTube" "Instagram" "Facebook" "Telegram" "WhatsApp" 
    "Twitter/X" "GitHub" "LinkedIn" "Discord" "Reddit" "Mastodon"
)

for platform in "${platforms[@]}"; do
    read -p "$(echo -e "${YELLOW}$platform: ${RESET}")" url
    if [ -n "$url" ]; then
        echo "$platform:$url" >> "$SOCIAL_FILE"
    fi
done
echo -e "${GREEN}✓ Social media details saved to $SOCIAL_FILE${RESET}\n"
sleep 1

# Create the banner script
echo -e "${GREEN}[6/6]${RESET} ${YELLOW}Creating terminal banner...${RESET}"

cat > ~/termux_banner.sh << EOF
#!/bin/bash

# Function to generate random colors
random_color() {
    colors=(
        "\033[1;31m"  # Red
        "\033[1;32m"  # Green
        "\033[1;33m"  # Yellow
        "\033[1;34m"  # Blue
        "\033[1;36m"  # Cyan
        "\033[1;35m"  # Magenta
        "\033[1;37m"  # White
        "\033[1;38;5;129m"  # Purple
        "\033[1;38;5;208m"  # Orange
        "\033[1;38;5;198m"  # Pink
    )
    echo "\${colors[\$RANDOM % \${#colors[@]}]}"
}

# Define Reset and Bold
RESET="\033[0m"
BOLD="\033[1m"

# Distro list (expanded)
distros=(
    "debian" "AlmaLinux" "Elementary" "Linux Mint" "Solus" "RHEL" "Rocky" 
    "termux" "ubuntu" "parrot" "blackarch" "arch" "kali" "mint" "fedora" 
    "manjaro" "centos" "pop" "slackware" "backbox" "void" "garuda" 
    "gentoo" "deepin" "zorin" "mxlinux" "endeavouros" "opensuse" "arcolinux"
)

# Custom messages for each distro
declare -A messages
messages["debian"]="Debian: The universal and stable choice!"
messages["AlmaLinux"]="AlmaLinux: Enterprise-grade reliability."
messages["Elementary"]="Elementary OS: Beauty meets functionality."
messages["Linux Mint"]="Linux Mint: Simple, elegant, and user-friendly."
messages["Solus"]="Solus: Independent and innovative."
messages["RHEL"]="RHEL: Trusted by enterprises worldwide."
messages["Rocky"]="Rocky Linux: The CentOS successor."
messages["termux"]="Termux: Mobile hacking powerhouse."
messages["ubuntu"]="Ubuntu: Let's dive into the open-source world!"
messages["parrot"]="Parrot OS: Your security and privacy fortress."
messages["blackarch"]="BlackArch: For elite penetration testers."
messages["arch"]="Arch Linux: Build it your way."
messages["kali"]="Kali Linux: Unleash your inner hacker!"
messages["mint"]="Mint: The hassle-free Linux experience."
messages["fedora"]="Fedora: Cutting-edge and community-driven."
messages["manjaro"]="Manjaro: Arch made accessible and awesome."
messages["centos"]="CentOS: Rock-solid for servers."
messages["pop"]="Pop!_OS: Ubuntu with a modern twist."
messages["slackware"]="Slackware: The OG Linux distro."
messages["backbox"]="BackBox: Security testing made simple."
messages["void"]="Void Linux: Lightweight and independent."
messages["garuda"]="Garuda: Performance and style combined."
messages["gentoo"]="Gentoo: Customize every bit of your OS."
messages["deepin"]="Deepin: Stunning visuals, smooth experience."
messages["zorin"]="Zorin OS: Windows users' gateway to Linux."
messages["mxlinux"]="MX Linux: Lightweight and powerful."
messages["endeavouros"]="EndeavourOS: Arch with a friendly face."
messages["opensuse"]="openSUSE: Flexible and versatile."
messages["arcolinux"]="ArcoLinux: Learn, customize, conquer."

# Random distro selection
random_distro=\${distros[\$RANDOM % \${#distros[@]}]}

# Read social media details
declare -A social_media
if [ -f ~/social_media.txt ]; then
    while IFS=':' read -r platform link; do
        social_media["\$platform"]="\$link"
    done < ~/social_media.txt
fi

# Clear screen and show loading animation
clear
echo -e "\$(random_color)Loading Your Awesome Terminal...\$RESET" | pv -qL $pv_speed
sleep 0.5

# Show neofetch with random distro
if command -v neofetch >/dev/null 2>&1; then
    neofetch --ascii_distro "\$random_distro" --color_blocks off
else
    echo -e "\${YELLOW}Neofetch not found. Skipping system info display.\${RESET}"
fi

# Display Terminal Banner
echo -e "\n\$(random_color)${BOLD}$welcome_msg\$RESET" | pv -qL $pv_speed
echo -e "\$(random_color)Current Distro: \$random_distro\$RESET" | pv -qL $pv_speed
echo -e "\$(random_color)\${messages[\$random_distro]}\$RESET" | pv -qL $pv_speed

# Social Media Section with Colors
if [ \${#social_media[@]} -gt 0 ]; then
    echo -e "\n\$(random_color)Follow us for more updates:\$RESET" | pv -qL $pv_speed
    for platform in "\${!social_media[@]}"; do
        echo -e "\$(random_color)[+] \${platform}: \$RESET\${social_media[\$platform]}" | pv -qL $pv_speed
    done
fi

# Add "Created by"
echo -e "\n\$(random_color)Created By $creator_name [$creator_tag]\$RESET" | pv -qL $pv_speed

# Final progress bar
echo -e "\n\$(random_color)All systems loaded. Ready to rock! \$RESET" | pv -qL $pv_speed
EOF

chmod +x ~/termux_banner.sh || echo -e "${RED}✗ Failed to make termux_banner.sh executable.${RESET}"

# Create social media customization script
cat > ~/setup_social.sh << EOF
#!/bin/bash

# Colors
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "\n\${CYAN}Customize Your Social Media Links:\${RESET}"
echo -e "\${YELLOW}Press Enter to keep current value\${RESET}\n"

# Read current values
declare -A current_values
if [ -f ~/social_media.txt ]; then
    while IFS=':' read -r platform link; do
        current_values["\$platform"]="\$link"
    done < ~/social_media.txt
fi

# Get user input
platforms=(
    "YouTube" "Instagram" "Facebook" "Telegram" "WhatsApp" 
    "Twitter/X" "GitHub" "LinkedIn" "Discord" "Reddit" "Mastodon"
)

for platform in "\${platforms[@]}"; do
    read -p "\$(echo -e "\${YELLOW}Enter \$platform [\${current_values[\$platform]}]: \${RESET}")" input_link
    if [ -n "\$input_link" ]; then
        current_values["\$platform"]="\$input_link"
    fi
done

# Save to file
> ~/social_media.txt
for platform in "\${!current_values[@]}"; do
    echo "\$platform:\${current_values[\$platform]}" >> ~/social_media.txt
done

echo -e "\n\${GREEN}✓ Social media updated successfully!\${RESET}"
sleep 1
EOF

chmod +x ~/setup_social.sh || echo -e "${RED}✗ Failed to make setup_social.sh executable.${RESET}"

# Configure fish greeting
echo 'function fish_greeting; bash ~/termux_banner.sh; end' > ~/.config/fish/config.fish || echo -e "${RED}✗ Failed to configure fish greeting.${RESET}"

# Download and setup starship config
echo -e "\n${YELLOW}Downloading custom Starship configuration...${RESET}"
mkdir -p ~/.config || echo -e "${RED}✗ Failed to create .config directory.${RESET}"
if command_exists wget; then
    if wget https://raw.githubusercontent.com/prince4you/Term-Banner/main/starship.toml -O ~/.config/starship.toml; then
        echo -e "${GREEN}✓ Starship config downloaded!${RESET}"
    else
        echo -e "${RED}✗ Failed to download Starship config.${RESET}"
    fi
else
    echo -e "${RED}✗ wget not found. Starship config not downloaded.${RESET}"
fi

# Initialize starship
if command_exists starship; then
    echo 'starship init fish | source' >> ~/.config/fish/config.fish || echo -e "${RED}✗ Failed to add starship to fish config.${RESET}"
else
    echo -e "${RED}✗ starship not found. Not added to fish config.${RESET}"
fi

# Final message
echo -e "\n${GREEN}Installation complete!${RESET}"
echo -e "${CYAN}Please restart your terminal to see all changes.${RESET}"
echo -e "${BLUE}Enjoy your customized terminal experience!${RESET}"
