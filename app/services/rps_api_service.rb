# frozen_string_literal: true

class RpsApiService

  def self.call
    new.call
  end

  def call
    url = "#{ENV['RPS_API_URL']}/throw"

    RestClient::Request.execute(
      method: :get,
      url: url
    )
  end
end
