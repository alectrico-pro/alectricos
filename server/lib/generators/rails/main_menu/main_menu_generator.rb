class Rails::MainMenuGenerator < Rails::Generators::NamedBase
  def create_main_menu_file
    create_file "app/views/#{class_name.to_s.deconstantize.downcase}/#{plural_name}/_main_menu.html.haml", <<-FILE
%nav.navbar.navbar-toggleable-xl.top.bg-light.navbar-light.top{:style => "background-color: #e3f2fd; z-index: 150"}
  .nav-item.nav-link= link_to('<span class="glyphicon glyphicon-bookmark"></span> <span class= hidden-sm-down> #{plural_name} </span>'.html_safe, #{plural_name}_path,:id => '#{plural_name}')

    FILE
   route "#{class_name.to_s.deconstantize.length > 1 ? ("scope module: #{class_name.to_s.deconstantize.downcase} do") : '' } 
     resources :#{plural_name} do
       member do
         get 'download_pdf'
       end
     end
  #{class_name.to_s.deconstantize.length >1 ? 'end' : ''}"
  end

end
