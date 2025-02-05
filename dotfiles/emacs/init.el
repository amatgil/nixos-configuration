;;;;; Startup optimizations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (REMEMBER THAT C-c C-e evals the buffer, which includes the config without !nh !!)  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (stolen from https://emacs.stackexchange.com/questions/34342/is-there-any-downside-to-setting-gc-cons-threshold-very-high-and-collecting-ga)
;; From https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))
;;; Most of these are stolen from https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/
;(setq visible-bell t) ;; Make the flashing visible, like when scrolling up when at the top

(tool-bar-mode -1)   
(menu-bar-mode -1)   
(scroll-bar-mode -1) 
(hl-line-mode 1) ;; Highlight current line

(global-display-line-numbers-mode 1) ;; enable line numbers
(setq display-line-numbers 'relative) ;; make line numbers be relative
(setq column-number-mode t) ;; enable line columns
(recentf-mode 1) ;; Remember recent files (enables M-x recentf-open-files)
(setq recentf-max-menu-items 25)

(setq inhibit-startup-screen t)
(setq history-length 15) ;; Only remember the last 25 files opened (for startup performance)
(savehist-mode 1) ;; Remember what is typed into minibuffer. enables M-n (next-history-element) and M-p (previous-history-element)
(save-place-mode 1) ;; Don't forget place when file is closed
(rainbow-mode 1) ;; Enable showing colors for hexcolors like (#ed8796)

(overwrite-mode -1) ;; Disble overwrite mode so that text editing actually works
(global-origami-mode 1) ;; Enable folding

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil) ;; evil-collection tells me to use this if I'm using evil, so here it is
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

(use-package evil-collection
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

(evil-owl-mode) ; Preview registers before seeing them
(setq evil-owl-display-method 'window)
(setq evil-owl-idle-delay 0)

; visual line stuff: https://github.com/joostkremers/visual-fill-column (good README)
; whole thing is 'visual-fill-column-mode'!
(setq visual-line-fringe-indicators '(nil nil)) ; i don't think this does anything
(setq visual-fill-column-enable-sensible-window-split 1)
;(advice-add 'text-scale-adjust :after #'visual-fill-column-adjust)
(setq visual-fill-column-width 80) ; default is whatever fill-column is
(add-hook 'visual-fill-column-mode #'visual-line-mode)
;(setq-default visual-fill-column-center-text t) ; center text in the middle of the screen, better to do per-buffer

;; Move autosaves away from the directory
(setq backup-directory-alist `(("." . "~/.config/emacs/autosaves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Move customization variables to a separate file and load it so that emacs doesn't pollute init.el
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)


;; Don't pop up UI dialogs when prompting (for staying on the keyboard)
(setq use-dialog-box nil)

;; Automatic equivalent to vim :checktime (in THEORY)
(global-auto-revert-mode 1)
(setq auto-revert-use-notify t)
(setq auto-revert-verbose t)
;; Same as above for Dired and such
(setq global-auto-revert-non-file-buffers t)

(setq dired-dwim-target 'dired-dwim-target-recent)

;; OUTDATED: Config mostly from https://systemcrafters.net/emacs-from-scratch/the-modus-themes/ (but updated)


;(set-frame-font "FiraCode Nerd Font-10" nil t) ; breaks with emacsclient
;(set-frame-font "Uiua386-14" nil t)
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-10"))

(global-hl-line-mode 1)   ; Highlight current line

;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; i don't remember what this is, frankly
(global-set-key (kbd "C-c C-Ç") 'shrink-window-horizontally)
(global-set-key (kbd "C-c C-ç") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c s") 'scroll-lock-mode)

(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-show-code-actions t)
(global-set-key (kbd "C-c e s") 'flymake-show-buffer-diagnostics) ; Error (diagnostics) show (project is also an option, but we've got bacon for that in general)
(global-set-key (kbd "C-c e n") 'flymake-goto-next-error) ; Error next
(global-set-key (kbd "C-c e p") 'flymake-goto-prev-error) ; Error previous

;(global-set-key (kbd "C-c C-r") '(revert-buffer t t t))
(setq read-process-output-max (* 1024 1024)) ;; 1mb (for lsp)

(setq-default indent-tabs-mode nil) ; Emacs mixes tabs and spaces (i didn't know there was an objectively bad option about the two)

(direnv-mode 1)

(setq epa-pinentry-mode 'loopback) 
(pinentry-start)

(rainbow-delimiters-mode 1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;;;;;;; Replace emacs' help page with `helpful`s
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
;;;;;;;;;

(define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
(define-key evil-normal-state-map (kbd "C-s") 'evil-scroll-up)

; (Ma)Git / Forge
(global-set-key (kbd "C-c g") 'magit)
(with-eval-after-load 'magit
  (require 'forge))
; `~/.authinfo.gpg` must be encrypted with my public key and contain
; what is said here: https://magit.vc/manual/forge/Setup-for-Githubcom.html
(setq auth-sources '("~/.authinfo.gpg")) 

(setq ediff-split-window-function 'split-window-horizontally) 
(setq ediff-window-setup-function 'ediff-setup-windows-plain) ; Ediff window inside of buffer


(global-set-key (kbd "C-c f r") 'recentf-open-files)

(setq company-minimum-prefix-length 1 ;; Autocomplete and such
            company-idle-delay 0.0) ;; default is 0.2

;;; Rust
(add-hook 'rust-mode-hook 'lsp-deferred) ; Enable lsp-mode when in rust buffers
(setq lsp-keymap-prefix "C-c C-r") ; I checked, it was unbound (C-c ones are reserved for the user, apparently)
(setq dap-auto-configure-features '(sessions locals controls tooltip)) ; debugging (i hope)
(add-hook 'rust-mode-hook 
          (lambda () (add-hook 'before-save-hook 'lsp-format-buffer))) 
;;; Haskell
; > haskell-mode is stable and usable, whereas lsp-haskell is newer but under development and not ready for general use. 
(add-hook 'haskell-mode-hook #'lsp-deferred)
;(add-hook 'haskell-mode-hook #'interactive-haskell-mode)
(add-hook 'haskell-literate-mode-hook #'lsp-deferred)
;(setq haskell-interactive-popup-errors nil) ; Make C-c C-l errors usable
(add-hook 'haskell-mode-hook #'hindent-mode)


;;; C++
(add-hook 'c-mode-hook 'lsp-deferred)
(add-hook 'c++-mode-hook 'lsp-deferred)

(global-set-key (kbd "C-c C-c") 'compile)
(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-c C-c") nil) 
  (define-key c-mode-base-map (kbd "C-c C-c") 'compile))

;;; Elm
(add-hook 'elm-mode-hook 'lsp-deferred)

;;; Uiua
;(add-to-list 0lsp-language-id-configuration '(uiuacas-mode . "uiua")) ; buffer in uiuacas-mode correspond to the language "uiua"
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.ua" . "uiua")) ; buffer in uiuacas-mode correspond to the language "uiua"

  (lsp-register-client (make-lsp-client
                        :new-connection (lsp-stdio-connection '("uiua" "lsp"))
                        :activation-fn (lsp-activate-on "uiua")
                        :server-id 'uiua)))

(add-hook 'uiua-base-mode-hook 
	  (lambda () (setq buffer-face-mode-face '(:family "Uiua386")) (buffer-face-mode)))


(use-package org
  :config
  (setq org-ellipsis " ▾"))

(custom-set-variables
 '(org-directory "~/org")
 '(org-agenda-files (list org-directory)))

(setq org-default-notes-file (concat org-directory "/notes.org")) ; I found that user-emacs-directory exists (could be nicer)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain "%?" :target
     (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
     :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)) ; for autocompleting names of notes
  :config
  (org-roam-setup))

(setq org-todo-keywords '((sequence "TODO" "WAITING" "DONE")))
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)



; TODO: bind this to C-c n I
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))


;; Org mode languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (haskell . t)
   ; (rust . t) i need to add 'ob-rust' or whatever, i don't want to deal with it rn
   ; (sh . t) ; TODO: all of these or whatever
   ; (sed . t)
   ; (awk . t)
   (emacs-lisp . t)))


;; The selected line number doesn't scale when the font size changes (very noticeable in uiua)
;; This hacks around that (source: M-x customize-face)
(custom-set-faces
 '(line-number-current-line ((t (:inherit 'default)))))
(custom-set-faces
 '(line-number ((t (:inherit 'default)))))


; I like seeing how much text has been highlighted
(defun mode-line-region-chars ()
  (if (use-region-p)
      (let ((characters (+ 1 (abs (- (region-end) (region-beginning)))))
            (lines (+ 1 (abs (- (line-number-at-pos (region-end))
                                  (line-number-at-pos (region-beginning)))))))
        (format "<%d,%d>" lines characters))
    "<_,_>"))


(setq mode-line-misc-info
      (list '(:eval (mode-line-region-chars))))

(add-hook 'post-command-hook
          (lambda ()
            (force-mode-line-update)))

(defun sudo ()
  "Use TRAMP to `sudo` the current buffer"
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/sudo::"
             buffer-file-name))))


(global-set-key (kbd "M-c") 'calc)
(global-set-key (kbd "M-C") 'calendar)
(setq calendar-week-start-day 1)

(setq helm-move-to-line-cycle-in-source t)
(helm-mode 1)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

; Set helm completion to be useful lmao
(setq helm-completion-style 'emacs)
(setq completion-styles '(flex))


(global-set-key (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '("https://xkcd.com/rss.xml"
        "https://www.youtube.com/feeds/videos.xml?channel_id=UCs4fQRyl1TJvoeOdekW6lYA"))

; Baby's first hacking on emacs :3
(defun cas-open-video-in-mpv ()
  "Open provided youtube link with mpv, assuming mpv is in $PATH"
  (interactive)
  (let ((link (thing-at-point-url-at-point)))
    (if link
        (progn
          (message (format "Opening '%s' with mpv, hold tight..." link))
          (start-process "emacs-mpv-video-watch" "*mpv-video-watch*" "mpv" link))
      (message "No link found under point, could not open :c"))))

(use-package elfeed
  :config
  (keymap-set elfeed-show-mode-map "C-c C-o" 'cas-open-video-in-mpv))
