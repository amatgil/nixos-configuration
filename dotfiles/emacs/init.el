;;;;; Startup optimizations

; (stolen from https://emacs.stackexchange.com/questions/34342/is-there-any-downside-to-setting-gc-cons-threshold-very-high-and-collecting-ga)
;; From https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))
;;; Most of these are stolen from https://systemcrafters.net/emacs-from-scratch/the-best-default-settings/
(setq visible-bell t) ;; Make the flashing visible, like when scrolling up when at the top
(tool-bar-mode -1)   ;; disable tool-bar
(scroll-bar-mode -1) ;; disable scroll bar
(setq display-line-numbers 'relative) ;; make line numbers be relative
(global-display-line-numbers-mode 1) ;; enable line numbers
(hl-line-mode 1) ;; Highlight current line
(recentf-mode 1) ;; Remember recent files (enables M-x recentf-open-files)

(setq history-length 25) ;; Only remember the last 25 files opened (for startup performance)
(savehist-mode 1) ;; Remember what is typed into minibuffer. enables M-n (next-history-element) and M-p (previous-history-element)
(save-place-mode 1) ;; Don't forget place when file is closed

(overwrite-mode -1) ;; Disble overwrite mode so that text editing actually works
(global-origami-mode 1) ;; Enable folding
(setq evil-want-keybinding nil) ;; evil-collection tells me to use this if I'm using evil, so here it is
(setq evil-undo-system 'undo-fu)
(evil-mode 1) ;; Vim keybinds pretty please
(evil-collection-init) ;; Vim keybinds in buffers like magit too
(global-set-key (kbd "<escape>") 'keyboard-quit) ;; Make <ESC> do what C-g does as well


;; Move customization variables to a separate file and load it so that emacs doesn't pollute init.el
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Don't pop up UI dialogs when prompting (for staying on the keyboard)
(setq use-dialog-box nil)

;; Automatic equivalent to vim :checktime
(global-auto-revert-mode 1)
;; Same as above for Dired and such
(setq global-auto-revert-non-file-buffers t)

;; Config mostly from https://systemcrafters.net/emacs-from-scratch/the-modus-themes/
(setq modus-themes-mode-line '(accented borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-tabs-accented t
      modus-themes-paren-match '(bold intense)
      modus-themes-prompts '(bold intense)
      modus-themes-completions 'opinionated
      modus-themes-org-blocks 'tinted-background
      modus-themes-scale-headings t
      modus-themes-region '(bg-only)
      modus-themes-headings
      '((1 . (rainbow overline background 1.4))
        (2 . (rainbow background 1.3))
        (3 . (rainbow bold 1.2))
        (t . (semilight 1.1))))
(load-theme 'modus-vivendi t) ;; load theme (configured above (the order is important))

;(set-frame-font "Iosevka 11" nil t) ;; looks kind of bad for emacs, somehow