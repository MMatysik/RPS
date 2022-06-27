# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_throw_options

  def show
    render 'new', layout: false
  end

  def create
    @user_bet = params[:user_bet]
    @result, @computer_bet = GameResultService.new(@user_bet).call
    render 'new', layout: false
  end

  def new
    render layout: false
  end

  private

  def set_throw_options
    @throw_options = GameResultService::RULES.keys
  end
end
