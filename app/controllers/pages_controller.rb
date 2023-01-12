class PagesController < ApplicationController
  def home
    coach_authenticate
  end
end
