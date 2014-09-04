;;; Compiled snippets and support files for `haml-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'haml-mode
                     '((";" "%" ";" nil nil nil nil nil nil)
                       ("checkbox" ".form-group\n  - @games.each do |game|\n    %label\n      = check_box_tag \"quest[game_ids][]\", game.id\n      = game.name" "checkbox" nil nil nil nil nil nil)
                       ("md" "`(delete-char (- (skip-chars-backward \" \")))`.col-md-${1:12}" "col-md-x" nil nil nil nil nil nil)
                       ("xs" "`(delete-char (- (skip-chars-backward \" \")))`.col-xs-$0\n" "col-xs-x" nil nil nil nil nil nil)
                       ("co" "`(delete-char (- (skip-chars-backward \" \")))`.col-xs-offset-$0\n" "col-xs-offset-" nil nil nil nil nil nil)
                       ("nav" "%li= link_to \"Action\", \"#\"\n%li.dropdown\n  %a.dropdown-toggle{\"href\" => \"#\", \"data-toggle\" => \"dropdown\"}\n    %span.glyphicon.glyphicon-cog\n  %ul.dropdown-menu\n    %li= link_to \"Action\", \"#\"" "dropdown item" nil nil nil nil nil nil)
                       ("each" "- ${1:elements}.each do |${1:$(ruby-singularize-last-string yas-text)}|\n  $0" "each do" nil nil nil nil "direct-keybinding" nil)
                       ("fi" ".form-group\n  = f.label :${1:name}\n  = f.${2:text}_field :$1, class: \"form-control\"" "field(bootstrap 3)" nil nil nil nil nil nil)
                       ("fi" "#field\n        =f.label :${1:name}\n        =f.${2:text_field} :$1\n$0" "field" nil nil nil nil nil nil)
                       ("flash" "- flash.each do |name, msg|\n  - if msg.is_a?(String)\n    .alert{\"class\" => \"alert-#{name == 'notice' ? 'success' : 'danger'}\"}\n      %a.close{\"data-dismiss\" => \"alert\"}= raw \"&#215;\"\n      = content_tag :div, msg, :id => \"flash_#{name}\"" "flash(bootstrap3)" nil nil nil nil nil nil)
                       ("form" "= form_for ${1:object} do |f|\n\n  $0\n\n  .form-group.button-group\n    = f.submit ${2:\"저장\"}, class: \"btn btn-default\"" "form" nil nil nil nil nil nil)
                       ("html" "!!! 5\n%html\n  %head\n    %meta{:name => \"viewport\", :content => \"width=device-width, initial-scale=1, maximum-scale=1\"}\n    %title= content_for?(:title) ? yield(:title) : \"${1:app_name}\"\n    %meta{:content => content_for?(:description) ? yield(:description) : \"$1\", :name => \"description\"}\n    = stylesheet_link_tag :application, :media => \"all\"\n    = javascript_include_tag :application\n    = csrf_meta_tags\n    = yield(:head)\n  %body\n    .container\n      = yield\n" "html" nil nil nil nil nil nil)
                       ("cl" "`(delete-char (- (skip-chars-backward \" \")))`.label.label-${1:info}$0\n" "label" nil nil nil nil nil nil)
                       ("ll" "\"${1:class}\" => \"$2\"" "ll" nil nil nil nil nil nil)
                       ("nav" "%nav.navbar.navbar-default{\"role\" => \"navigation\"}\n  .container-fluid\n    .navbar-header\n      %button.navbar-toggle{\"type\" => \"button\", \"data-toggle\" => \"collapse\", \"data-target\" => \"#navbar-collapse-1\"}\n        %span.sr-only Toggle navigation\n        %span.icon-bar\n        %span.icon-bar\n        %span.icon-bar\n      %a.navbar-brand{\"href\" => \"#\"}${1:brand}\n    #navbar-collapse-1.collapse.navbar-collapse\n      %ul.nav.navbar-nav\n        %li.active= link_to \"Dashboards\", dashboards_path" "nav init (bootstrap 3)" nil nil nil nil nil nil)
                       ("bo3" ".panel.panel-info\n  .panel-heading ${1:title}\n  .panel-body ${2:body}\n  .panel-footer ${3:footer}\n" "panel" nil nil nil nil nil nil)
                       ("su" ".form-group.button-group\n  = f.submit \"${1:저장}\", class: \"btn btn-default\"" "submit(bootstrap 3)" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Sep  4 12:59:22 2014
