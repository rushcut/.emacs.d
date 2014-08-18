;;; Compiled snippets and support files for `nxml-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'nxml-mode
                     '(("arr" "<array>\n</array>\n" "Array" nil nil nil nil nil nil)
                       ("attr" "<key>$1</key>\n<$2>$3</$2>\n" "Attribute" nil nil nil nil nil nil)
                       ("output" "<dict>\n  <key>config</key>\n  <dict>\n    <key>plusspaces</key>\n    <false/>\n    <key>url</key>\n    <string>${1:url}</string>\n    <key>utf8</key>\n    <false/>\n  </dict>\n  <key>type</key>\n  <string>alfred.workflow.action.openurl</string>\n  <key>uid</key>\n  <string>`(insert-random-uuid)`</string>\n  <key>version</key>\n  <integer>0</integer>\n</dict>" "Open URL (Alfred)" nil nil nil nil nil nil)
                       ("input" "<dict>\n  <key>config</key>\n  <dict>\n    <key>argumenttype</key>\n    <integer>0</integer>\n    <key>escaping</key>\n    <integer>0</integer>\n    <key>keyword</key>\n    <string>${1:keyword}</string>\n    <key>title</key>\n    <string>${2:title}</string>\n    <key>subtext</key>\n    <string>${3:subtext}</string>\n    <key>runningsubtext</key>\n    <string>${4:running text}</string>\n    <key>script</key>\n    <string>${5:script}</string>\n    <key>type</key>\n    <integer>0</integer>\n    <key>withspace</key>\n    <true/>\n  </dict>\n  <key>type</key>\n  <string>alfred.workflow.input.scriptfilter</string>\n  <key>uid</key>\n  <string>`(insert-random-uuid)`</string>\n  <key>version</key>\n  <integer>0</integer>\n</dict>" "Script Filter (Alfred)" nil nil nil nil nil nil)
                       ("dict" "<dict>\n$0\n</dict>\n" "dictionary" nil nil nil nil nil nil)
                       ("pom" "<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n         xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">\n  <modelVersion>4.0.0</modelVersion>\n\n  <groupId>com.twentytoes.$1</groupId>\n  <artifactId>$2</artifactId>\n  <version>1.0-SNAPSHOT</version>\n  <packaging>jar</packaging>\n\n  <name>$3</name>\n  <url>http://maven.apache.org</url>\n\n  <properties>\n    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>\n  </properties>\n\n  <dependencies>\n    <dependency>\n	    <groupId>junit</groupId>\n	    <artifactId>junit</artifactId>\n	    <version>4.11</version>\n    </dependency>\n  </dependencies>\n\n  <build>\n    <plugins>\n      <plugin>\n        <groupId>org.apache.maven.plugins</groupId>\n        <artifactId>maven-jar-plugin</artifactId>\n        <version>2.3.1</version>\n        <configuration>\n          <archive>\n            <manifest>\n              <mainClass>$1.$2</mainClass>\n            </manifest>\n          </archive>\n        </configuration>\n      </plugin>\n    </plugins>\n  </build>\n</project>\n" "pom" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Aug 18 20:11:30 2014
