require 'json'
require 'httparty'

class BigFiveResultsPoster
    attr_accessor :results, :email

    def initialize (results, email)
        @results = results
        @email = email
    end

    def post
        headers = {
            "Content-Type" => "application/json",
            "Accept" => "application/json"
        }

        @results['EMAIL'] = @email
        response = HTTParty.post(
            "https://recruitbot.trikeapps.com/api/v1/roles/senior-team-lead/big_five_profile_submissions",
            body: @results.to_json,
            headers: headers)

        puts "response: #{response.inspect}"
        return false if response.code != 201
        OpenStruct.new(:response_code => response.code, :token => response.parsed_response)
    end
end
