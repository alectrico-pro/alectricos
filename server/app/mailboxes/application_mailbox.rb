class ApplicationMailbox < ActionMailbox::Base 
  routing /@alectrico.cl\Z/i => :inbox
 #routing /^save@/i    => :forwards

# routing /@replies\./i => :replies
# routing /something/i => :somewhere
end
