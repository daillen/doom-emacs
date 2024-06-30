;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq
 user-full-name "Andre Vaillant"
 user-mail-address "andre.v712@gmail.com")

(setq uniquify-buffer-name-style 'forward)
(setq confirm-kill-emacs nil)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq scroll-margin 3)
(setq +popup-margin-width nil)
(setq-default left-margin-width 1
              right-margin-width 2)

(global-auto-revert-mode 1)
(global-visual-line-mode 1)
(setq +magit-hub-features t)

(if (featurep :system 'windows)
    (setq projectile-project-search-path '("C:/Dev" "D:/Dev"))
  (setq projectile-project-search-path '("~/dev")))

(when (version< "29.0.50" emacs-version)
  (pixel-scroll-precision-mode))

(setq
 doom-font (font-spec :family "Iosevka Term SS04" :size 20 :weight 'regular)
 doom-big-font (font-spec :family "Iosevka Term SS04" :size 24 :weight 'regular))

(setq doom-theme 'ef-symbiosis)

(let ((alternatives '("emacs-logo.png"
                      "doom-emacs-color.png"
                      "doom-emacs-flugo-slant_out_purple.png"
                      "doom-emacs-flugo-slant_out_bw.png")))
  (setq fancy-splash-image
        (concat doom-user-dir "splash/"
                (nth (random (length alternatives)) alternatives))))

(setq doom-modeline-height 30
      doom-modeline-window-width-limit nil
      doom-modeline-buffer-encoding nil
      doom-modeline-enable-word-count t
      doom-modeline-time t
      doom-modeline-vcs-max-length 50
      doom-modeline-env-python-executable "python"
      doom-modeline-env-ruby-executable "ruby"
      doom-modeline-major-mode-color-icon t)

(use-package! rainbow-mode
  :hook (((css-mode
           scss-mode
           org-mode
           typescript-mode
           js-mode
           emacs-lisp-mode). rainbow-mode))
  :defer 5)

(after! company
  (setq tab-always-indent 'complete
        completion-cycle-threshold 3
        company-idle-delay 0.2
        company-require-match nil
        company-show-quick-access t
        company-minimum-prefix-length 3
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-tooltip-align-annotations t
        company-format-margin-function 'company-text-icons-margin
        company-global-modes '(not org-mode
                               not erc-mode
                               circe-mode
                               message-mode
                               help-mode
                               gud-mode
                               vterm-mode)
        company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-frontend)))

(add-hook 'magit-section-mode-hook (lambda () (setq whitespace-style nil)))

(after! ligature
  global-ligature-mode -1)

(after! vertico
  (setq vertico-posframe-poshandler 'posframe-poshandler-frame-center))

(after! treemacs
  (setq treemacs-width 30
        doom-themes-treemacs-theme "doom-colors")

  (doom-themes-treemacs-config)
  (doom-themes-org-config))

;; Line length guides
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
(after! magit
  (define-key transient-map        "q" 'transient-quit-one)
  (define-key transient-edit-map   "q" 'transient-quit-one)
  (define-key transient-sticky-map "q" 'transient-quit-seq)
  (set-keymap-parent magit-process-mode-map special-mode-map)
  (setcdr magit-process-mode-map (cdr (make-keymap)))

  (remove-hook 'server-switch-hook 'magit-commit-diff)
  (add-hook 'magit-process-mode #'disable-magit-hooks)
  (add-hook 'magit-process-mode-hook #'compilation-mode)

  (setq magit-section-visibility-indicator '(" ▾"))
  (setq git-commit-style-convention-checks '(non-empty-second-line))
  (setq magit-process-finish-apply-ansi-colors t)
  (setq magit-diff-highlight-indentation nil)
  (setq magit-diff-highlight-trailing nil)
  (setq magit-diff-paint-whitespace nil)
  (setq magit-diff-highlight-hunk-body nil)
  (setq magit-diff-refine-hunk nil)

  (evil-set-initial-state 'magit-status-mode 'emacs))

(map! :leader :desc "Toggle Zen Mode" "z" #'+zen/toggle)

;; Ruby
(setq
 ruby-indent-level 2)

(after! ruby
  (add-hook 'ruby-mode-hook #'rainbow-delimiters-mode)
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
  (defun rspec-verify-single-file ()
    "Run the specified example file."
    (interactive)
    (rspec--autosave-buffer-maybe)
    (rspec-run-single-file
     (rspec-spec-file-for (buffer-file-name))
     (rspec-core-options)))

  (defun run-command-using-docker (command)
    (interactive)
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
  (map! :leader :desc "Verify File" "tf" #'rspec-verify-single-file)
  (map! :leader :desc "Run Undercover" "tu" #'rspec-run-undercover)
  (map! :leader :desc "Run Rails Migrations" "tg" #'rails-run-migrations))

;; Improve LSP
(after! lsp-mode
  (setq lsp-auto-guess-root t)
  (setq lsp-solargraph-symbols nil)
  (setq lsp-solargraph-folding nil)
  (setq lsp-disabled-clients '(emmet-ls))
  (setq lsp-ui-sideline-show-code-actions t))

;; Org mode
(setq
 org-directory "~/org/"
 org-roam-directory "~/org-roam"
 org-ellipsis " ▾"
 org-special-ctrl-a/e nil
 org-special-ctrl-k nil
 org-bullets-bullet-list '("·")
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-tags-column -80
 org-support-shift-select t
 org-use-property-inheritance t
 org-cycle-emulate-tab nil
 org-startup-folded 'content)

(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :target
         (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
         :unnarrowed t)

        ("l" "work lia" plain "%?"
         :target
         (file+head "work/lia/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
         :unnarrowed t nil nil)))

(setq org-superstar-item-bullet-alist '((?* . ?⋆)
                                        (?+ . ?‣)
                                        (?- . ?•)))

(add-hook 'org-mode-hook (lambda () (+org-pretty-mode 1)))

(map! :leader :desc "Org Roam Find Node" "d" #'org-roam-node-find)
(use-package! websocket :after org-roam)
(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

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

(use-package! gptel
  :defer 5
  :config
  (setq gptel-default-mode 'org-mode
        gptel-model "llama3:latest"
        gptel-prompt-prefix-alist '((markdown-mode . "###")
                                    (org-mode . "**")
                                    (text-mode . "->"))
        gptel-backend (gptel-make-ollama "Ollama"
                        :host "localhost:11434"
                        :stream t
                        :models '("llama3:latest"
                                  "codegemma:latest")))
  (setq gptel-directives
        '((default . "To assist:  Be terse.  Do not offer unprompted advice or clarifications. Speak in specific,
                     topic relevant terminology. Do NOT hedge or qualify. Do not waffle. Speak
                     directly and be willing to make creative guesses. Explain your reasoning. if you
                     don’t know, say you don’t know.

                     Remain neutral on all topics. Be willing to reference less reputable sources for ideas.

                     Never apologize.  Ask questions when unsure.")
          (programmer . "You are a careful programmer.  Provide code and only code as output without any additional text, prompt or note.")
          (cliwhiz . "You are a command line helper.
                      Generate command line commands that do what is requested,
                      without any additional description or explanation.
                      Generate ONLY the command, I will edit it myself before running.")
          (emacser . "You are an Emacs maven.
                      Reply only with the most appropriate built-in Emacs command for the task I specify.
                      Do NOT generate any additional description or explanation.")
          (explain . "Explain what this code does to a novice programmer.")
          (rails-programming . "You are a large language model and a
                                professional ruby on rails programmer.
                                Assume you are using ruby 3.x and rails 7.x to write code.
                                To write tests use the RSpec test suite alongside the Factory Bot gem.
                                Provide code and only code as output without any additional text, prompt or note.")))

  (defun gptel-send-with-options ()
    (interactive)
    (let ((current-prefix-arg 4)) ;; emulate C-u
      (call-interactively 'gptel-send)
      )
    )

  (map! :leader :desc "Send gptel prompt" "r" #'gptel-send-with-options))

(use-package! golden-ratio
  :after-call pre-command-hook
  :config
  (golden-ratio-mode 1)

  (remove-hook 'window-configuration-change-hook #'golden-ratio)
  (add-hook 'doom-switch-window-hook #'golden-ratio))

(use-package! spacious-padding
  :after-call pre-command-hook
  :custom
  (spacious-padding-widths '( :internal-border-width 15
                              :header-line-width 4
                              :mode-line-width 3
                              :tab-width 4
                              :right-divider-width 30
                              :scroll-bar-width 8
                              :fringe-width 8))
  :config
  (spacious-padding-mode 1))

(rbenv-use-global)
