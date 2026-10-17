# NELplayer 용 libmpv 빌드

[jarnedemeulemeester/libmpv-android](https://github.com/jarnedemeulemeester/libmpv-android)(MIT, `LICENSE`)의 빌드 스크립트를 NELplayer 안드로이드판에 맞게 바꾼 저장소다.
GitHub Actions(`Build libmpv-android`)가 arm64 용 `libmpv-release.aar` 를 만든다.

## 원본과 다른 점

| 항목 | 원본 | 여기 | 이유 |
|---|---|---|---|
| FFmpeg 라이선스 | `--enable-gpl --enable-version3` (GPLv3) | `--enable-version3` (LGPLv3) | 비공개 앱에 동적 링크로 넣기 위해 |
| mpv 라이선스 | 기본(`gpl=true`) | `-Dgpl=false` (LGPL) | 같은 이유 |
| FFmpeg 출력 형식 | 모두 끔 | mp4, mov, matroska, webm, gif, webp, image2 | 구간 녹화 |
| FFmpeg 인코더 | 모두 끔 | h264/hevc_mediacodec(하드웨어), aac, gif, libwebp_anim, libwebp, png, mjpeg | 구간 녹화. x264 는 GPL 이라 넣지 않는다 |
| FFmpeg 필터 | 모두 끔 | palettegen, paletteuse, split, scale, fps, format 등 | GIF 팔레트, 해상도·프레임 조절 |
| libwebp | 없음 | 1.6.0 (BSD, 정적) | 애니메이션 WebP |
| 아키텍처 | armv7l, arm64, x86, x86_64 | arm64 | CI 시간. 필요하면 `build.sh` 의 `archs` 에 추가 |

배포할 때: LGPL 고지(mpv, FFmpeg, libplacebo, libass 등 각 라이선스)와 이 저장소의 빌드 스크립트·소스 위치를 앱 안 "오픈소스 라이선스" 화면에 적는다.

## 소스 제공 (LGPL) / Source offer

NELplayer 안드로이드판에 들어간 libmpv·FFmpeg 등 LGPL 라이브러리는 이 저장소의 빌드 스크립트로 만든다.
스크립트는 `buildscripts/include/depinfo.sh` 에 적힌 버전의 공식 소스(git 태그·릴리스 파일)를 받아 빌드한다.

The LGPL libraries (mpv, FFmpeg, libplacebo, FriBidi …) shipped in the NELplayer Android app are built from the
upstream sources pinned in `buildscripts/include/depinfo.sh`, using the scripts and options in this repository.

| 앱 버전 | 이 저장소 커밋 | Actions 실행 |
|---|---|---|
| 0.1.0 (첫 시험판) | b2b567a | 39039297881 |
