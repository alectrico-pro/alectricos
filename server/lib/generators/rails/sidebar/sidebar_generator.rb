class Rails::SidebarGenerator < Rails::Generators::NamedBase
  def create_sidebar_file
    create_file "app/views/#{class_name.to_s.deconstantize.downcase}/#{plural_name}/_sidebar.html.haml", <<-FILE
-if params[:id] 
  .list-group-item
    = link_to 'Pdf',  download_pdf_#{plural_name.singularize}_path(@#{class_name.to_s.deconstantize.downcase}_#{plural_name.singularize})
  .list-group-item
    = link_to 'Ver',      @#{class_name.to_s.deconstantize.downcase}_#{plural_name.singularize}
-if params[:id]
  .list-group-item
    = link_to 'Editar',       edit_#{plural_name.singularize}_path(@#{class_name.to_s.deconstantize.downcase}_#{plural_name.singularize})
  .list-group-item
    = link_to 'Eliminar', @#{class_name.to_s.deconstantize.downcase}_#{plural_name.singularize}, method: :delete, data: { confirm: '¿Está seguro?' }

    FILE
   route "scope module: '#{class_name.to_s.deconstantize.downcase}' do
     resources :#{plural_name} do
       member do
         get 'download_pdf'
       end
     end
   end"
  end

end
