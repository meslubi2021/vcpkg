(require 'cl-lib)
(require 'yekneb-env nil t)
(require 'yekneb-path-manip nil t)

(defun vcpkg--setenv (var value &optional substitute-env-vars)
  (setenv var value substitute-env-vars)
  (yekneb-setenv-in-compilation-environment var value substitute-env-vars)
  )

(defconst vcpkg--32-bit-system-p (not (null (string-match "^i386-.*" system-configuration)))
  "t if a 32-bit verision of Emacs is in use. nil otherwise.")
(defconst vcpkg--64-bit-system-p (not (null (string-match "^x86_64-.*" system-configuration)))
  "t if a 64-bit verision of Emacs is in use. nil otherwise.")

(defconst vcpkg--add-to-path-x64
  '(
    "${VCPKG_ROOT}/installed/${Platform}-windows/share/clang"
    "${VCPKG_ROOT}/downloads/tools/7zip-18.1.0-windows/7-Zip.CommandLine.18.1.0/tools"
    "${VCPKG_ROOT}/downloads/tools/cmake-3.19.2-windows/cmake-3.19.2-win32-x86/bin"
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
    "${VCPKG_ROOT}/downloads/tools/python/python-3.9.2-${Platform}"
    "${VCPKG_ROOT}/downloads/tools/winflexbison/0a14154bff-a8cf65db07"
    "${VCPKG_ROOT}/installed/x64-windows/bin"
    "${VCPKG_ROOT}/installed/x64-windows/tools"
    "${ProgramFiles(x86)}/Poedit"
    "${ProgramFiles(x86)}/Poedit/GettextTools/bin"
   )
  "Directories to add to the path for x86."
 )

(let
  (
   (add-to-path nil) (load-file-dir (file-name-directory load-file-name))
   (dic-path "${VCPKG_ROOT}/installed/${Platform}-windows/share/hunspell/dictionaries")
   (tool-dirs (directory-files (substitute-env-vars "${VCPKG_ROOT}/installed/x64-windows/tools")))
   )
  (setq
   add-to-path
   (cond
    (vcpkg--32-bit-system-p
     vcpkg--add-to-path-x86)
    (vcpkg--64-bit-system-p
     vcpkg--add-to-path-x64
     )
    (t
     nil)
    )
   )
  (cond
   (vcpkg--32-bit-system-p
    (vcpkg--setenv "Platform" "x86")
    )
   (vcpkg--64-bit-system-p
    (vcpkg--setenv "Platform" "x64")
    )
   )
  (when (file-directory-p (substitute-env-vars dic-path))
    (vcpkg--setenv "DICPATH" (substitute-env-vars dic-path))
    )
  (when add-to-path
    (yekneb-add-dirs-to-path add-to-path t t)
    )
  (dolist (tool-dir tool-dirs)
    (when (and (not (string= tool-dir ".")) (not (string= tool-dir ".")))
      (setq tool-dir (expand-file-name tool-dir (substitute-env-vars "${VCPKG_ROOT}/installed/x64-windows/tools")))
      (when (file-directory-p tool-dir)
        (yekneb-add-to-path tool-dir t)
        )
      )
    )
  )
