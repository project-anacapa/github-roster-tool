module Strategies
  class GitHubStrategy < Strategies::GitStrategy

    def initialize(token)
      @token = token
      if @token == nil
        @client = Octokit::Client.new \
                    :client_id => ENV['OMNIAUTH_PROVIDER_KEY'],
                    :client_secret => ENV['OMNIAUTH_PROVIDER_SECRET']
      else
        @client = Octokit::Client.new \
                    :access_token => @token
      end
    end

    def is_valid
      begin
        @client.check_application_authorization @token
        true
      rescue
        false
      end
    end

    def emails
      @client.emails
    end

    def profile_img_url(uid)
      "https://avatars2.githubusercontent.com/u/#{uid}"
    end

    def org(name)
      @client.org(name)
    end

    def org_membership(name, params={})
      @client.org_membership(name, params)
    end

    def org_memberships
      @client.org_memberships
    end

    def update_org_membership(name, params={})
      @client.update_org_membership(name, params)
    end

  end
end