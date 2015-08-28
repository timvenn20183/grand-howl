Rails.application.routes.draw do

	root 'main#index'

	match 'print/:id' => 'main#print', via: :get
	match 'entries' => 'main#myentries', via: :get
    match 'updates' => 'main#updates', via: :get
    match 'welcome' => 'main#welcome', via: :get
	match 'myvenues' => 'main#myvenues', via: :get
	match 'myprograms' => 'main#myprograms', via: :get
	match 'mysettings' => 'main#mysettings', via: :get

	match 'admin' => 'admin#index', via: :get
	match 'admin/users' => 'admin#users', via: :get
	match 'admin/badges' => 'admin#badges', via: :get
    match 'admin/categories' => 'admin#categories', via: :get
    match 'admin/advancements' => 'admin#advancements', via: :get
    match 'admin/help' => 'admin#help', via: :get
    match 'admin/entries' => 'admin#entries', via: :get
    match 'admin/venues' => 'admin#venues', via: :get
    match 'admin/programs' => 'admin#programs', via: :get

    match 'contact' => 'main#contact', via: :get
    match 'entry_comment' => 'main#entry_comment', via: :post
    match 'contact_process' => 'main#process_contact', via: :post
    match 'contact_success' => 'main#contact_success', via: :get

	match 'login' => 'main#login', via: :get
	match 'logout' => 'main#logout', via: :get
	match 'loginprocess' => 'main#loginprocess', via: :post
	match 'registerprocess' => 'main#registerprocess', via: :post
	match 'register' => 'main#register', via: :get

	match 'badges/:id' => 'badges#destroy', via: :delete
	match 'badges/:id/edit' => 'badges#edit', via: :post
	match 'badges/view/:id' => 'badges#show', via: :get
	match 'badges/:id' => 'badges#new', via: :get
	match 'badges/pdf/:id' => 'badges#pdf', via: :get

	match 'categories/:id' => 'categories#destroy', via: :delete
	match 'categories/:id' => 'categories#edit', via: :post
	match 'categories/custom_update' => 'categories#custom_update', via: :get
    match 'categories/list' => 'categories#list', via: :get
	match 'search' => 'entries#search', via: :post
	match 'search' => 'entries#search', via: :get

	match 'advancements/:id' => 'advancements#destroy', via: :delete
	match 'advancements/:id' => 'advancements#edit', via: :post
	match 'advancements/view/:id' => 'advancements#show', via: :get
	match 'advancements/:id' => 'advancements#new', via: :get
	match 'advancements/pdf/:id' => 'advancements#pdf', via: :get

	match 'entries/:id' => 'entries#destroy', via: :delete
	match 'entries/:id' => 'entries#edit', via: :post
	match 'entries/report/:id' => 'entries#report', via: :get
    match 'entries/remove_image/:id' => 'entries#remove_image', via: :delete
    match 'entries/tokensearch' => 'entries#tokensearch', via: :get

    match 'users/disable' => 'users#disable', via: :get

	match 'venues/:id' => 'venues#destroy', via: :delete
	match 'venues/pdf/:id' => 'venues#pdf', via: :get
    match 'venues/:id/edit' => 'venues#edit', via: :post
    match 'venues/remove_image/:id' => 'venues#remove_image', via: :delete
    match 'venue_comment' => 'main#venue_comment', via: :post

	match 'programs/:id' => 'programs#destroy', via: :delete
	match 'programs/pdf/:id' => 'programs#pdf', via: :get
    match 'programs/:id/edit' => 'programs#edit', via: :post
    match 'programs/remove_image/:id' => 'programs#remove_image', via: :delete
    match 'program_comment' => 'main#program_comment', via: :post
    match 'programs/update_assoc' => 'programs#update_assoc', via: :get
    match 'programs/add_entry' => 'programs#add_entry', via: :post
    match 'programs/entry/entry_down' => 'programs#entry_down', via: :get
    match 'programs/entry/entry_up' => 'programs#entry_up', via: :get
    match 'programs/entry/custom_time' => 'programs#custom_time', via: :get
    match 'programs/entry/update_linksentence' => 'programs#update_linksentence', via: :get
    match 'programs/entry/view_link_sentences' => 'programs#view_link_sentences', via: :get
    match 'programs/entry/update_start_date' => 'programs#update_start_date', via: :get
    match 'programs/entry/update_end_date' => 'programs#update_end_date', via: :get
    match 'programs/entry/update_scouter_entry' => 'programs#update_scouter_entry', via: :get
    match 'programs/daybreaks/update_daybreak' => 'programs#update_daybreak', via: :get
    match 'programs/daybreaks/drop_entry' => 'programs#drop_entry', via: :get

	resources :badges
	resources :advancements
	resources :categories
	resources :cattypes
	resources :entries
    resources :documents
    resources :venues
    resources :programs

end
