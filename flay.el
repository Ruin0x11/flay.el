;;; flay.el --- Emacs interface to flay

;; Copyright (C) 2017  Ian Pickering

;; Author: Ian Pickering <ipickering2@gmail.com>
;; URL: https://github.com/Ruin0x11/flay.el
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; An interface to running flay against ruby source code.

;;; Code:


(defcustom flay-command "flay"
  "Command used for running flay."
  :group 'flay
  :type 'string)

(defcustom flay-args "-v --diff"
  "Arguments passed to flay."
  :group 'flay
  :type 'string)

(defvar flay-default-error-regexp
  "^  [A-Z]: \\([^:]*\\):\\([1-9][0-9]*\\)")

(add-to-list 'compilation-error-regexp-alist-alist
             (cons 'flay '(flay-default-error-regexp 1 2)))
(add-to-list 'compilation-error-regexp-alist 'flay)

(define-derived-mode flay-output-mode compilation-mode "Flay Output"
  "Compilation mode for running flay.")

(defun flay--full-command (file)
  "Get the full command to flay, with flags and argument FILE."
  (concat flay-command " " flay-args " " file))

(defun flay-files (file)
  "Run flay on a file or directory FILE."
  (interactive
   (let ((file (read-file-name
                "File or directory: " default-directory default-directory nil)))
     (list file)))
  (compile (flay--full-command file) 'flay-output-mode))

(provide 'flay)
;;; flay.el ends here
