#!/usr/bin/env bash
# ------------------
#     libexiv2
# ------------------
# $Id: $
# Copyright (c) 2008, Ippei Ukai

# -------------------------------
# 20091206.0 sg Script NOT tested but uses std boilerplate
# 20100111.0 sg Script tested for building dylib
# 20100121.0 sg Script updated for 0.19
# 20100624.0 hvdw More robust error checking on compilation
# 20120414.0 hvdw update to 0.22
# 20121010.0 hvdw update to 0.23
# -------------------------------

env \
 PATH="$REPOSITORYDIR/bin:$PATH" \
 CC="$CC" CXX="$CXX" \
 CFLAGS="-isysroot $MACSDKDIR -I$REPOSITORYDIR/include $ARGS -O3" \
 CXXFLAGS="-isysroot $MACSDKDIR -I$REPOSITORYDIR/include $ARGS -O3" \
 CPPFLAGS="-I$REPOSITORYDIR/include" \
 LDFLAGS="-L$REPOSITORYDIR/lib $LDARGS -prebind -stdlib=libc++ -lc++" \
 PKG_CONFIG_PATH="$REPOSITORYDIR/lib/pkgconfig" \
 NEXT_ROOT="$MACSDKDIR" \
 cmake -DCMAKE_INSTALL_PREFIX="$REPOSITORYDIR" -DCMAKE_OSX_SYSROOT="macosx${SDKVERSION}" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="$DEPLOY_TARGET" \
  -DEXIV2_ENABLE_LENSDATA=OFF -DEXIV2_BUILD_EXIV2_COMMAND=OFF -DEXIV2_BUILD_SAMPLES=OFF . \
  || fail "cmake step";

make $MAKEARGS || fail "make step of $ARCH";
make install || fail "make install step of $ARCH";

install_name_tool -id "$REPOSITORYDIR/lib/libexiv2."??".dylib" "$REPOSITORYDIR/lib/libexiv2."??".dylib"