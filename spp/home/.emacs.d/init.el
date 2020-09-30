;; file: ~/.emacs.d/init.el
;;
;; emacs initialization file
;;
;; modification history:
;;  20200630 (LB): added dark terminal setting
;;  20200427 (LB): initial version
;;

;; disable backup
(setq backup-inhibited t)

;; disable auto save
(setq auto-save-default nil)

;; show cursor position within line
(column-number-mode 1)

;; start c++ syntax highlighting for .cu/.cuh (CUDA) files
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;; fix colors on dark terminal
;; comment out the following line if using emacs in a light terminal
(setq frame-background-mode 'dark)

;;
;; end of file
