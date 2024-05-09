;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq
 user-full-name "Andre Vaillant"
 user-mail-address "andre.v712@gmail.com")

(setq
 doom-font (font-spec :family "Iosevka Term SS04" :size 24 :weight 'regular)
 doom-big-font (font-spec :family "Iosevka Term SS04" :size 36 :weight 'regular)
 ;;doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18)
 )

(setq doom-theme 'doom-dracula)

(when (eq doom-theme 'doom-dracula)
  (custom-set-faces
   '(line-number ((t (:inherit default :foreground "gray40" :strike-through nil :underline nil :slant normal :weight normal))))))

(after! whitespace-mode
  (setq
   whitespace-style '(face tabs spaces trailing space-before-tab indentation empty space-after-tab tab-mark space-mark)
   display-line-numbers-type t
   show-trailing-whitespace t)
  global-whitespace-mode -1)

(after! ligature-mode
  global-ligature-mode -1)

;; Web mode
(setq
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2
 css-indent-offset 2
 mac-command-modifier 'meta
 js-indent-level 2
 typescript-indent-level 2
 json-reformat:indent-width 2
 prettier-js-args '("--single-quote"))

(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode)))

;; Magit
(after! magit
  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (setq magit-diff-highlight-indentation nil)
  (setq magit-diff-highlight-hunk-body nil)
  (setq magit-diff-refine-hunk nil))

;; Ruby
(setq
 ruby-indent-level 2)

(after! ruby
  (add-to-list 'hs-special-modes-alist
               `(ruby-mode
                 ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
                 ,(rx (or "}" "]" "end"))                       ; Block end
                 ,(rx (or "#" "=begin"))                        ; Comment start
                 ruby-forward-sexp nil)))

(after! ruby-mode
  (set-lookup-handlers! 'ruby-mode
    :definition '(projectile-rails-goto-file-at-point robe-jump)
    :documentation #'robe-doc))

(after! projectile-rails
  (defun doom-emacs-on-rails-add-custom-projectile-finder (name folder file-pattern pattern keybinding)
    (fset (intern (concat "projectile-rails-custom-find-" name))
          (eval `
           (lambda ()
             (interactive)
             (projectile-rails-find-resource
              (concat ,name ": ")
              '((,folder ,file-pattern))
              ,pattern))))
    (map! :leader :desc (concat "Find " name) keybinding (intern (concat "projectile-rails-custom-find-" name)))))

(after! rspec-mode
  (set-popup-rule! "^\\*\\(rspec-\\)?compilation" :size 0.5 :ttl nil :select t)
  (map! :leader :desc "Rspec" "t" #'rspec-mode-keymap)
  (map! :leader :desc "Run Last Failed" "tl" #'rspec-run-last-failed))

;; Org mode
(setq
 org-directory "~/org/"
 org-roam-directory "~/org-roam"
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-tags-column -80
 org-support-shift-select t)

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(setq confirm-kill-emacs nil)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq +magit-hub-features t)
(setq projectile-project-search-path '("~/dev"))

;; why-this -- git blame on every line
(after! why-this
  (set-face-background 'why-this-annotate-heat-map-cold "#203448")
  (set-face-background 'why-this-annotate-heat-map-warm "#382f27")
  (global-why-this-mode -1))

(rbenv-use-global)
