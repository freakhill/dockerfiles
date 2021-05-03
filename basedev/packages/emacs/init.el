;;; -*- coding: utf-8-unix -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "f0b0710b7e1260ead8f7808b3ee13c3bb38d45564e369cbe15fc6d312f0cd7a0" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "b71d5d49d0b9611c0afce5c6237aacab4f1775b74e513d8ba36ab67dfab35e5a" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "cdc7555f0b34ed32eb510be295b6b967526dd8060e5d04ff0dce719af789f8e5" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(global-ede-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (projectile-ripgrep company-restclient dap-mode ansi hide-mode-line lsp-rust package-build shut-up epl git commander f dash s)))
 '(safe-local-variable-values
   (quote
    ((cider-known-endpoints
      ("verda-vm" "jojo-work-from-home001-gcld-jp2v-prod.lineinfra.com" "9998")
      ("dockerhost" "host.docker.internal" "9998"))
     (c-basic-indent . 4))))
 '(semantic-mode t)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "Green"))))
 '(diff-removed ((t (:foreground "Red"))))
 '(ediff-even-diff-A ((((class color) (background dark)) (:background "dark green"))))
 '(ediff-even-diff-B ((((class color) (background dark)) (:background "dark red"))))
 '(ediff-odd-diff-A ((((class color) (background dark)) (:background "dark green"))))
 '(ediff-odd-diff-B ((((class color) (background dark)) (:background "dark red"))))
 '(mumamo-background-chunk-major ((((class color) (background dark)) (:background "black"))) t)
 '(mumamo-background-chunk-submode1 ((((class color) (background dark)) (:background "black"))) t)
 '(shm-current-face ((t (:background "green" :foreground "black"))) t)
 '(shm-quarantine-face ((t (:background "yellow"))) t))

;;--------------------
;;--- for emacs 24+ --
;;--------------------

(defun my-ensure-dir (d)
  (unless (file-exists-p d)
    (make-directory d)))

(defvar my-save-dir  "~/.emacs.d/save")
(defvar my-temp-dir  "~/.emacs.d/tmp")
(defvar my-irony-dir "~/.emacs.d/irony")

(defun my-ensure-save-dir ()
  (my-ensure-dir my-save-dir))

(defun my-ensure-irony-dir ()
  (my-ensure-dir my-irony-dir))

(defun my-ensure-temp-dir ()
  (my-ensure-dir my-temp-dir))

(defun my-basic-init ()
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (setq inhibit-startup-message t)
  (setq inhibit-startup-echo-area-message t)
  (put 'narrow-to-region 'disabled nil)

  (blink-cursor-mode -1)

  (setq scroll-margin 0
        scroll-conservatively 100000
        scroll-preserve-screen-position 1)

  (defalias 'yes-or-no-p 'y-or-n-p)
  (show-paren-mode t)
  (semantic-mode t)

  (setq large-file-warning-threshold 100000000)
  (defconst backup-dir "~/.backups")
  (my-ensure-dir backup-dir)

  (setq backup-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t)))

  (setq
   make-backup-files t
   backup-by-copying t
   version-control t
   delete-old-versions t
   kept-old-versions 6
   kept-new-versions 9
   auto-save-default t
   auto-save-timeout 20
   auto-save-interval 200)

  (setq
   dired-recursive-copies 'always
   dired-recursive-deletes 'top
   dired-listing-switches "-lha")

  (add-hook 'dired-mode-hook #'auto-revert-mode)

  (setq c-basic-indent 2)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (global-set-key (kbd "C-l") 'goto-line)

  (define-key global-map (kbd "RET") 'reindent-then-newline-and-indent)

  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*")

  (setq initial-major-mode 'lisp-interaction-mode
        redisplay-dont-pause t
        column-number-mode t
        echo-keystrokes 0.02
        inhibit-startup-message t
        transient-mark-mode t
        shift-select-mode nil
        require-final-newline t
        truncate-partial-width-windows nil
        delete-by-moving-to-trash nil
        confirm-nonexistent-file-or-buffer nil
        query-replace-highlight t
        next-error-highlight t
        next-error-highlight-no-select t)
  ;;set all coding systems to utf-8-unix
  (prefer-coding-system 'utf-8)
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8)
  (set-language-environment 'UTF-8) ; prefer utf-8 for language settings
  (setq locale-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
  (prefer-coding-system       'utf-8)
  (setq buffer-file-coding-system 'utf-8-unix)
  (setq default-file-name-coding-system 'utf-8-unix)
  (setq default-keyboard-coding-system 'utf-8-unix)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq default-sendmail-coding-system 'utf-8-unix)
  (setq default-terminal-coding-system 'utf-8-unix)

  (set-default 'indent-tabs-mode nil)
  (auto-compression-mode t)
  (show-paren-mode 1)

  ;; make emacs use the clipboard
  (setq x-select-enable-clipboard t)
  ;;remove all trailing whitespace and trailing blank lines before
  ;;saving the file
  (defvar live-ignore-whitespace-modes '(markdown-mode))
  (defun live-cleanup-whitespace ()
    (if (not (member major-mode live-ignore-whitespace-modes))
        (let ((whitespace-style '(trailing empty)) )
          (whitespace-cleanup))))
  (add-hook 'before-save-hook #'live-cleanup-whitespace)
  ;; savehist keeps track of some history
  (setq savehist-additional-variables
        ;; search entries
        '(search ring regexp-search-ring)
        ;; save every minute
        savehist-autosave-interval 60
        ;; keep the home clean
        savehist-file (concat my-temp-dir "savehist"))
  (savehist-mode t)

  (require 'midnight)
  (midnight-delay-set 'midnight-delay "4:30am")
  (require 'saveplace)
  (setq-default save-place t)

  ;; recompile binding
  (global-set-key (kbd "<f8>") #'recompile)

  ;; C-x r j i -- to edit my init file
  ;; C-x r j c -- to edit my cask file
  (setq user-cask-init-file
        (expand-file-name "Cask" (file-name-directory user-init-file)))
  (set-register ?c `(file . ,user-cask-init-file))
  (set-register ?i `(file . ,user-init-file)))

(defun my-load-extra-files ()
  (let
      ((dl-dir              "~/.emacs.d/dl")
       (ac-dict-dir         "~/.emacs.d/ac-dict")
       (dl-and-load         (lambda (dir url filename &optional module-name)
                              (let ((filename (concat dir "/" filename))
                                    (message (concat "loat extra file: " filename)))
                                (unless (file-exists-p filename)
                                  (url-copy-file url filename))
                                (when module-name
                                  (if (symbolp module-name)
                                      (require module-name)
                                    (load module-name))))))
       (dl-and-load-mode    (lambda (&rest r) (apply dl-and-load (cons dl-dir r))))
       (dl-and-load-ac-dict (lambda (&rest r) (apply dl-and-load (cons ac-dict-dir r)))))
    (my-ensure-dir dl-dir)
    (my-ensure-dir ac-dict-dir)
    (add-to-list 'load-path dl-dir)
    (-each ;; packages
        '(
          ("https://raw.githubusercontent.com/buzztaiki/auto-complete/master/ac-company.el"
           "ac-company.el"
           ac-company)
          ("https://raw.githubusercontent.com/sandstorm-io/capnproto/master/highlighting/emacs/capnp-mode.el"
           "capnp-mode.el"
           capnp-mode))
      (lambda (pkg)
        (condition-case e
            (apply dl-and-load-mode pkg)
          ((debug error) e))))
    (-each ;; ac-dict dictionaries
        '(("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/c-mode"
           "c-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/caml-mode"
           "caml-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/clojure-mode"
           "clojure-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/clojurescript-mode"
           "clojurescript-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/css-mode"
           "css-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/go-mode"
           "go-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/haskell-mode"
           "haskell-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/java-mode"
           "java-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/javascript-mode"
           "javascript-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/python-mode"
           "python-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/lua-mode"
           "lua-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/ruby-mode"
           "ruby-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/sh-mode"
           "sh-mode")
          ("https://raw.githubusercontent.com/overtone/emacs-live/master/packs/stable/clojure-pack/lib/auto-complete/dict/tuareg-mode"
           "tuareg-mode"))
      (lambda (dict) (condition-case e
                         (apply dl-and-load-ac-dict dict)
                       ((debug-error) e))))))

(defun my-discover-my-major ()
  (define-key 'help-command (kbd "C-m") 'discover-my-major))

(defun my-buffer-move ()
  (global-set-key (kbd "C-c <up>") 'buf-move-up)
  (global-set-key (kbd "C-c <down>") 'buf-move-down)
  (global-set-key (kbd "C-c <left>") 'buf-move-left)
  (global-set-key (kbd "C-c <right>") 'buf-move-right))

(defun my-evil ()
  ;; C-z switches between modes (states in evil parlance)
  (setq evil-mode-line-format 'before)

  (setq evil-emacs-state-cursor    '("red" box))
  (setq evil-motion-state-cursor   '("orange" box))
  (setq evil-normal-state-cursor   '("green" box))
  (setq evil-visual-state-cursor   '("orange" box))
  (setq evil-insert-state-cursor   '("red" bar))
  (setq evil-replace-state-cursor  '("red" bar))
  (setq evil-operator-state-cursor '("red" hollow))

  (evil-mode 1)

  (evil-define-key 'normal global-map "," 'evil-execute-in-god-state)
  (evil-define-key 'normal global-map (kbd "m") 'evil-set-marker)
  (evil-define-key 'normal global-map (kbd "M") 'evil-goto-mark))

(defun my-evil-numbers ()
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt))

(defun my-evil-surround ()
  (require 'evil-surround)
  (global-evil-surround-mode 1))

(defun my-evil-mc ()
  ;; "gru" remove all cursors
  ;; C-n C-p add cursor
  ;; M-n M-p cycle thorugh cursor
  ;; C-t skip cursor
  ;;(require 'evil-mc)
  ;;(global-evil-mc-mode 1)
  )

(defun my-evil-matchit ()
  (require 'evil-matchit)
  ;; use "%" to travel through matching syntax elements
  (global-evil-matchit-mode 1))

(defun my-magit ()
  (setq magit-last-seen-setup-instructions "1.4.0")
  (add-hook 'magit-log-edit-mode-hook
            (lambda ()
              (set-fill-column 72)
              (auto-fill-mode 1)))
  ;; ,cgs in god-mode
  (global-set-key (kbd "C-c s") 'magit-status))

(defun my-modeline ()
  (require 'rich-minority)
  (require 'smart-mode-line)
  ;;(sml/setup)
  ;;(sml/apply-theme 'powerline)
  (setq sml/shorten-modes t
        sml/shorten-directory t)
  (add-to-list 'rm-blacklist '("SkelC" "UndoTree" "Projectile.*" "AC" "SP" "SP/s" "ht"))
  (hide-mode-line-mode))

(defun my-bbyac ()
  (require 'bbyac)
  (bbyac-global-mode 1))

(defun my-avy ()
  (avy-setup-default)
  (define-key evil-motion-state-map (kbd "SPC") #'avy-goto-char-2)
  (define-key evil-motion-state-map (kbd "C-SPC") #'avy-goto-char-1)
  (define-key evil-normal-state-map (kbd "SPC") #'avy-goto-char-2))

(defun my-vimish-fold ()
  (vimish-fold-global-mode 1)
  (define-key evil-visual-state-map (kbd "C-f") #'vimish-fold)
  (define-key evil-normal-state-map (kbd "C-f") #'vimish-fold-toggle)
  (define-key evil-normal-state-map (kbd "M-f") #'vimish-fold-delete))

(defun my-ace-jump-buffer ()
  (define-key evil-normal-state-map "b" 'ace-jump-buffer))

(defun my-window-numbering ()
  (window-numbering-mode t))

(defun my-company ()
  (require 'company)
  (global-company-mode))

(defun my-mouse ()
  ;; Mouse in terminal
  (require 'mouse)
  ;; mouse mode must be initialised for each new terminal
  ;; see http://stackoverflow.com/a/6798279/27782
  (defun initialise-mouse-mode (&optional frame)
    "Initialise mouse mode for the current terminal."
    (if (not frame) ;; The initial call.
        (xterm-mouse-mode 1)
      ;; Otherwise called via after-make-frame-functions.
      (if xterm-mouse-mode
          ;; Re-initialise the mode in case of a new terminal.
          (xterm-mouse-mode 1))))
  ;; Evaluate both now (for non-daemon emacs) and upon frame creation
  ;; (for new terminals via emacsclient).
  (initialise-mouse-mode)
  (add-hook 'after-make-frame-functions 'initialise-mouse-mode)
  ;;(setq mouse-yank-at-point t)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1))))

(defun my-nyan ()
  (nyan-mode t))

(defun my-windmove ()
  (windmove-default-keybindings))

(defun my-ibuffer ()
  (autoload 'ibuffer "ibuffer" "List buffers." t)
  (global-set-key (kbd "C-c C-b") 'ibuffer)
  (setq ibuffer-use-other-window t)
  (add-hook 'ibuffer-hook
            (lambda () (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic))))
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                (vc-status 16 16 :left)
                " "
                filename-and-process))))

(defun my-hippie ()
  (global-set-key "\M- " 'hippie-expand)
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-all-abbrevs
          try-expand-list
          try-expand-line
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol)))

(defun my-auto-compile ()
  (require 'auto-compile)
  (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1))

(defun my-popwin ()
  (require 'popwin)
  (popwin-mode 1)
  ;; (setq display-buffer-function 'popwin:display-buffer)
  (setq popwin:special-display-config
        '(("*Help*" :height 30)
          ("*undo-tree*" :width 72 :heigth 40)
          ("*Completions*" :noselect t)
          ("*Messages*" :noselect t :height 30)
          ("*Apropos*" :noselect t :height 30)
          ("*compilation*" :noselect t)
          ("*Backtrace*" :height 30)
          ("*Messages*" :height 30)
          ("*HTTP Response*" :height 30)
          ("*Occur*" :noselect t)
          ("*Ido Completions*" :noselect t :height 30)
          ("*magit-commit*" :noselect t :height 40 :width 80 :stick t)
          ("*magit-diff*" :noselect t :height 40 :width 80)
          ("*magit-edit-log*" :noselect t :height 15 :width 80)
          ("\\*ansi-term\\*.*" :regexp t :height 30)
          ("*shell*" :height 30)
          (".*overtone.log" :regexp t :height 30)
          ("*gists*" :height 30)
          ("*sldb.*":regexp t :height 30)
          ("*cider-error*" :height 30 :stick t)
          ("*cider-doc*" :height 30 :stick t)
          ("*cider-src*" :height 30 :stick t)
          ("*cider-result*" :height 30 :stick t)
          ("*cider-macroexpansion*" :height 30 :stick t)
          ("*Kill Ring*" :height 30)
          ("*Compile-Log*" :height 30 :stick t)
          ("*git-gutter:diff*" :height 30 :stick t))))

(defun my-markdown ()
  ;;(require 'markdown-mode)
  (autoload 'markdown-mode "markdown-mode.el"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode)))

(defun my-auto-complete ()
  (progn
    (defconst my-ac-dict-dir "~/.emacs.d/ac-dict")
    (my-ensure-dir my-ac-dict-dir)
    (add-to-list 'ac-dictionary-directories my-ac-dict-dir))
  (progn
    (setq ac-delay 0.0)
    (setq ac-use-quick-help t)
    (setq ac-quick-help-delay 0.05)
    (setq ac-use-fuzzy t)
    (setq ac-auto-start 1)
    (setq ac-auto-show-menu t)
    (ac-config-default)))

(defun my-ido ()
  (require 'ido)
  (require 'flx-ido)
  (require 'ido-completing-read+)

  (setq ido-enable-prefix nil
        ido-use-faces nil ;; to see flx highlights
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-save-directory-list-file (expand-file-name "ido.hist" my-save-dir)
        ido-default-file-method 'selected-window
        ido-auto-merge-work-directories-length -1)

  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  (ido-ubiquitous-mode 1))

(defun my-flycheck ()
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode))
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
  (add-hook 'after-init-hook #'global-flycheck-mode))

(defun my-smex ()
  (require 'smex)
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands))

(defun my-ivy ()
  (require 'projectile)
  (require 'ivy)
  (require 'swiper)
  (require 'counsel)
  (require 'counsel-projectile)

  (ivy-mode 1)
  (counsel-projectile-mode 1)

  (setq ivy-use-virtual-buffers      t
        enable-recursive-minibuffers t
        ;; ivy-re-builders-alist        '((t . ivy--regex-fuzzy))
        ivy-re-builders-alist        '((t . ivy--regex-plus)))

  (define-key evil-normal-state-map "s" 'swiper)

  (global-set-key (kbd "C-x x") 'counsel-M-x)
  (global-set-key (kbd "C-o") 'counsel-projectile)
  (global-set-key (kbd "M-s s") 'counsel-projectile-rg)
  (global-set-key (kbd "C-x C-f" ) 'counsel-find-file)

  (projectile-global-mode)
  ;; (setq projectile-completion-system 'grizzl)
  (setq projectile-completion-system 'ivy)
  (setq projectile-show-paths-function 'projectile-hashify-with-relative-paths))

(defun my-undo-tree ()
  (global-undo-tree-mode)
  (define-key undo-tree-map (kbd "C-/") 'undo-tree-visualize)
  (global-set-key (kbd "C-c C-u") 'undo-tree-visualize))

(defun my-git-messenger ()
  ;; ,cgc in god-mode
  (global-set-key (kbd "C-c M-c") 'git-messenger:popup-message))

(defun my-git-timemachine ()
  (global-set-key (kbd "C-c M-h") 'git-timemachine))

(defun my-diff-hl ()
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(defun my-vlf ()
  (require 'vlf-integrate)
  (setq vlf-application 'dont-ask))

(defun my-yasnippet ()
  (global-set-key (kbd "C-c C-c") 'aya-create)
  (global-set-key (kbd "C-c C-v") 'aya-expand)
  (evil-define-key 'insert global-map (kbd "C-<tab>") 'aya-open-line))

(defun my-which-key ()
  (which-key-mode t)
  (setq which-key-allow-evil-operators t)
  (setq which-key-show-operator-state-maps t)
  (which-key-enable-god-mode-support)
  ;; (which-key-setup-side-window-right)
  ;; (which-key-setup-side-window-right-bottom)
  (which-key-setup-side-window-bottom))

(defun my-android ()
  (cond
   ((string= system-name "W010391306024")
    (setq android-mode-sdk-dir "d:/adt-bundle-windows/sdk"))
   ((string= system-name "localhost.localdomain")
    (message "go not configured for my centos vm yet..."))))

(defun my-deft ()
  (setq deft-extension "org")
  (setq deft-directory "~/Dropbox/notes")
  (setq deft-text-mode 'org-mode)
  (setq deft-use-filename-as-title t))

(defun my-history ()
  ;; Add history just before `find-tag' executed.
  ;; (add-to-list 'history-advised-before-functions 'find-tag-noselect t)
  ;; Add history just before `find-file' executed.
  ;; (add-to-list 'history-advised-before-functions 'find-file-noselect t)
  (setq history-history-max 999)
  (history-mode))

(defun my-dap ()
  ;; debugging library
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  ;; (require 'dap-lldb)
  (require 'dap-firefox)
  (dap-firefox-setup)
  (require 'dap-chrome)
  (dap-chrome-setup)
  (require 'dap-node)
  (dap-node-setup))

(defun my-lsp ()
  (use-package lsp-ui
    :ensure t
    :commands lsp-ui-mode)
  (use-package company
    :ensure t)
  (use-package lsp-mode
    :ensure t
    :hook ((clojure-mode . lsp)
           (clojurec-mode . lsp)
           (clojurescript-mode . lsp))
    :config
    ;; add paths to your local installation of project mgmt tools, like lein
    (setenv "PATH" (concat
                    "/usr/local/bin" path-separator
                    (getenv "PATH")))
    (dolist (m '(clojure-mode
                 clojurec-mode
                 clojurescript-mode
                 clojurex-mode))
      (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))))
  (lsp-treemacs-sync-mode 1))

(defun my-rust ()
  (with-eval-after-load 'lsp-mode
    (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls")))
  ;; (setq racer-cmd "/home/JP11629/.cargo/bin/racer")
  (autoload 'rust-mode "rust-mode" nil t)
  ;; (add-hook 'rust-mode-hook #'racer-mode)
  ;; (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode))

(defun my-set-shell-to-bash ()
  (setq shell-file-name "bash")
  (setq explicit-shell-file-name shell-file-name))

(defun my-evil-multiedit ()
  (require 'evil-multiedit)
  ;; Highlights all matches of the selection in the buffer.
  (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)
  ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
  ;; incrementally add the next unmatched match.
  (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  ;; Match selected region.
  (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
  ;; Same as M-d but in reverse.
  (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
  (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

  ;; OPTIONAL: If you prefer to grab symbols rather than words, use
  ;; `evil-multiedit-match-symbol-and-next` (or prev).

  ;; Restore the last group of multiedit regions.
  (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)
  ;; RET will toggle the region under the cursor
  (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  ;; ...and in visual mode, RET will disable all fields outside the selected region
  (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)
  ;; For moving between edit regions
  (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
  (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
  (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)
  ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match))

(defun my-ruby ()
  (add-hook 'ruby-mode-hook 'robe-mode)
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode)))

(defun my-fill-column-indicator ()
  (setq fci-rule-column 80)

  (defun my-fci-enabled-p () (symbol-value 'fci-mode))

  (defvar my-fci-mode-suppressed nil)
  (make-variable-buffer-local 'my-fci-mode-suppressed)

  (defadvice popup-create (before suppress-fci-mode activate)
    "Suspend fci-mode while popups are visible"
    (let ((fci-enabled (my-fci-enabled-p)))
      (when fci-enabled
        (setq my-fci-mode-suppressed fci-enabled)
        (turn-off-fci-mode))))

  (defadvice popup-delete (after restore-fci-mode activate)
    "Restore fci-mode when all popups have closed"
    (when (and my-fci-mode-suppressed
               (null popup-instances))
      (setq my-fci-mode-suppressed nil)
      (turn-on-fci-mode)))
  (add-hook 'prog-mode-hook (lambda () (fci-mode t))))

(defun my-parinfer ()
  (setq parinfer-extensions
        '(defaults pretty-parens evil lispy paredit smart-tab smart-yank))
  (setq parinfer-lighters '(" (indent)" . "(paren)")))

(defvar my-lisp-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (progn)
    map)
  "Keymap used for `mylisp-minor-mode'.")

(define-minor-mode my-lisp-minor-mode
  "My custom made lisp minor mode."
  :init-value nil
  :lighter " mylisp"
  :group 'my-modes
  :keymap my-lisp-minor-mode-map
  (progn
    (require 'evil-lispy)
    (evil-lispy-mode t)
    (evil-define-key 'normal evil-lispy-mode-map (kbd "m") 'evil-set-marker)
    (evil-define-key 'normal global-map (kbd "{") 'evil-lispy/enter-state-left)
    (evil-define-key 'normal global-map (kbd "}") 'evil-lispy/enter-state-right)
    (rainbow-delimiters-mode t)
    (hs-minor-mode t)
    (aggressive-indent-mode t)))

(defun my-clojure-custom ()
  (add-to-list 'exec-path "~/.local/bin")
  (require 'clj-refactor)
  (require 'icomplete) ;; for cider minibuffer completion
  (subword-mode t)
  (clj-refactor-mode t)
  (flycheck-mode t)
  (subword-mode t)
  (my-lisp-minor-mode t)
  (cljr-add-keybindings-with-prefix "M-q")
  (local-set-key (kbd "C-c C-a") 'align-cljlet)
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))\")\"")
  (setq cider-lein-parameters "repl :headless :host localhost")
  ;; remove the cider bind that overshadows the git messenger bind
  (local-unset-key (kbd "C-c M-c"))
  ;; setup clojure-lsp
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration `(,m . "clojure"))
    (add-hook m 'lsp))
  (with-eval-after-load 'lsp-mode
    (setq
     lsp-enable-indentation nil
     lsp-clojure-server-command '("bash" "-c" "clojure-lsp"))))

(defun my-lisp ()
  ;; all non clojure lisps
  (dolist (h '(emacs-lisp-mode-hook
               ielm-mode-hook
               lisp-mode-hook
               lisp-interaction-mode-hook
               geiser-repl-mode-hook
               scheme-mode-hook
               racket-mode-hook))
    (add-hook h #'my-lisp-minor-mode))
  ;; clojure
  (dolist (h '(clojure-mode-hook
               cider-mode-hook
               cider-repl-mode-hook))
    (add-hook h #'my-clojure-custom))
  ;; cider
  (dolist (h '( cider-mode-hook
                cider-repl-mode-hook))
    (add-hook h #'cider-company-enable-fuzzy-completion)
    (add-hook h #'eldoc-mode))
  ;; some conf...
  (setq cider-repl-tab-command #'indent-for-tab-command)
  ;; (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  (setq cider-prefer-local-resources t)
  (setq nrepl-log-messages t)
  (setq nrepl-hide-special-buffers      t
        nrepl-popup-stacktraces-in-repl t
        nrepl-history-file              "~/nrepl-history.dat")
  (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode)))

(defun my-rtags ()
  (cond
   ((string-match "darwin" system-configuration)
    (message "rtags for MacOS")
    (load-file "~/rtags/src/rtags.el")
    (load-file "~/rtags/src/company-rtags.el")
    ;;(load-file "~/rtags/src/flycheck-rtags.el")
    (rtags-enable-standard-keybindings c-mode-base-map)
    (setq rtags-autostart-diagnostic t
          rtags-completion-enabled t
          rtags-path "~/rtags/bin"))
   ((string-match "linux" system-configuration)
    (message "no rtags for Linux yet"))
   ((string-match "i686-pc-mingw32" system-configuration)
    (message "no rtags for Win 7 yet"))
   ((string-match "nt6" system-configuration)
    (message "no rtags for Win 7 yet"))))

(defun my-compilation-buffer ()
  (require 'ansi-color)
  (setq compilation-scroll-output 'first-error)
  (add-hook 'compilation-filter-hook
            (lambda ()
              (toggle-read-only)
              (ansi-color-apply-on-region compilation-filter-start (point))
              (toggle-read-only))))

(defun my-racket ()
  (add-to-list 'auto-mode-alist '("\\.rkt$" . racket-mode))
  (cond
   ((string= system-name "W010391306024")
    (progn
      (setq racket-racket-program "d:/Racket/Racket.exe"
            racket-raco-program "d:/Racket/raco.exe")))
   ((string= system-name "i022311303784m.local")
    (progn
      (setq racket-racket-program "/usr/local/bin/racket"
            racket-raco-program "/usr/local/bin/raco")))
   ((string= system-name "jojovm")
    (progn
      (setq racket-racket-program "/usr/bin/racket"
            racket-raco-program "/usr/bin/raco")))))

(defun my-fancy-narrow ()
  (define-key evil-visual-state-map (kbd "n") #'fancy-narrow-to-region)
  (define-key evil-normal-state-map (kbd "g r w") #'fancy-widen))

(defun my-csharp ()
  (autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
  (setq auto-mode-alist
        (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
  (add-hook 'csharp-mode-hook #'omnisharp-mode)
  (eval-after-load 'company-css  '(add-to-list 'company-backends 'company-omnisharp)))

(defun my-shell-pop ()
  (global-set-key (kbd "<f9>") 'shell-pop))

(defun my-asciidoc ()
  (autoload 'adoc-mode "adoc-mode" nil t)
  (add-to-list 'auto-mode-alist (cons "\\.txt\\'" 'adoc-mode)))

(defun my-groovy ()
  (autoload 'groovy-mode "groovy-mode" nil t)
  (add-to-list 'auto-mode-alist (cons "\\Jenkinsfile\\'" 'groovy-mode)))

(defun my-capnp ()
  (add-to-list 'auto-mode-alist '("\\.capnp\\'" . capnp-mode)))

(defun my-polymodes ()
  (require 'polymode)
  (defcustom pm-host/C++
    (pm-bchunkmode "C++"
                   :mode 'c++-mode)
    "C++ host chunkmode"
    :group 'hostmodes
    :type 'object)
  (defcustom pm-inner/Org
    (pm-hbtchunkmode "Org"
                     :mode 'org-mode
                     :head-reg "^[ \t]*/\\*\\*org$"
                     :tail-reg "^[ \t]*org\\*/$"
                     :font-lock-narrow t)
    "Org inner chunk"
    :group 'innermodes
    :type 'object)
  (defcustom pm-inner/Markdown
    (pm-hbtchunkmode "Markdown"
                     :mode 'markdown-mode
                     :head-reg "^[ \t]*/\\*\\*md[ \t]+"
                     :tail-reg ".*md\\*/$"
                     :font-lock-narrow t)
    "Org inner chunk"
    :group 'innermodes
    :type 'object)
  (defcustom pm-poly/c++doc
    (pm-polymode-multi "c++doc"
                       :hostmode 'pm-host/C++
                       :innermodes '(pm-inner/Org
                                     pm-inner/Markdown))
    "C++ & Org polymode."
    :group 'polymodes
    :type 'object)
  (define-polymode poly-c++doc pm-poly/c++doc))

(defun my-os-custom ()

  ;;--- set firefox as browser
  ;;(setq browse-url-browser-function 'browse-url-generic
  ;;      browse-url-generic-program "firefox")
  ;; fix it to be multiplatform

  (defun my-swap-meta-and-super ()
    "picked from emacs prelude"
    (interactive)
    (if (eq mac-command-modifier 'super)
        (progn
          (setq mac-command-modifier 'meta)
          (setq mac-option-modifier 'super)
          (message "Command is now bound to META and Option is bound to SUPER."))
      (progn
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (message "Command is now bound to SUPER and Option is bound to META."))))

  (defun my-macos-custom ()
    (my-set-shell-to-bash)
    ;;(require 'exec-path-from-shell)
    ;;(exec-path-from-shell-initialize)
    (setq ns-function-modifier 'hyper)
    (setq dired-listing-switches "-lha --group-directories-first")
    ;; from prelude, proced mode doesnt work on macos
    (global-set-key (kbd "s-/") 'hippie-expand)
    (global-set-key (kbd "C-c w") 'my-swap-meta-and-super)
    ;; Work around a bug on OS X where system-name is a fully qualified
    ;; domain name
    ;; (setq system-name (car (split-string system-name "\\.")))
    ;; Ignore .DS_Store files with ido mode
    (setq ido-ignore-files '("\\.DS_Store"))
    (server-start)
    (switch-to-buffer "*Messages*"))

  (defun my-windows-custom ()
    (server-start)
    (switch-to-buffer "*Messages*"))

  (defun my-linux-custom ()
    ;; (server-start) ;; should use emacs --daemon
    (switch-to-buffer "*Messages*")
    (setq dired-listing-switches "-lha --group-directories-first")
    (my-set-shell-to-bash))

  (cond
   ((string-match "darwin" system-configuration)
    (message "customizing GNU Emacs for MacOS")
    (my-macos-custom))
   ((string-match "linux" system-configuration)
    (message "customizing GNU Emacs for Linux")
    (my-linux-custom))
   ((string-match "i686-pc-mingw32" system-configuration)
    (message "customizing GNU Emacs for Win 7")
    (my-windows-custom))
   ((string-match "nt6" system-configuration)
    (message "customizing GNU Emacs for Win 7")
    (my-windows-custom))))

(defun my-cask-init ()
  (cond
   ((string-match "darwin" system-configuration)
    (require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el"))
   ((string-match "linux" system-configuration)
    (require 'cask "~/.cask/cask.el"))
   ((string-match "i686-pc-mingw32" system-configuration)
    (require 'cask "~/.cask/cask.el"))
   ((string-match "nt6" system-configuration)
    (require 'cask "~/.cask/cask.el")))
  (cask-initialize))

(defun my-funcs ()
  ;; ---
  (defun copy-to-clipboard ()
    (interactive)
    (if (region-active-p)
        (progn
          ;; my clipboard manager only intercept CLIPBOARD
          (shell-command-on-region (region-beginning) (region-end)
                                   (cond
                                    ((eq system-type 'cygwin) "putclip")
                                    ((eq system-type 'darwin) "pbcopy")
                                    (t "xsel -ib")))
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  ;; ---
  (defun paste-from-clipboard()
    (interactive)
    (shell-command
     (cond
      ((eq system-type 'cygwin) "getclip")
      ((eq system-type 'darwin) "pbpaste")
      (t "xsel -ob"))
     1))
  ;; ---
  (defun myfn-eval-last-sexp-with-value (value &optional prefix)
    (interactive "svalue: \nP")
    (cider-interactive-eval (s-concat "(" (cider-last-sexp) " " value " )")
                            (when prefix (cider-eval-print-handler))))
  (add-hook 'cider-mode-hook (lambda () (define-key cider-mode-map (kbd "C-c e") 'myfn-eval-last-sexp-with-value)))
  ;; ---
  (defun myfn-delete-region-if-uniq ()
    (interactive)
    (setq deactivate-mark t)
    (let ((p1 (region-beginning))
          (p2 (region-end)))
      (if (= 1 (count-matches (buffer-substring p1 p2)))
          (save-excursion
            (progn
              (delete-region p1 p2)
              (message "deleted region.")))
        (message "not unique!"))))
  ;; ---
  (defun myfn-narrow-indirect (start end)
    (interactive "r")
    (deactivate-mark)
    (let ((buf (clone-indirect-buffer nil nil)))
      (with-current-buffer buf
        (narrow-to-region start end)
        (switch-to-buffer buf))))
  (global-set-key (kbd "C-x n i") 'myfn-narrow-indirect))

(defmacro my-wordy (&rest prog)
  (cons 'progn
        (-mapcat (lambda (sexp)
                   (list (list 'message "running %s..." (list 'quote sexp))
                         sexp))
                 prog)))

(defun my-init()
  ;; -- getting external packages
  (message "PACKAGE LOADING!")
  (my-cask-init)
  ;; little library for following code
  (require 'dash)
  (dash-enable-font-lock)

  (my-wordy
   ;; --------------------------------------
   ;; -- Base
   ;; --------------------------------------
   (my-load-extra-files)
   (my-basic-init)
   (my-os-custom)
   (my-ensure-save-dir)
   ;; --------------------------------------
   ;; -- configuring global packages
   ;; --------------------------------------
   (my-discover-my-major)
   (my-evil)
   (my-evil-numbers)
   (my-evil-surround)
   (my-evil-multiedit)
   ;; (my-evil-matchit)
   (my-avy)
   (my-ace-jump-buffer)
   (my-windmove)
   (my-ibuffer)
   (my-hippie)
   (my-vimish-fold)
   ;; (my-auto-complete)
   (my-bbyac)
   (my-popwin)
   (my-buffer-move)
   (my-mouse)
   (my-window-numbering)
   (my-company)
   ;; --------------------------------------
   ;; -- configuring ide packages
   ;; --------------------------------------
   (my-which-key)
   ;; (my-ido)
   (my-smex)
   (my-flycheck)
   (my-ivy)
   (my-diff-hl)
   (my-undo-tree)
   (my-magit)
   (my-git-messenger)
   ;; (my-git-timemachine)
   ;; (my-yasnippet)
   ;; (my-fancy-narrow)
   ;; (my-android)
   (my-fill-column-indicator)
   ;; (my-rtags)
   (my-compilation-buffer)
   ;; (my-racket)
   ;; (my-groovy)
   (my-dap)
   (my-lsp)
   (my-rust)
   (my-ruby)
   (my-parinfer)
   (my-lisp)
   ;; (my-csharp)
   (my-markdown)
   (my-asciidoc)
   (my-capnp)
   ;; (my-polymodes)
   ;; --------------------------------------
   ;; other
   ;; --------------------------------------
   (my-shell-pop)
   ;; (my-deft)
   (my-funcs)
   (my-modeline)))

(my-init)
