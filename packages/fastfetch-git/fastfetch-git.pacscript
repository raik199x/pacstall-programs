#  __      __________   ______
# /  \    /  \_____  \ /  __  \
# \   \/\/   //  ____/ >      <
#  \        //       \/   --   \
#   \__/\  / \_______ \______  /
#        \/          \/      \/
maintainer=("wizard-28 <wiz28@pm.me>")

pkgname="fastfetch-git"
gives="fastfetch"
pkgdesc="Like neofetch, but much faster because written in c"
source=("https://github.com/LinusDierheimer/fastfetch.git")
arch=("any")
pkgver="2.33.0"
repology=("project: ${gives}")
makedepends=("libvulkan-dev" "libwayland-dev" "libxrandr-dev" "libxcb-randr0-dev" "libdconf-dev" "libdbus-1-dev" "libmagickcore-dev" "libxfconf-0-dev" "libsqlite3-dev" "librpm-dev" "libegl-dev" "libglx-dev" "libosmesa6-dev" "ocl-icd-opencl-dev" "libpulse-dev" "libdrm-dev" "libddcutil-dev" "libchafa-dev" "directx-headers-dev" "pkgconf" "cmake>=3.12")
optdepends=("libvulkan1: Vulkan module and GPU fallback"
  "libegl1: OpenGL module"
  "libxcb-randr0: Resolution and refresh rate support for X11 sessions"
  "libwayland-client0: Resolution and refresh rate support for wayland sessions"
  "libglib2.0-0: Output for values that are only stored in GSettings"
  "libdconf1: Output for values that are only stored in DConf"
  "libxfconf-0-3: XFWM theme + xfce-terminal font"
  "libnm0: Used for Wifi detection"
  "libpulse0: Used for Sound device detection"
  "libddcutil-dev: Used for brightness detection for external displays"
  "libdbus-1-3: Used for bluetooth, Player & Media detection"
  "kitty: Terminal emulator GPU accelerated and display images"
)
breaks=("${gives}" "${gives}-bin" "${gives}-deb" "${gives}-app")

build() {
  cd "fastfetch"
  # Build fastfetch
  mkdir -p build/
  (
    cd build/ || return 2
    cmake ..
    cmake --build . --target fastfetch --target flashfetch -j "${NCPU}"
  )
}

package() {
  cd "fastfetch"
  # Install license
  install -Dm644 "LICENSE" -t "${pkgdir}/usr/share/licenses/${gives}"

  # Install doc
  install -Dm644 "README.md" -t "${pkgdir}/usr/share/doc/${gives}"

  # Install fastfetch and flashfetch binary
  install -Dm755 "build/fastfetch" "build/flashfetch" -t "${pkgdir}/usr/bin"

  # Install bash completions
  install -Dm644 "completions/bash" "${pkgdir}/usr/share/bash-completion/completions/${gives}"

  # Install presets
  mkdir -p "${pkgdir}/usr/share/${gives}/presets"
  cp -r presets/* "${pkgdir}/usr/share/${gives}/presets"
}

post_remove() {
  # Remove left over directories
  if ask "Do you want to remove the configuration files?" Y; then
    rm -rf "${homedir}/.config/fastfetch"
  fi
  if ask "Do you want to remove the left over cache?" Y; then
    rm -rf "${homedir}/.cache/fastfetch"
  fi
}
# vim:set ft=sh ts=2 sw=2 et:
