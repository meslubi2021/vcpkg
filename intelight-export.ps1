# Rename the vcpkg exported folder to just vcpkg (without the timestamp)
# add a installed/version.txt containing the single version number <ver>
# Right click the "installed" and "scripts" and ".vcpkg_root" and use 7-zip to add to vcpkg.zip.
# rename vcpkg.zip to vcpkg-<ver>.zip and upload to Amazon S3 /intelight/vcpkg

.\vcpkg.exe export --x-all-installed --raw