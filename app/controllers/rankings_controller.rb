class RankingsController < ApplicationController
  def index
    @bestusers = User.all.order(:karma).reverse!
  end
end
