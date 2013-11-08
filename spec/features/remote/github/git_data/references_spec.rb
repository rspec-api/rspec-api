require 'github_helper'

# http://developer.github.com/v3/git/refs
resource :ref do
  extend Authorize
  authorize_with token: ENV['RSPEC_API_GITHUB_TOKEN']

  has_attribute :ref, type: :string
  has_attribute :url, type: {string: :url}
  has_attribute :object, type: :object do
    has_attribute :type, type: :string
    has_attribute :sha, type: :string
    has_attribute :url, type: {string: :url}
  end

  get '/repos/:owner/:repo/git/refs/:ref' do
    request_with owner: existing(:user), repo: existing(:repo), ref: existing(:ref) do
    # NOTE: How about this syntax?
    # request_with 'Get a Reference', existing(owner: :user, repo: :repo, ref: :ref) do
      respond_with :ok
    end
  end

  get '/repos/:owner/:repo/git/refs', collection: true do
    request_with owner: existing(:user), repo: existing(:repo) do
      respond_with :ok
    end
  end

  # NOTE: A repo without /refs/heads will respond with 404
  get '/repos/:owner/:repo/git/refs/heads', collection: true do
    request_with owner: existing(:user), repo: existing(:repo) do
      respond_with :ok
    end
  end

  # NOTE: A repo without /refs/tags will respond with 404
  get '/repos/:owner/:repo/git/refs/tags', collection: true do
    request_with owner: existing(:user), repo: existing(:repo) do
      respond_with :ok
    end
  end

  # NOTE: A repo without /refs/pull will respond with 404
  get '/repos/:owner/:repo/git/refs/pull', collection: true do
    request_with owner: existing(:user), repo: existing(:repo) do
      respond_with :ok
    end
  end

  # NOTE: A repo without /refs/notes will respond with 404
  get '/repos/:owner/:repo/git/refs/notes', collection: true do
    request_with owner: existing(:user), repo: existing(:repo) do
      respond_with :ok
    end
  end


  # NOTE: Watch out!! These leave track in your public activity on GitHub !
  #
  # # NOTE: only works if the inner tests are executed in order
  # describe 'create and delete transaction' do
  #   name = ('a'..'z').to_a.sample(16).join
  #   # NOTE: only works if authorized by the current GitHub API key
  #   post '/repos/:owner/:repo/git/refs' do
  #     #request_with 'Create a Reference', owner: existing(:org), repo: existing(:repo_with_notes), ref: "refs/notes/#{name}", sha: '4d2376536140cb8db64845dc85ad5882f199808e' do
  #     request_with 'Create a Reference', owner: 'rails', repo: 'rails', ref: "refs/notes/#{name}", sha: '4d2376536140cb8db64845dc85ad5882f199808e' do
  #       respond_with :created
  #     end
  #   end
  #
  #   # NOTE: only works if authorized by the current GitHub API key
  #   delete '/repos/:owner/:repo/git/refs/:ref' do
  #     request_with 'Create a Reference', owner: existing(:org), repo: existing(:repo_with_notes), ref: "notes/#{name}" do
  #       respond_with :no_content
  #     end
  #   end
  # end
end