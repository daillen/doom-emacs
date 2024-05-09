;;; custom.el ---                                    -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Andre Vaillant

;; Author: Andre Vaillant <andre@Andres-MBP>
;; Keywords:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("014cb63097fc7dbda3edf53eb09802237961cbb4c9e9abd705f23b86511b0a69" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "d6b934330450d9de1112cbb7617eaf929244d192c4ffb1b9e6b63ad574784aad" "4ade6b630ba8cbab10703b27fd05bb43aaf8a3e5ba8c2dc1ea4a2de5f8d45882" "88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" "8d8207a39e18e2cc95ebddf62f841442d36fcba01a2a9451773d4ed30b632443" default))
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
 '(line-number ((t (:inherit default :foreground "gray40" :strike-through nil :underline nil :slant normal :weight normal)))))
(put 'customize-variable 'disabled nil)
