#!/bin/bash -e
# NELplayer: 애니메이션 WebP 녹화용(FFmpeg libwebp_anim 인코더). BSD 라이선스, 정적 링크.

. ../../include/depinfo.sh
. ../../include/path.sh

build=_build$ndk_suffix

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf $build
	exit 0
else
	exit 255
fi

mkdir -p $build
cd $build

../configure \
	--host=$ndk_triple --with-pic \
	--enable-static --disable-shared \
	--enable-libwebpmux --enable-libwebpdemux \
	--disable-gl --disable-sdl --disable-png --disable-jpeg --disable-tiff --disable-gif --disable-wic

make -j$cores
make DESTDIR="$prefix_dir" install

# 정적 링크라 FFmpeg configure 의 링크 시험에 libsharpyuv·libm 이 필요하다(libwebp.pc 는 Requires.private 에만 적혀 있음)
sed -i 's/^Libs: \(.*\)$/Libs: \1 -lsharpyuv -lm/' "$prefix_dir/lib/pkgconfig/libwebp.pc"
cat "$prefix_dir/lib/pkgconfig/libwebp.pc" "$prefix_dir/lib/pkgconfig/libwebpmux.pc"
