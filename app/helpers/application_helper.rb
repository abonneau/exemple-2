module ApplicationHelper

	#retourner le lien du logo
	def logo
		logo = image_tag("logo.png", :alt => "Application exemple", :class => "round")
	end
	
	#retourner un titre basé sur la page
	def titre
		base_titre = "Simple App du Tutoriel Ruby on Rails"
		if @titre.nil?
			base_titre
		else
			"#{base_titre} | #{@titre}"
		end
	end

	#modification de la methode pluralise pour le pluriel français
	def pluralize(count, singular, plural = nil) 
         "#{count} " + if count.to_i <= 1 
                singular 
        elsif plural 
                plural 
        elsif Object.const_defined?( "Inflector") 
                Inflector.pluralize(singular) 
        else 
                singular + "s" 
        end 
    end 

end
