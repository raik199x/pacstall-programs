pkgname="linux-headers-generic-deb"
gives="linux-headers-6.16.0-061600rc4-generic"
pkgver="6.16~rc4"
buildver="6.16.0-061600rc4.202506292136"
arch=('arm64' 'amd64')
sha256sums_arm64=("ef45529b713e2acd210354a31ec560338750facbc8cf41618259c4b597a73e0c")
sha256sums_amd64=("cd298802ff086eaf2dadaec519625989d6ce2baed427c6352a09193874e9795f")
source=("https://kernel.ubuntu.com/~kernel-ppa/mainline/v${pkgver/\~/-}/${CARCH}/${gives}_${buildver}_${CARCH}.deb")
pkgdesc="Ubuntu Linux mainline kernel (Generic headers)"
pacdeps=("linux-headers-deb")
maintainer=("Oren Klopfer <oren@taumoda.com>")
repology=("project: linux" "repo: aur" "srcname: linux-mainline" "binname: linux-mainline-headers")
