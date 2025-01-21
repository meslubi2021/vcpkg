@echo off
.\vcpkg.exe install --triplet x64-windows --binarysource=clear glew glfw3 eigen3 proj libgeotiff clfft boost opencl pcl liblas[zlib,jpeg] cuda ffmpeg[opencl,nvcodec,webp,zlib,vorbis,lzma,openh264] openimageio[gif,libraw] cryptopp libzippp wxwidgets[webview,example] libtess2 gdal[core,zstd,webp,sqlite3,recommended-features,png,pcre2,openssl,openjpeg,lzma,libxml2,libspatialite,libkml,lerc,jpeg,iconv,hdf5,gif,expat,default-features,curl] pdal[liblzma,supported-plugins,zstd] tinyxml2

