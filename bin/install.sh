#!/bin/sh

mkdir -pm 0700 \
    "${XDG_CACHE_HOME:-"$HOME/.cache"}" \
    "${XDG_CONFIG_HOME:-"$HOME/.config"}" \
    "${XDG_DATA_HOME:-"$HOME/.local/share"}" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}/mpd" \
    "${XDG_STATE_HOME:-"$HOME/.local/state"}/vim"

dotfiles="${XDG_DATA_HOME:-"$HOME/.local/share"}/dotfiles"

mkdir -pm 0700 "$dotfiles" \
    && git clone --bare "https://github.com/oersen/dotfiles.git" "$dotfiles" \
    && git --git-dir="$dotfiles" --work-tree="$HOME" checkout -f master

case "$SHELL" in
    *"termux"* )
        pkg upgrade
        apt autoremove

        pkg install \
            bash-completion exiv2 fzf git jq man ncurses-utils vim \
            cmatrix cowsay figlet fortune neofetch nyancat sl \
            curl dnsutils iproute2 nmap openssh openssl-tool whois

        exit
        ;;
esac

on="$(tput setaf 2)"
off="$(tput sgr0)"

pretty_print() {
    printf "%s[%s]%s\n" "$on" "$*" "$off"
}

pretty_print "add 'rpm fusion' repositories"
sudo dnf install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

pretty_print "install necessary packages"
sudo dnf install \
    @c-development \
    @libreoffice \
    @networkmanager-submodules \
    @printing \
    abook \
    android-tools \
    aria2 \
    asciiquarium \
    atool \
    avahi-tools \
    awesome-vim-colorschemes \
    bash-completion \
    bind-utils \
    blueman \
    boxes \
    brightnessctl \
    bsd-games \
    calcurse \
    cifs-utils \
    cmatrix \
    cowsay \
    dbus-tools \
    default-fonts \
    dnscrypt-proxy \
    espeak-ng \
    ethtool \
    exfatprogs \
    ffmpeg \
    figlet \
    firefox \
    foot \
    fortune-mod \
    fzf \
    galculator \
    git \
    gnome-themes-extra \
    grimshot \
    gvfs-mtp \
    gvfs-smb \
    highlight \
    igt-gpu-tools \
    ImageMagick \
    imv \
    irssi \
    isync \
    iwlwifi-dvm-firmware \
    jq \
    libsixel-utils \
    libva-intel-driver \
    libva-utils \
    lolcat \
    lshw \
    lsof \
    lynx \
    mako \
    man-pages \
    mesa-dri-drivers \
    microcode_ctl \
    mozilla-ublock-origin \
    mpc \
    mpd \
    mpv \
    msmtp \
    mtr \
    mutt \
    ncdu \
    ncmpcpp \
    network-manager-applet \
    NetworkManager-openconnect-gnome \
    NetworkManager-openvpn-gnome \
    NetworkManager-tui \
    newsboat \
    nicotine+ \
    nmap \
    notmuch-mutt \
    nyancat \
    pandoc \
    papirus-icon-theme-dark \
    parallel \
    pass \
    pavucontrol \
    pciutils \
    pcmanfm \
    perl \
    perl\(Image::ExifTool\) \
    perl\(Perl::Critic\) \
    perl\(Perl::Tidy\) \
    pinentry-gnome3 \
    pipewire-pulseaudio \
    playerctl \
    plocate \
    podman \
    polkit-gnome \
    pv \
    qgnomeplatform-qt5 \
    qgnomeplatform-qt6 \
    ranger \
    rng-tools \
    rsync \
    screen \
    ShellCheck \
    simple-scan \
    sl \
    smartmontools \
    swappy \
    sway \
    swayidle \
    swaylock \
    symlinks \
    tcpdump \
    thunderbird \
    tmux \
    torbrowser-launcher \
    translate-shell \
    transmission-daemon \
    tuned-gtk \
    udiskie \
    unrar \
    urlview \
    usbutils \
    util-linux \
    vim-enhanced \
    vim-perl-support \
    vim-X11 \
    waybar \
    wdisplays \
    wev \
    wf-recorder \
    whois \
    wl-clipboard \
    wlr-randr \
    wlsunset \
    wofi \
    words \
    wshowkeys \
    xarchiver \
    youtube-dl \
    zathura-pdf-mupdf \
    zip

pretty_print "upgrade all packages"
sudo dnf upgrade
sudo dnf autoremove

pretty_print "disable services"
sudo systemctl disable --now ModemManager.service sshd.service
