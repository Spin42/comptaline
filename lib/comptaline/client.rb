require "securerandom"

module Comptaline
  class Client
    attr_accessor :host_url, :username, :password

    def initialize(configuration)
      @host_url = configuration.host_url
      @username = configuration.username
      @password = configuration.password
    end

    def send(csv)
      file = make_file_for_multipart(csv)
      begin
        authenticated_request(:post, "OPERATIONS", { choice: "CSV" }, { fileName: file})
      ensure
        File.unlink(file.path)
      end
    end

    private

    def make_file_for_multipart(csv) 
      dir  = Comptaline.configuration.tmp_dir
      path = File.join(dir, "comptaline_#{SecureRandom.hex}.csv")
      File.open(path, "w:ISO-8859-1") { |file| file.write(csv) }
      File.new(path, :mode => "rb")
    end

    def authenticated_request(method, path, params = {}, payload = {})
      open_session
      params.merge!(sessionid: @session_id)
      result = request(method, path, params, payload)
      close_session
      result
    end

    def open_session
      result      = request(:get, "SESSION", choice: 1, username: @username, password: @password)
      @session_id = result["sessionid"]
    end

    def close_session
      request(:get, "SESSION", choice: 2, sessionid: @session_id)
    end

    def request(method, path, params = {}, payload = {})
      uri       = URI.join(@host_url, path)
      uri.query = URI.encode_www_form(params)

      RestClient.__send__(method, uri.to_s, payload) do |body, request, response|
        throw "Error while retreiving data #{body.inspect}" unless response.code == "200"
        result = Hash.from_xml(body)["response"]
        if result["status"] != "0"
          throw "Something went wrong: #{path}, #{params}, #{result}"
        else
          result
        end
      end
    end
  end
end