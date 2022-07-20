require 'twilio-ruby'
module Communify
    module Controllers
        class Sms 
            # attr_accessor :account_sid
            # attr_accessor :auth_token

            def self.send_message (message = "Hello")
                account_sid = "AC761fde7cea01ddcd24f979f27292ddec"
                auth_token = "0980820fdd28fef73801a2286dbf1147"
                @client = Twilio::REST::Client.new account_sid, auth_token
                @client.messages.create(
                    from: '+19202395109',
                    to: '+917356610002',
                    body: message
                )
            end
        end
    end
end
