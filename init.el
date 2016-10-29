(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(setq package-enable-at-startup nil)
(package-initialize)

(ensure-package-installed 'evil 'projectile 'magit 'helm 'labburn-theme 'evil-magit 'org-jira 'which-key)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ffc01b1b3a7cc43c6d0f25ff5573c21fe6cdf2e4e6ab0e4667856f1a90b98c60" default)))
 '(org-agenda-files (quote ("~/OrgFiles/todos.org")))
 '(package-selected-packages (quote (labburn-theme evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'evil)
(evil-mode t)
(require 'labburn-theme)
; (load-theme labburn)
(require 'projectile)
(projectile-mode)
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x g") 'magit-status)
(require 'evil-magit)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cb" 'org-iswithcb)
(setq org-log-done 't)
(require 'org-install)
(require 'org-mobile)
(setq org-directory "~/OrgFiles")
(setq org-mobile-directory "~/Dropbox/OrgMode")
(setq org-mobile-inbox-for-pull "~/OrgFiles/from-mobile.org")
(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "|" "DONE")))
(setq org-tag-alist '(("work" . ?w) ("home" . ?h)))

;; disable autoscroll to position cursor and window center
(setq scroll-conservatively 10)
;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
;; set tab size to 2
(setq tab-width 2)
;; set indent level for JavaScript to 2
(setq js-indent-level 2)

(require 'soap-client)
(setq jiralib-url "https://jira.genesys.com")

(require 'org-jira)

(which-key-mode 1)
