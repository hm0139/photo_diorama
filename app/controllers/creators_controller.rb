class CreatorsController < ApplicationController
  def index
    @creators = User.all
  end
end
