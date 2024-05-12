;;; custom.el ---                                    -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Andre Vaillant

;; Author: Andre Vaillant <andre@Andres-MBP>
;; Keywords:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes '(default))
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-roam-capture-templates
   '(("d" "default" plain "%?" :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\12")
      :unnarrowed t)
     ("l" "work lia" plain "%?" :target
      (file+head "work/lia/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
      :unnarrowed t nil nil))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:extend t :underline "#41a7fc")))))
