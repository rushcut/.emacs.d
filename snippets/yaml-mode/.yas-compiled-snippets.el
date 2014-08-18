;;; Compiled snippets and support files for `yaml-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'yaml-mode
                     '(("database(mysql)" "development:\n  adapter: mysql2\n  encoding: utf8\n  database: $1_development\n  username: root\n  password:\n  host: 127.0.0.1\n  port: 3306\n\ntest: &test\n  adapter: mysql2\n  encoding: utf8\n  database: $1_test\n  username: root\n  password: dpsjwl35\n  host: 127.0.0.1\n  port: 3306\n\ncucumber:\n  <<: *test\n" "database" nil nil nil nil nil nil)
                       ("locale" "errors:\n  # default format: \"%{attribute} %{message}\"\n  format: \"%{message}\"\n\nmongoid:\n  attributes:\n    article:\n      title: \"Article title\"\n\n  errors:\n    models:\n      article:\n        attributes:\n          title:\n            blank: \"Article title can't be blank.\"\n          document_id:\n            blank: \"You must associate the article with a parent document.\"\n          description_1:\n            blank: \"First description text area can't be blank.\"\n          code_1:\n            blank: \"First code text area can't be blank.\"\n\n      document:\n        attributes:\n          title:\n            blank: \"Document title can't be blank.\"\n" "locale(mongoid)" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Aug 18 20:11:30 2014
