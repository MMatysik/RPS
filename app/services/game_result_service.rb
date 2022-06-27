# frozen_string_literal: true

class GameResultService
  attr_reader :user_bet

  RULES = {
    rock: :scissors,
    paper: :rock,
    scissors: :paper
  }.freeze

  def self.call(user_bet)
    new(user_bet).call
  end

  def initialize(user_bet)
    @user_bet = user_bet
  end

  def call
    computer_bet = server_throw
    result = if RULES[user_bet.to_sym] == computer_bet
               1
             elsif user_bet.to_sym == computer_bet
               0
             else
               -1
             end
    [result, computer_bet]
  end

  private

  def server_throw
    response = RpsApiService.call
    parsed_response = JSON.parse(response)
    parsed_response['body'].to_sym
  rescue JSON::ParserError
    Rails.logger.error 'RPS API - Empty or unparsable response returned'
    RULES.keys.sample
  rescue => e
    message = "#{e.class}: #{e.message}"
    response = "#{e.response}" if e.respond_to?(:response)
    Rails.logger.error message
    Rails.logger.error response
    RULES.keys.sample
  end
end
