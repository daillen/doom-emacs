;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq
 user-full-name "Andre Vaillant"
 user-mail-address "andre.v712@gmail.com")

(setq uniquify-buffer-name-style 'forward)
(setq confirm-kill-emacs nil)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(alpha . 95))

(setq +popup-margin-width nil)
(setq-default left-margin-width 1
              right-margin-width 2)

;; (setq evil-normal-state-cursor '(box "#41a7fc")
;;       evil-insert-state-cursor '(bar "#00AEE8")
;;       evil-visual-state-cursor '(hollow "#c75ae8"))

(setq +magit-hub-features t)

(if (featurep :system 'windows)
    (setq projectile-project-search-path '("C:\Dev" "D:\Dev"))
  (setq projectile-project-search-path '("~/dev")))

(setq
 doom-font (font-spec :family "Iosevka Term SS04" :size 24 :weight 'regular)
 doom-big-font (font-spec :family "Iosevka Term SS04" :size 36 :weight 'regular))

(setq doom-theme 'ef-dream)

(let ((alternatives '("doom-emacs-bw-light.svg"
                      "doom-emacs-flugo-slant_out_purple-small.png"
                      "doom-emacs-flugo-slant_out_bw-small.png")))
  (setq fancy-splash-image
        (concat doom-user-dir "splash/"
                (nth (random (length alternatives)) alternatives))))

(use-package! rainbow-mode
  :hook (((css-mode
           scss-mode
           org-mode
           typescript-mode
           js-mode
           emacs-lisp-mode). rainbow-mode))
  :defer 5)

(setq
 +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 2))

(after! company
  (setq tab-always-indent 'complete
        completion-cycle-threshold 3
        company-idle-delay 0.5
        company-show-quick-access t
        company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-tooltip-align-annotations t))

(after! whitespace
  (setq
   whitespace-style '(face tabs spaces trailing space-before-tab
                      indentation empty space-after-tab tab-mark space-mark)
   display-line-numbers-type t
   show-trailing-whitespace t)
  global-whitespace-mode 1)

(add-hook 'magit-section-mode-hook (lambda () (setq whitespace-style nil)))

(after! ligature
  global-ligature-mode -1)

(after! vertico
  (setq vertico-posframe-poshandler 'posframe-poshandler-frame-bottom-center))

(after! treemacs
  (setq treemacs-width 45
        doom-themes-treemacs-theme "doom-colors")

  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; Line length guides
(add-hook! emacs-lisp-mode
  (setq display-fill-column-indicator-column 80)
  (display-fill-column-indicator-mode))
(add-hook! ruby-mode
  (setq display-fill-column-indicator-column 120)
  (display-fill-column-indicator-mode))
(add-hook! python-mode
  (setq display-fill-column-indicator-column 80)
  (display-fill-column-indicator-mode))

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
(use-package! magit
  :defer t
  :hook
  (magit-process-mode . compilation-minor-mode)
  :config
  (define-key transient-map        "q" 'transient-quit-one)
  (define-key transient-edit-map   "q" 'transient-quit-one)
  (define-key transient-sticky-map "q" 'transient-quit-seq)
  (add-hook 'magit-process-mode #'disable-magit-hooks)
  ;; (add-hook 'magit-process-mode-hook #'compilation-mode)
  (setcdr magit-process-mode-map (cdr (make-keymap)))
  (set-keymap-parent magit-process-mode-map special-mode-map)
  (setq magit-process-finish-apply-ansi-colors t))

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
  (defun doom-emacs-on-rails-add-custom-projectile-finder (name
                                                           folder
                                                           file-pattern
                                                           pattern
                                                           keybinding)
    (fset (intern (concat "projectile-rails-custom-find-" name))
          (eval `
           (lambda ()
             (interactive)
             (projectile-rails-find-resource
              (concat ,name ": ")
              '((,folder ,file-pattern))
              ,pattern))))
    (map! :leader
          :desc (concat "Find " name)
          keybinding (intern (concat "projectile-rails-custom-find-" name)))))

(after! rspec-mode
  (defun run-command-using-docker (command)
    (let ((docker-compose-command (concat rspec-docker-command
                                          " "
                                          rspec-docker-container)))
      (compile
       (concat docker-compose-command " " command)
       t)))

  (defun rspec-verify-all-parallel ()
    "rails parallel:spec"
    (interactive)
    (run-command-using-docker "bundle exec rails parallel:spec"))

  (defun rspec-run-undercover ()
    "undercover -c origin/main"
    (interactive)
    (run-command-using-docker "bundle exec undercover -c origin/main"))

  (defun rails-run-migrations ()
    "rails db:migrate"
    (interactive)
    (run-command-using-docker "bundle exec rails db:migrate"))

  (defun rails-dev-console ()
    "rails development console"
    (interactive)
    (run-command-using-docker "bundle exec rails console"))

  (setq rspec-factory-gem 'factory-bot)
  (setq rspec-use-docker-when-possible t)
  (setq rspec-docker-file-name "../../docker-compose.yml")
  (setq rspec-docker-command "docker compose run --rm")
  (setq rspec-docker-container "platform-api")

  (set-popup-rule! "^\\*\\(rspec-\\)?compilation" :size 0.5 :ttl nil :select t)
  (map! :leader :desc "Rspec" "t" #'rspec-mode-keymap)
  (map! :leader :desc "Run Last Failed" "tl" #'rspec-run-last-failed)
  (map! :leader :desc "Verify All Parallel" "ta" #'rspec-verify-all-parallel)
  (map! :leader :desc "Run Undercover" "tu" #'rspec-run-undercover)
  (map! :leader :desc "Run Rails Migrations" "tg" #'rails-run-migrations))

;; Org mode
(setq
 org-directory "~/org/"
 org-roam-directory "~/org-roam"
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-tags-column -80
 org-support-shift-select t)

(map! :leader :desc "Org Roam Find Node" "d" #'org-roam-node-find)

(use-package! org-modern
  :init
  (add-hook 'org-mode-hook 'org-modern-mode))

(use-package! websocket :after org-roam)
(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(after! evil-org
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

;; gptel to use chat AI
;; (use-package! gptel
;;   :config
;;   (setq gptel-log-level 'debug)
;;   (setq gptel-max-tokens 500)
;;   (setq gptel-default-mode 'org-mode)
;;   (setq gptel-stream nil)
;;   (setq gptel-model "Meta-Llama-3-8B-Instruct.Q4_0.gguf")
;;   (setq gptel-backend (
;;                        gptel-make-gpt4all "GPT4All"
;;                        :protocol "http"
;;                        :host "localhost:4891"
;;                        :models '("Meta-Llama-3-8B-Instruct.Q4_0.gguf"))))

(use-package! blamer
  :defer 5

  :custom
  (blamer-idle-time 0.8)
  (blamer-min-offset 20)
  (blamer-type 'visual)
  (blamer-view 'overlay)
  (blamer-max-commit-message-length 65)

  :config
  (global-blamer-mode 1))

(rbenv-use-global)
