require 'rails_helper'

describe GameResultService do
  let(:user_bet)     { 'rock' }
  let(:service)   { GameResultService.new(user_bet) }
  let(:json_parser_error) { 'RPS API - Empty or unparsable response returned' }
  let(:result_arr) { [1, 0, -1] }

  describe '#run' do
    context 'API returns status code 200' do
      context 'API response is parsable' do
        before do
          stub_request(:get, "#{ENV['RPS_API_URL']}/throw")
            .to_return(
              status: 200,
              body: JSON.dump(
                statusCode: 200,
                body: 'rock'
              ),
              headers: {'Content-Type' => 'application/json'}
            )
        end

        it 'returns result message and computer bet' do
          result, computer_bet = service.call
          expect(result).to eq(0)
          expect(computer_bet).to eq(:rock)
        end
      end

      context 'API response is unparsable' do
        it 'log error and returns result message and computer bet' do
          expect(Rails.logger).to receive(:error).with(json_parser_error)
          stub_request(:get, "#{ENV['RPS_API_URL']}/throw")
            .to_return(
              status: 200,
              body: 'rock',
              headers: {'Content-Type' => 'application/json'}
            )
            .and_raise(JSON::ParserError)
          result, computer_bet = service.call
          expect(GameResultService::RULES.keys).to include(computer_bet)
          expect(result_arr).to include(result)
        end
      end
    end

    context 'API returns status code 500' do
      it 'log error and returns result message and computer bet' do
        response_body = JSON.dump(
          statusCode: 500,
          body: 'Something went wrong. Please try again later.'
        )
        rest_error = RestClient::InternalServerError.new
        expect(Rails.logger).to receive(:error).with("#{rest_error.class}: 500 #{rest_error.message}")
        expect(Rails.logger).to receive(:error).with(response_body)
        @request = stub_request(:get, "#{ENV['RPS_API_URL']}/throw")
          .to_return(
            status: 500,
            body: response_body,
            headers: {'Content-Type' => 'application/json'}
          )
          .and_raise(rest_error)
        result, computer_bet = service.call
        expect(GameResultService::RULES.keys).to include(computer_bet)
        expect(result_arr).to include(result)
      end
    end
  end
end
