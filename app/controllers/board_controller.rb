class BoardController < ApplicationController
  def get_ids
  	ids = User.pluck(:id)       # User.pluck(:champ) va chercher toutes les instances de :champ dans la table User, puis le transforme en array
  	@fate = ids.shuffle[0..1]   # On met ca dans une variable, puis on shuffle cette variable (on sort 2 valeurs au hasard de l'array)
  	return @fate 
  end

  def new
  	candidate_1_id = @fate[0]   # @fate = 2 valeurs aléatoires que l'o va utiliser en tant que id pour le candidate 1 et 2
  	candidate_2_id = @fate[1]
  end
end
