module Emailer
  module StatusController
    def self.included(base)
      base.get "/status/routes" do
        out = []
        App.each_route do |route|
          out << route.verb + " " + route.path
        end
        out.join("<br>")
      end

      base.get "/status/info" do
        revision = `git rev-parse --short --verify HEAD`.chomp
        {
          :git_revision => revision,
          :git_local_branch => `git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \\(.*\\)/\\1/'`.chomp,
          :git_committed_at => `git show -s --format="%ci" #{revision}`.chomp,
          :git_commit_message => `git log -1 --pretty=format:"%s"`.chomp,
          :git_remote_branches => `git branch --no-color -r --contains #{revision} | grep -v 'HEAD' | tr -cs "[:print:]" " "`.chomp
        }.to_s
      end
    end
  end
end
