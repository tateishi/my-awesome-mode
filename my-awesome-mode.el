;;; my-awesome0mode.el --- Minor mode for awesome things. -*- lexical-binding: t; -*-

;; Author: TATEISHI Tadatoshi <tateishi@tw.tokai-tv.co.jp>
;; Maintainer: TATEISHI Tadatoshi <tateishi@tw.tokai-tv.co.jp>
;; Version: 0.0.1
;; Package-Requires: ((emacs "27.1"))
;; Keywords: convenience, tools
;; URL: https://github.com/tateishi
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:
;; This minor mode adds awesome features.
;; Usage:
;;   M-x my-awesome-mode

;;; Code:


(defgroup my-awesome nil
  "Customization group for my-awesome-mode."
  :group 'convenience)

(defcustom my-awesome-greeting "Hello"
  "Greeting message."
  :type 'string
  :group 'my-awesome)

;;;###autoload
(define-minor-mode my-awesome-mode
  "A minor mode that greets you."
  :init-value nil
  :lighter " Awesome"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c a g") #'my-awesome-greet)
            map)
  (if my-awesome-mode
      (message "my-awesome-mode enabled")
    (message "my-awesome-mode disabled")))

;;;###autoload
(defun my-awesome-greet ()
  "Show a greeting."
  (interactive)
  (message "%s, Emacs!" my-awesome-greeting))

(provide 'my-awesome-mode)
;;; my-awesome-mode.el ends here
