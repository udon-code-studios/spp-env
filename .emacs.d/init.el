;; file: ~/.emacs.d/init.el
;; author: Leo Battalora (GitHubID: leo6liu)
;;
;; Emacs Initialization File
;;
;; modification history:
;;  20200427 (LB): initial version
;;

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

;; show cursor position within line
(column-number-mode 1)

;; start c++ syntax highlighting for .cu (CUDA) files
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))

;; start c++ syntax highlighting for .cuh (CUDA header) files
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;;
;; end of file
