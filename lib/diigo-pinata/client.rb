require 'net/http'
require 'net/https'
require 'open-uri'
require 'ostruct'
require 'pry'

module DiigoPinata
  class Client

    def initialize(username, password)
      @username = username
      @password = password
      @cookie = nil
    end

    def login
      data = "username=#{@username}&password=#{@password}&referInfo=https://www.diigo.com/user/#{@username}"
      resp = post('www.diigo.com', '/sign-in', data)

      cookie_str = resp.to_hash['set-cookie'].collect { |ea| ea[/^.*?;/] }.join
      if cookie_str.include? @username
        @cookie = cookie_str
        return true
      end

      false
    end

    def add_bookmark(url, title, tags, private, description)
      data = "url=#{url}&unread=false&title=#{title}&private=#{private}&description=#{description}&tags=#{tags}"
      resp = post('www.diigo.com', '/item/save/bookmark', data)

      check_response(resp)
    end

    private

    def check_response(resp)
      resp.code.to_i == 200 ? true : false
    end

    def post(host, path, data_to_post)
      http = Net::HTTP.new host, 443
      http.use_ssl = true

      unless @cookie
        resp, data = http.get(path)
        @cookie = resp.response['set-cookie']
      end

      headers = {
          'Cookie' => @cookie,
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'DiigoPinata'
      }

      http.post(path, URI::encode(data_to_post), headers)
    end
  end
end