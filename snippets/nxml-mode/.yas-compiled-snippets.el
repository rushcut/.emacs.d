;;; Compiled snippets and support files for `nxml-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'nxml-mode
                     '(("arr" "<array>\n</array>\n" "Array" nil nil nil nil nil nil)
                       ("attr" "<key>$1</key>\n<$2>$3</$2>\n" "Attribute" nil nil nil nil nil nil)
                       ("output" "<dict>\n  <key>config</key>\n  <dict>\n    <key>plusspaces</key>\n    <false/>\n    <key>url</key>\n    <string>${1:url}</string>\n    <key>utf8</key>\n    <false/>\n  </dict>\n  <key>type</key>\n  <string>alfred.workflow.action.openurl</string>\n  <key>uid</key>\n  <string>`(insert-random-uuid)`</string>\n  <key>version</key>\n  <integer>0</integer>\n</dict>" "Open URL (Alfred)" nil nil nil nil nil nil)
                       ("input" "<dict>\n  <key>config</key>\n  <dict>\n    <key>argumenttype</key>\n    <integer>0</integer>\n    <key>escaping</key>\n    <integer>0</integer>\n    <key>keyword</key>\n    <string>${1:keyword}</string>\n    <key>title</key>\n    <string>${2:title}</string>\n    <key>subtext</key>\n    <string>${3:subtext}</string>\n    <key>runningsubtext</key>\n    <string>${4:running text}</string>\n    <key>script</key>\n    <string>${5:script}</string>\n    <key>type</key>\n    <integer>0</integer>\n    <key>withspace</key>\n    <true/>\n  </dict>\n  <key>type</key>\n  <string>alfred.workflow.input.scriptfilter</string>\n  <key>uid</key>\n  <string>`(insert-random-uuid)`</string>\n  <key>version</key>\n  <integer>0</integer>\n</dict>" "Script Filter (Alfred)" nil nil nil nil nil nil)
                       ("dict" "<dict>\n$0\n</dict>\n" "dictionary" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Fri Aug  8 10:08:47 2014
