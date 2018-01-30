;;; init.el --- Where all the magic begins
;;

;;; Commentary:
;;
;; This is a starter kit for scimax. This package provides a
;; customized setup for emacs that we use daily for scientific
;; programming and publication.
;;

;;; Code:
;; this makes garbage collection less frequent, which speeds up init by about 2 seconds.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq gc-cons-threshold 80000000)

(when (version< emacs-version "25.0")
  (warn "You probably need at least Emacs 25. You should upgrade. You may need to install leuven-theme manually."))

;; remember this directory
(defconst scimax-dir (file-name-directory (or load-file-name (buffer-file-name)))
  "Directory where the scimax is installed.")

(defvar scimax-user-dir (expand-file-name "user" scimax-dir)
  "User directory for personal code.")

(setq user-emacs-directory scimax-user-dir)

(setq package-user-dir (expand-file-name "elpa"  scimax-dir))

;; we load the user/preload.el file if it exists. This lets users define
;; variables that might affect packages when they are loaded, e.g. key-bindings,
;; etc... setup autoupdate, .

(let ((preload (expand-file-name "user/preload.el" scimax-dir)))
  (when (file-exists-p preload)
    (load preload)))

(defvar scimax-load-user-dir t
  "Controls if the user directory is loaded.")

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)

(add-to-list
 'package-archives
 '("org"         . "http://orgmode.org/elpa/")
 t)

(add-to-list 'load-path scimax-dir)
(add-to-list 'load-path scimax-user-dir)

(let ((default-directory scimax-dir))
  (shell-command "git submodule update --init"))

(set-language-environment "UTF-8")

(require 'bootstrap)
(require 'packages)

;; it appears this help library is not loaded fully in the emacs-win
;; directory. See issue #119. This appears to fix that.
(when (file-directory-p (expand-file-name "emacs-win" scimax-dir))
  (load-library "help"))

(provide 'init)

;;; init.el ends here
