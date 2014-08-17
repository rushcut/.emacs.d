;;; Compiled snippets and support files for `objc-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'objc-mode
                     '(("syn" "@synthesize $1 = _$1;\n" "@synthesize _" nil nil nil nil nil nil)
                       ("sy" "@synthesize fetchedResultsController;\n" "@synthesize fetchedResultsController;" nil nil nil nil nil nil)
                       ("entity" "NSString* entityName = [[self.fetchedResultsController fetchRequest] entityName];" "EntityName from self.FetchedResultsController" nil nil nil nil nil nil)
                       ("frc" "/////////////////////////////////////////////////////////////////////////////////////\n//\n#pragma mark - NSFetchedResultsController\n//\n/////////////////////////////////////////////////////////////////////////////////////\n\n//////////////////////////////////////////////////////////////////////\n//\n- (NSFetchedResultsController *)fetchedResultsController {\n    if (fetchedResultsController_ != nil) {\n        return fetchedResultsController_;\n    }\n    NSFetchRequest* request = [[NSFetchRequest alloc] init];\n    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];\n    NSManagedObjectContext* managedObjectContext = [appDelegate managedObjectContext];\n    NSEntityDescription* entity = [NSEntityDescription entityForName:${1:entityName} inManagedObjectContext:managedObjectContext];\n    NSArray* sorts = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@\"Hero\" ascending:YES], nil];\n\n    [request setEntity:entity];\n    [request setFetchBatchSize:20];\n    [request setSortDescriptors:sorts];\n\n    NSString *sectionKey = nil;\n    NSFetchedResultsController* frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request\n                                                                          managedObjectContext:managedObjectContext\n                                                                            sectionNameKeyPath:sectionKey\n    cacheName:${2:$1}];\n    frc.delegate = self;\n    fetchedResultsController_ = frc;\n\n    NSError* error = nil;\n    if (![[self fetchedResultsController] performFetch:&error]) {\n        UIAlertView* alert = [[UIAlertView alloc]\n                               initWithTitle:NSLocalizedString(@\"Error saving entity\", @\"Error saving entity\")\n                                     message:[NSString stringWithFormat:NSLocalizedString(@\"Error waw: %@, quitting.\", @\"Error was: %@ quitting\"), [error description]]\n                                    delegate:self cancelButtonTitle:NSLocalizedString(@\"Aw, Nuts\", @\"Aw, Nuts\") otherButtonTitles: nil];\n        [alert show];\n\n    }\n    return fetchedResultsController_;\n}\n\n\n//////////////////////////////////////////////////////////////////////\n//\n- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {\n  [self.${10:tableView}ableView beginUpdates];\n}\n\n//////////////////////////////////////////////////////////////////////\n//\n- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {\n  [self.$10 endUpdates];\n}\n\n//////////////////////////////////////////////////////////////////////\n//\n- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {\n  switch (type) {\n  case NSFetchedResultsChangeInsert:\n    [self.$10 insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];\n    break;\n  case NSFetchedResultsChangeDelete:\n    [self.$10 deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];\n  default:\n    break;\n  }\n}\n\n//////////////////////////////////////////////////////////////////////\n//\n- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {\n     switch (type) {\n        case NSFetchedResultsChangeInsert:\n             [self.$10 insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];\n            break;\n        case NSFetchedResultsChangeDelete:\n            [self.$10 insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];\n        case NSFetchedResultsChangeUpdate:\n        case NSFetchedResultsChangeMove:\n            break;\n    }\n}" "FetchedResutsController" nil nil nil nil nil nil)
                       ("entity" "NSEntityDescription* entity = [[self.fetchedResultsController fetchRequest] entity];" "NSEntityDescription from self.fetchedResultsController" nil nil nil nil nil nil)
                       ("bbi" "[[UIBarButtonItem alloc] initWithBarButtonSystemItem:${1:$$(yas-choose-value `(\"UIBarButtonSystemItemDone\" \"UIBarButtonSystemItemCancel\" \"UIBarButtonSystemItemEdit\" \"UIBarButtonSystemItemSave\" \"UIBarButtonSystemItemAdd\" \"UIBarButtonSystemItemFlexibleSpace\" \"UIBarButtonSystemItemFixedSpace\" \"UIBarButtonSystemItemCompose\" \"UIBarButtonSystemItemReply\" \"UIBarButtonSystemItemAction\" \"UIBarButtonSystemItemOrganize\" \"UIBarButtonSystemItemBookmarks\" \"UIBarButtonSystemItemSearch\" \"UIBarButtonSystemItemRefresh\" \"UIBarButtonSystemItemStop\" \"UIBarButtonSystemItemCamera\" \"UIBarButtonSystemItemTrash\" \"UIBarButtonSystemItemPlay\" \"UIBarButtonSystemItemPause\" \"UIBarButtonSystemItemRewind\" \"UIBarButtonSystemItemFastForward\" \"UIBarButtonSystemItemUndo\" \"UIBarButtonSystemItemRedo\" \"UIBarButtonSystemItemPageCurl\"))} target:self action:@selector(${2:addObject:})]" "UIBarButtonItem alloc" nil nil nil nil nil nil)
                       ("view" "[${1:self}.view addSubview:${2:subView}];" "addSubView:" nil nil nil nil nil nil)
                       ("alert" "UIAlertView* alert = [[UIAlertView alloc]\n                       initWithTitle:NSLocalizedString(@\"Error saving entity\", @\"Error saving entity\")\n                             message:[NSString stringWithFormat:NSLocalizedString(@\"Error waw: %@, quitting.\", @\"Error was: %@ quitting\"), [error description]]\n                            delegate:self cancelButtonTitle:NSLocalizedString(@\"Aw, Nuts\", @\"Aw, Nuts\") otherButtonTitles: nil];\n[alert show];" "alert" nil nil nil nil nil nil)
                       ("app" "AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];" "appDelegate" nil nil nil nil nil nil)
                       ("ar" "[NSArray arrayWithObjects:$1, nil];\n" "arrayWithObjects" nil nil nil nil nil nil)
                       ("vat" "NSAttributedString* attributed${1:name} = [[NSAttributedString alloc]\n                                            initWithString:${2:string}\n                                       attributes:@{NSFontAttributeName: [UIFont fontWithName:@\"Copperplate-Bold\" size:23],\n                                                    NSForegroundColorAttributeName:[UIColor whiteColor],\n                                                    NSKernAttributeName: @(-2.0f)}];\n" "attributedString" nil nil nil nil nil nil)
                       ("cell" "cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:${1CellIdentifier}];" "cell" nil nil nil nil nil nil)
                       ("de" "describe(@\"${1:`(r-ext (buffer-name) \"\")`}\", ^{\n    $0\n});" "describe" nil nil nil nil nil nil)
                       ("for" "for(int ${1:i} = ${2:0}; $1 < ${3:length} ; $1++) {\n  $0\n}" "for" nil nil nil nil nil nil)
                       ("if" "if ( $1 ) {\n  $0\n}" "if" nil nil nil nil nil nil)
                       ("im" "#import \"$1.h\"" "import" nil nil nil nil nil nil)
                       ("in" "[[${1:NSObject} alloc] init$0];\n" "alloc init" nil nil nil nil nil nil)
                       ("init" "[[${1:NSObject} alloc] initWithFrame:CGRectMake($2)];\n" "initWithFrame" nil nil nil nil nil nil)
                       ("init" "self = [super init$1];\nif (self) {\n  $0\n}\nreturn self;" "initialize" nil nil nil nil nil nil)
                       ("ila" "// $1\n${1:_label} = [[UILabel alloc] init];\n[$1 setFont:[UIFont fontWithName:@\"Copperplate-Bold\" size:${2:13}]];\n[$1 setTextAlignment:NSTextAlignment${3:Center}];\n[$1 setTextColor:[UIColor ${4:white}Color]];\n[$1 setNumberOfLines:1];\n${5:[$1.layer setBorderColor:[UIColor ${6:white}Color].CGColor];\n[$1.layer setBorderWidth:1.5];\n}[self addSubview:$1];" "instance Label" nil nil nil nil nil nil)
                       ("it" "it(@\"${1:description}\", ^{\n    $0\n});" "it" nil nil nil nil nil nil)
                       ("log" "NSLog(${1:@\"${2:%@}\"}, ${3:obj});" "log" nil nil nil nil nil nil)
                       ("pr" "/////////////////////////////////////////////////////////////////////////////////////\n//\n#pragma mark - $1\n//\n/////////////////////////////////////////////////////////////////////////////////////" "pragma" nil nil nil nil nil nil)
                       ("nav" "[self.navigationController pushViewController:${1:controller} animated:${2:YES}];" "pushViewController" nil nil nil nil nil nil)
                       ("save" "NSError* error = nil;\nif (![context save:&error]) {\n  NSLog(@\"Unresolved error %@, %@\", error, [error userInfo]);\n  abort();\n}" "save" nil nil nil nil nil nil)
                       ("sectionkey" "switch (tabIndex) {\n    case kByName: {\n        NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@\"name\" ascending:YES];\n        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@\"secretIdentity\" ascending:YES];\n        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, nil];\n        [request setSortDescriptors:sortDescriptors];\n        sectionKey = @\"name\";\n        break;\n    }\n    case kBySecretIdentity:{\n        NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@\"secretIdentity\" ascending:YES];\n        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@\"name\" ascending:YES];\n        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, nil];\n        [request setSortDescriptors:sortDescriptors];\n        sectionKey = @\"secretIdentity\";\n        break;\n    }\n}\n" "sectionKey (tabbar)" nil nil nil nil nil nil)
                       ("cc" "//////////////////////////////////////////////////////////////////////\n//" "seperator" nil nil nil nil nil nil)
                       ("na" "[self.navigationController setNavigationBarHidden:${1:YES} animated:${2:NO}];" "setNavigationBarHidden" nil nil nil nil nil nil)
                       ("spec" "#import \"Kiwi.h\"\n\nSPEC_BEGIN(${1:`(r-ext (buffer-name) \"\")`})\n\n$0\n\nSPEC_END\n" "spec" nil nil nil nil nil nil)
                       ("tb" "/////////////////////////////////////////////////////////////////////////////////////\n//\n#pragma mark - UITabBarDelegate Methods\n//\n/////////////////////////////////////////////////////////////////////////////////////\n\n//////////////////////////////////////////////////////////////////////\n//\n- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {\n    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];\n    NSUInteger tabIndex = [tabBar.items indexOfObject:item];\n    [defaults setInteger:tabIndex forKey:kSelectedTabDefaultsKey];\n}\n" "tabbar delegate" nil nil nil nil nil nil)
                       ("tv" "/////////////////////////////////////////////////////////////////////////////////////\n//\n#pragma mark - UITableView DataSource\n//\n/////////////////////////////////////////////////////////////////////////////////////\n\n//////////////////////////////////////////////////////////////////////\n//\n- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {\n  ${1:return [[self.fetchedResultsController sections] count]};\n}\n\n//////////////////////////////////////////////////////////////////////\n//\n- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {\n  ${2:id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];\n    return [sectionInfo numberOfObjects];}\n}\n\n//////////////////////////////////////////////////////////////////////\n//\n- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {\n    static NSString* CellIdentifier = @\"${3:Cell}\";\n    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];\n    cell.textLabel.text = @\"${3:text}\";\n    return cell;\n}" "tableview (datasource)" nil nil nil nil nil nil)
                       ("cell" "cell.textLabel.text = $0\n" "textlabel" nil nil nil nil nil nil)
                       ("ni" "self.navigationItem.title = ${1:@\"Acquire\"};" "title" nil nil nil nil nil nil)
                       ("as" "[[theValue($1) should] equal:theValue($2)];" "value" nil nil nil nil nil nil)
                       ("var" "NSArray* ${1:array} = [NSArray arrayWithObjects:$2, nil];" "var" nil nil nil nil nil nil)
                       ("vin" "${1:NSObject}* ${1:$(s-lower-camel-case (replace-regexp-in-string \"^[A-Z][A-Z]\" \"\" yas-text))} = [[$1 alloc] init$0];\n" "assign with alloc init" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug 17 12:42:03 2014
