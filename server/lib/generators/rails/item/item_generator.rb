class Rails::ItemGenerator < Rails::Generators::NamedBase
  def create_item_file
    create_file "app/views/#{class_name.to_s.deconstantize.downcase}/#{plural_name}/_#{plural_name.singularize}.html.haml", <<-FILE
.col-12.col-xs-12.col-sm-12.col-md-6.col-lg-4
  .portfolio-item
    %nav.nav.navbar-toggler.navbar-light.bg-faded.nav-bar-justified
      .nav-item.nav-link= #{plural_name.singularize}.id 
      .nav-item.nav-link= link_to('<span class="glyphicon glyphicon-eye-open"></span>'.html_safe,#{plural_name.singularize})
    .portfolio-imagen
      = #{plural_name.singularize}.class 

 
    FILE
  end

end
