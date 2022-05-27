require 'rubygems'
require 'twilio-ruby'
require 'pry'

class SendSms
  def initialize(product:)
    @product     = product
    @message     = "Uwaga produktu '#{@product.name}' zostało #{@product.percent_resource}%"
    @account_sid = 'ACcc939ec78ac64513cff5c7cc7c5acf48'
    @auth_token  = 'ad0864a1269d4d2eec284c53497e9c2c'
    @client      = Twilio::REST::Client.new(@account_sid, @auth_token)
    @service_sid = 'MG9e3900d770d68d274d0642c550fbf4b7'
  end

  def call
    @client.messages.create(
      body:                  @message,
      messaging_service_sid: @service_sid,
      to:                    '+48503033181'
    )
  end
end
