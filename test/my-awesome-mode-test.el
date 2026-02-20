;;; my-awesome-mode-test.el --- Tests -*- lexical-binding: t -*-

(require 'ert)
(require 'my-awesome-mode)

(ert-deftest my-awesome-greet-returns-message ()
  (let ((my-awesome-greeting "Howdy"))
    (should (stringp (format "%s, Emacs!" my-awesome-greeting)))))
