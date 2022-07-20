require 'twilio-ruby'
class SmsController 
    before_action :client

    def self.send_message (message = "Hello")
        @client.messages.create(
            from: '+19202395109',
            to: '+917356610002',
            body: message
          )
    end
    def client
        @client = Twilio::REST::Client.new account_sid, auth_token
    end

    def account_sid
        @account_sid = 'AC761fde7cea01ddcd24f979f27292ddec'
    end

    def auth_token
        @auth_token = 'f43fae5309569e421d54d21757e57492'
    end
end
