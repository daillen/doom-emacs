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

(if (featurep :system 'macos)
    (setq mac-command-modifier 'meta
          mac-option-modifier 'none
          mac-right-option-modifier 'none
          ns-use-proxy-icon nil ; disable file icon in titlebar
          ns-use-native-fullscreen t))

(if (featurep :system 'windows)
    (setq projectile-project-search-path '("C:/Dev" "C:/Dev/lia/projects" "C:/Dev/Projects" "D:/Dev"))
  (setq projectile-project-search-path '("~/dev" "~/dev/lia/projects")))

(setq
 doom-font (font-spec :family "Iosevka SS04" :size 18 :weight 'regular)
 doom-big-font (font-spec :family "Iosevka SS04" :size 24 :weight 'regular))

(setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'ef-autumn)

(add-hook! display-line-numbers-mode
  (custom-set-faces!
    '(line-number :slant normal)
    '(line-number-current-line :slant normal)))

;; (let ((alternatives '("emacs-logo.png"
;;                       "doom-emacs-color.png"
;;                       "doom-emacs-flugo-slant_out_purple.png"
;;                       "doom-emacs-flugo-slant_out_bw.png")))
;;   (setq fancy-splash-image
;;         (concat doom-user-dir "splash/"
;;                 (nth (random (length alternatives)) alternatives))))

(defun my-weebery-is-always-greater ()
  (let* ((banner '("⢸⣿⣿⣿⣿⠃⠄⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀⠄"
                   "⢸⣿⣿⣿⡟⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷"
                   "⢸⣿⣿⠟⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿"
                   "⢸⣿⢫⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿"
                   "⡿⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿"
                   "⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿"
                   "⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟"
                   "⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣"
                   "⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾"
                   "⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿"
                   "⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿"
                   "⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿"
                   "⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿"
                   "⠄⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋⠄⠄⣾⡌⢠⣿⡿⠃"
                   "⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉⠄⠄          "))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

(after! doom-modeline
  (setq doom-modeline-height 30
        doom-modeline-window-width-limit nil
        doom-modeline-buffer-encoding nil
        doom-modeline-enable-word-count t
        doom-modeline-time t
        doom-modeline-vcs-max-length 100
        doom-modeline-env-python-executable "python"
        doom-modeline-env-ruby-executable "ruby"
        doom-modeline-major-mode-icon t
        doom-modeline-lsp-icon t
        doom-modeline-check-simple-format t)

  :config

  (defun doom-modeline-vcs-name ()
    "Display the vcs name. - Override"
    (and vc-mode (cadr (split-string (string-trim vc-mode) "^[A-Z]+[-:]+")))))

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
                               erc-mode
                               circe-mode
                               message-mode
                               help-mode
                               gud-mode
                               vterm-mode
                               shell-mode
                               compilation-mode
                               comint-mode
                               term-mode)
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
  (setq display-fill-column-indicator-column 120)
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

  (setq magit-section-visibility-indicator '(" ▾")
        git-commit-style-convention-checks '(non-empty-second-line)
        magit-process-finish-apply-ansi-colors t
        magit-diff-highlight-indentation nil
        magit-diff-highlight-trailing nil
        magit-diff-paint-whitespace nil
        magit-diff-highlight-hunk-body nil
        magit-diff-refine-hunk nil)

  (evil-set-initial-state 'magit-status-mode 'emacs))

(map! :leader :desc "Toggle Zen Mode" "z" #'+zen/toggle)

;; Docker
(defvar docker-compose-file "~/dev/lia/docker-compose.yml"
  "Path to docker-compose.yml file.")

(defun docker-compose-run (&optional service command)
  "Run a command in a Docker Compose service container.
   SERVICE: The service name (default: platform-api)
   COMMAND: The command to run (default: bundle exec rails c)"
  (let* ((service (or service "platform-api"))
         (command (or command "bundle exec rails c"))
         (docker-command (format "docker compose -f %s run --rm %s %s"
                                 docker-compose-file service command)))
    (compile docker-command 'rspec-compilation-mode)))

(defun rspec-verify-all-parallel ()
  "rails parallel:spec"
  (interactive)
  (docker-compose-run nil "bundle exec rails parallel:spec"))

(defun docker-run-rubocop ()
  "rails parallel:spec"
  (interactive)
  (docker-compose-run nil "bundle exec rubocop"))

(defun docker-run-undercover ()
  "undercover -c origin/main"
  (interactive)
  (docker-compose-run nil "bundle exec undercover -c origin/main"))

(defun docker-run-rails-migrations ()
  "rails db:migrate"
  (interactive)
  (docker-compose-run nil "bundle exec rails db:migrate"))

(defun docker-run-rails-console ()
  "rails development console"
  (interactive)
  (docker-compose-run nil "bundle exec rails console"))

(map! :leader :desc "Verify All Parallel" "ta" #'rspec-verify-all-parallel)
(map! :leader :desc "Run Rubocop" "tr" #'docker-run-rubocop)
(map! :leader :desc "Run Undercover" "tu" #'docker-run-undercover)
(map! :leader :desc "Run Rails Migrations" "tg" #'docker-run-rails-migrations)

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

  (setq rspec-factory-gem 'factory-bot)
  (setq rspec-use-docker-when-possible t)
  (setq rspec-docker-file-name "../../docker-compose.yml")
  (setq rspec-docker-command "docker compose run --rm")
  (setq rspec-docker-container "platform-api")

  (set-popup-rule! "^\\*\\(rspec-\\)?compilation" :size 0.5 :ttl nil :select t)
  (map! :leader :desc "Rspec" "t" #'rspec-mode-keymap)
  (map! :leader :desc "Run Last Failed" "tl" #'rspec-run-last-failed)
  (map! :leader :desc "Verify File" "tf" #'rspec-verify-single-file))

;; Improve LSP
(after! lsp-mode
  (setq lsp-auto-guess-root t
        lsp-solargraph-symbols nil
        lsp-solargraph-folding nil
        lsp-disabled-clients '(emmet-ls)
        lsp-ui-sideline-show-code-actions t))

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
 org-startup-folded 'content
 org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(setq org-capture-templates
      '(("n" "Notes" entry (file "~/org-roam/20240507230023-notes.org")
         "* %?\n")))

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

(defun org-capture-notes ()
  (interactive)
  (org-capture nil "n"))

(map! :leader :desc "Org Roam" "n")
(map! :leader :desc "Add Note" "nc" #'org-capture-notes)
(map! :leader :desc "Find Node" "nf" #'org-roam-node-find)
(map! :leader :desc "Insert Node" "na" #'org-roam-node-insert)
(map! :leader :desc "Buffer Toggle" "nb" #'org-roam-buffer-toggle)
(map! :leader :desc "DB Sync" "ns" #'org-roam-db-sync)
(map! :leader :desc "Show Graph" "ng" #'org-roam-graph)

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

;; Gptel

(defun gptel-load-directives-from-files (directory)
  (let ((directives '()))
    (dolist (file (directory-files directory t "\\.txt$"))
      (let* ((filename (file-name-nondirectory file))
             (key (file-name-sans-extension filename))
             (content (with-temp-buffer
                        (insert-file-contents file)
                        (buffer-string))))
        ;; Convert key to symbol and add the pair to our directives list
        (push (cons (intern key) content) directives)))
    directives))

(defun gptel-send-with-options ()
  (interactive)
  (let ((current-prefix-arg 4)) ;; emulate C-u
    (call-interactively 'gptel-send)))

(defun gptel-read-documentation (symbol)
  "Read the documentation for SYMBOL, which can be a function or variable."
  (let ((sym (intern symbol)))
    (cond
     ((fboundp sym)
      (documentation sym))
     ((boundp sym)
      (documentation-property sym 'variable-documentation))
     (t
      (format "No documentation found for %s" symbol)))))

(use-package! gptel
  :defer 5
  :config
  (setq gptel-default-mode 'org-mode
        gptel-use-tools t
        gptel-prompt-prefix-alist '((markdown-mode . "###")
                                    (org-mode . "* ")
                                    (text-mode . "->"))
        gptel-directives (gptel-load-directives-from-files (concat doom-user-dir "gptel-directives/"))
        gptel-temperature 0.5
        gptel-model 'claude-sonnet-4-20250514
        gptel-backend (gptel-make-anthropic "Claude"
                        :stream t :key (getenv "CLAUDE_API_KEY")))

  (add-to-list 'gptel-tools
               (gptel-make-tool
                :function (lambda (url)
                            (with-current-buffer (url-retrieve-synchronously url)
                              (goto-char (point-min))
                              (forward-paragraph)
                              (let ((dom (libxml-parse-html-region (point) (point-max))))
                                (run-at-time 0 nil #'kill-buffer (current-buffer))
                                (with-temp-buffer
                                  (shr-insert-document dom)
                                  (buffer-substring-no-properties (point-min) (point-max))))))
                :name "read_url"
                :description "Fetch and read the contents of a URL"
                :args (list '(:name "url"
                              :type string
                              :description "The URL to read"))
                :category "web")

               (gptel-make-tool
                :name "read_documentation"
                :function #'gptel-read-documentation
                :description "Read the documentation for a given function or variable"
                :args (list '(:name "name"
                              :type string
                              :description "The name of the function or variable whose documentation is to be retrieved"))
                :category "emacs"))

  (map! :leader :desc "Gptel" "r")
  (map! :leader :desc "Gptel Send" "rs" #'gptel-send-with-options)
  (map! :leader :desc "Gptel Rewrite" "rr" #'gptel-rewrite))

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

(map! :leader
      :desc "Resume last search"    "sr"
      (cond ((modulep! :completion vertico)    #'vertico-repeat)
            ((modulep! :completion ivy)        #'ivy-resume)
            ((modulep! :completion helm)       #'helm-resume)))

(rbenv-use-global)
