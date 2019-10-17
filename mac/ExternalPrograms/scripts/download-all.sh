#!/usr/bin/env bash

pre="<<<<<<<<<<<<<<<<<<<<"
pst=">>>>>>>>>>>>>>>>>>>>"

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR" || exit 1
source SetEnv.sh

download(){
    name=$1
    url=$2
    out=$3
    echo "$pre Downloading $name $pst"
    if [[ -n $out ]]; then
        curl -L -o "$out" "$url"
    else
        curl -L -O "$url"
    fi
    if [[ $? != 0 ]]; then
        echo "++++++ Download of $name failed"
        exit 1
    fi
}


cd "$REPOSITORYDIR"

rm -rf _build
mkdir -p _src && cd _src


download "boost"     "https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz"
download "exiv2"     "http://www.exiv2.org/builds/exiv2-0.27.0a-Source.tar.gz"
download "fftw"      "http://www.fftw.org/fftw-3.3.8.tar.gz"
download "gettext"   "https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz"
download "glew"      "https://sourceforge.net/projects/glew/files/glew/2.1.0/glew-2.1.0.zip/download"                       "glew-2.1.0.tgz"
download "glib"      "https://ftp.gnome.org/pub/gnome/sources/glib/2.59/glib-2.59.0.tar.xz"
download "gsl"       "http://ftpmirror.gnu.org/gsl/gsl-2.5.tar.gz"
download "ilmbase"   "https://github.com/openexr/openexr/releases/download/v2.3.0/ilmbase-2.3.0.tar.gz"
download "openexr"   "https://github.com/openexr/openexr/releases/download/v2.3.0/openexr-2.3.0.tar.gz"
download "exiftool"  "http://owl.phy.queensu.ca/~phil/exiftool/Image-ExifTool-11.26.tar.gz"
download "jpeg"      "http://www.ijg.org/files/jpegsrc.v9c.tar.gz"
download "lcms2"     "https://sourceforge.net/projects/lcms/files/lcms/2.9/lcms2-2.9.tar.gz/download"                       "lcms2-2.9.tar.gz"
download "libffi"    "ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz"
download "libomp"    "https://www.openmprtl.org/sites/default/files/libomp_20160808_oss.tgz"
download "libpano13" "https://sourceforge.net/projects/panotools/files/libpano13/libpano13-2.9.19/libpano13-2.9.19.tar.gz/download" "libpano13-2.9.19.tar.gz"
download "libpng"    "https://download.sourceforge.net/libpng/libpng-1.6.36.tar.gz"                                          "libpng-1.6.36.tar.gz"
download "tiff"      "http://download.osgeo.org/libtiff/tiff-4.0.10.tar.gz"
download "vigra"     "https://github.com/ukoethe/vigra/releases/download/Version-1-11-1/vigra-1.11.1-src.tar.gz"
download "wxWidgets" "https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.2/wxWidgets-3.1.2.tar.bz2"

cd ..

echo "$pre Downloading enblend-enfuse $pst"
hg clone http://hg.code.sf.net/p/enblend/code enblend-enfuse -r stable-4_2

for f in _src/*; do
    echo "Extracting $f"
    tar xf "$f";
done