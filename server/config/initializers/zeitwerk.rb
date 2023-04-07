Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
   'repo'        => 'repos'
  )
end
