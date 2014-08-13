;;; Compiled snippets and support files for `web-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'web-mode
                     '(("each" "<% ${1:attrs}.each do |${2:${1:$(replace-regexp-in-string \"@\" \"\" (singularize-last-string text))}}| %>\n    $0\n<% end %>\n" "attrs each do |attr|" nil nil nil nil nil nil)
                       ("col" "<!-- $1 -->\n<div class=\"small-${3:2} large-${5:2} columns\">\n  <label for=\"id\" class=\"right inline\">${2:label}</label>\n</div>\n<div class=\"small-${4:10} large-${6:4} columns\">\n  ${2:value}\n</div>\n<!-- $1 ends here -->" "colum(zurb-foundation)" nil nil nil nil nil nil)
                       ("ea" "<% ${1:elements}.each do |${1:$(ruby-singularize-last-string text)}| %>\n  $0\n<% end %>\n" "each do |e|" nil nil nil nil nil nil)
                       (",," "<${1:p} class=\"${2:$(ruby-last-value text)}\"><%= ${2:attr} %></$1>" "expression with html tag" nil nil nil nil nil nil)
                       ("fi" "<!-- $1 -->\n<div class=\"small-${4:2} large-${6:2} columns\">\n  <%= f.label :${1:title}, \"${3:제목}\", class:\"right inline\" %>\n  </div>\n<div class=\"small-${5:10} large-${7:4} columns\">\n  <%= f.${2:text_field} :$1 %>\n  </div>\n<!-- $1 ends here -->" "field(zurb-foundation)" nil nil nil nil nil nil)
                       ("flash" "<% flash.each do |name, msg| %>\n  <% if msg.is_a?(String) %>\n    <div class=\"alert alert-<%= name == :notice ? \"success\" : \"danger\" %>\">\n      <a class=\"close\" data-dismiss=\"alert\">&#215;</a>\n      <%= content_tag :div, msg, :id => \"flash_#{name}\" %>\n    </div>\n  <% end %>\n<% end %>\n" "flash" nil nil nil nil nil nil)
                       ("form_for" "<%= form_for(${1:model}) do |f| %>\n  <% if $1.errors.any? %>\n    <div id=\"error_explanation\">\n      <h2><%= pluralize($1.errors.count, \"error\") %> prohibited this estate from being saved:</h2>\n      <ul>\n      <% $1.errors.full_messages.each do |msg| %>\n        <li><%= msg %></li>\n      <% end %>\n      </ul>\n    </div>\n  <% end %>\n\n  $0\n\n<% end %>" "form_for" nil nil nil nil nil nil)
                       ("if" "<% if $1 %>\n  $0\n<% end %>" "if" nil nil nil nil nil nil)
                       ("fi" "<!-- $1 -->\n<div class='small-2 large-2 columns'>\n  <%= f.label :$1, class: \"inline right\" %>\n</div>\n<div class='small-10 large-10 columns'>\n  <%= f.${2:text_field} :$1 %>\n</div>\n<!-- $1 ends here -->" "label-field 2-10 (zurb)" nil nil nil nil nil nil)
                       ("le" "<legend>$1</legend>" "legend" nil nil nil nil nil nil)
                       ("link" "<%= link_to ${1:display}, ${2:path} %>" "link_to" nil nil nil nil nil nil)
                       ("script" "<script type=\"text/javascript\">\n        $0\n</script>" "javascript" nil nil nil nil nil nil)
                       ("script" "<script type=\"text/x-handlebars\" data-template-name=\"${1:todos}\">\n        $1\n</script>" "handlebars" nil nil nil nil nil nil)
                       ("select" "<%= f.select :${1:attribute}, ${2:${1:$(capitalize text)}}.all.map {|${3:e}| [$3.name, $3.id]}${4:, {include_blank: true}} %>" "select_tag" nil nil nil nil nil nil)
                       ("su" "<!-- submit -->\n<div class=\"row\">\n  <div class=\"small-12 large-12 text-center columns\">\n    <br /><%= f.submit \"저장\", class: \"button small\" %>\n  </div>\n</div>\n<!-- submit ends here -->\n" "submit(zurb-foundation)" nil nil nil nil nil nil)
                       ("su" "<div class=\"actions\">\n  <%= f.submit \"${1:저장}\"${2:, class: \"btn btn-success\"} %>\n</div>" "submit_tag" nil nil nil nil nil nil)
                       ("fi" "<div class=\"field\">\n  <%= f.label :${1:attr} %>\n  <%= f.text_field :$1 %>\n</div>" "text_field" nil nil nil nil nil nil)
                       ("fi" "<div class=\"form-group\">\n  <%= f.label :${1:attr} %>\n  <%= f.${2:text_field} :$1, class: \"form-control\", placeholder: \"${3:palceholder}\" %>\n</div>" "text_field(bootstrap3)" nil nil nil nil nil nil)
                       ("," "{{$0}}" "{{}" nil nil nil nil nil nil)
                       ("." "{{$1}}$0" "{{}}" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Fri Aug  8 10:08:47 2014
