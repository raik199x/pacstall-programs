pkgname="obs-backgroundremoval-git"
gives="obs-backgroundremoval"
source=("https://github.com/royshil/obs-backgroundremoval.git")
pkgver="1.1.8"
makedepends=("libobs-dev" "libcurl4-openssl-dev" "libssl-dev" "qt6-base-dev" "libgl1-mesa-dev" "ninja-build" "cmake")
breaks=("${gives}")
replaces=("${gives}")
arch=('amd64')
pkgdesc="OBS plugin to replace the background in portrait images and video"
maintainer=("Zahrun <Zahrun@github.com>")
incompatible=('*:jammy' '*:focal' '*:bionic' '*:buster' '*:bullseye')

build() {
  cd "obs-backgroundremoval"
  cmake --preset linux-x86_64 -DCMAKE_INSTALL_PREFIX=/usr
  cmake --build build_x86_64 --parallel
}

package() {
  cd "obs-backgroundremoval"
  cmake --install build_x86_64 --prefix "${pkgdir}"/usr
  install -Dm644 LICENSE -t "${pkgdir}/usr/share/licenses/${pkgname}"
}
