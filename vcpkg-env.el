(require 'cl-lib)
(require 'yekneb-env)
(require 'yekneb-debug)
(require 'yekneb-path-manip)

(defconst vcpkg--32-bit-system-p (not (null (string-match "^i386-.*" system-configuration)))
  "t if a 32-bit verision of Emacs is in use. nil otherwise.")
(defconst vcpkg--64-bit-system-p (not (null (string-match "^x86_64-.*" system-configuration)))
  "t if a 64-bit verision of Emacs is in use. nil otherwise.")

(defconst vcpkg--add-to-path
  '(
    "${VCPKG_ROOT}/installed/${Platform}-windows/share/clang"
    "${VCPKG_ROOT}/downloads/tools/7zip-18.1.0-windows/7-Zip.CommandLine.18.1.0/tools"
    "${VCPKG_ROOT}/downloads/tools/cmake-3.20.2-windows/cmake-3.20.2-windows-i386/bin"
    "${VCPKG_ROOT}/downloads/tools/gn/qUkAhy9J0P7c5racy-9wB6AHNK_btS18im8S06_ehhwC"
    "${VCPKG_ROOT}/downloads/tools/gperf/bin"
    "${VCPKG_ROOT}/downloads/tools/jom/jom-1.1.3"
    "${VCPKG_ROOT}/downloads/tools/nasm/nasm-2.15.05"
    "${VCPKG_ROOT}/downloads/tools/nasm/nasm-2.15.05/rdoff"
    "${VCPKG_ROOT}/downloads/tools/ninja/1.10.1-windows"
    "${VCPKG_ROOT}/downloads/tools/nuget-5.5.1-windows"
    "${VCPKG_ROOT}/downloads/tools/perl/5.30.0.1/c/bin"
    "${VCPKG_ROOT}/downloads/tools/perl/5.30.0.1/c/i686-w64-mingw32/bin"
    "${VCPKG_ROOT}/downloads/tools/perl/5.30.0.1/perl/site/bin"
    "${VCPKG_ROOT}/downloads/tools/perl/5.30.0.1/perl/bin"
    "${VCPKG_ROOT}/downloads/tools/python/python-3.9.5-${Platform}"
    "${VCPKG_ROOT}/downloads/tools/winflexbison/0a14154bff-a8cf65db07"
    "${VCPKG_ROOT}/installed/${Platform}-windows/bin"
    "${VCPKG_ROOT}/installed/${Platform}-windows/tools"
    "${ProgramFiles(x86)}/Poedit"
    "${ProgramFiles(x86)}/Poedit/GettextTools/bin"
   )
  "Directories to add to the path for x86."
 )

(let
  (
   (yekneb-debug-level yekneb-log-entry)
   (platform nil)
   (dic-path "${VCPKG_ROOT}/installed/${Platform}-windows/share/hunspell/dictionaries")
   (tools-dir "${VCPKG_ROOT}/installed/${Platform}-windows/tools")
   (tool-dirs nil)
   )
  (setq
   platform
   (cond
    (vcpkg--32-bit-system-p
     "x86"
     )
    (vcpkg--64-bit-system-p
     "x64"
     )
    (t
     nil)
    )
   )
  (when platform
    (yekneb-log yekneb-log-info "Setting Platform to '%s'." platform)
    (yekneb-setenv "Platform" platform)
    )
  (setq tools-dir (substitute-env-vars tools-dir))
  (yekneb-log yekneb-log-info "tools-dir is '%s'." tools-dir)
  (setq dic-path (substitute-env-vars dic-path))
  (when (file-directory-p dic-path)
    (yekneb-log yekneb-log-info "Setting DICPATH to '%s'." dic-path)
    (yekneb-setenv "DICPATH" dic-path)
    )
  (yekneb-log yekneb-log-info "Adding the directories in vcpkg--add-to-path to the path.")
  (yekneb-add-dirs-to-path vcpkg--add-to-path t t)
  (yekneb-log yekneb-log-info "Adding the directories in tool-dirs to the path.")
  (setq tool-dirs (directory-files tools-dir))
  (dolist (tool-dir tool-dirs)
    (when (and (not (string= tool-dir ".")) (not (string= tool-dir "..")))
      (setq tool-dir (expand-file-name tool-dir tools-dir))
      (when (file-directory-p tool-dir)
        (yekneb-add-to-path tool-dir t)
        )
      )
    )
  )
