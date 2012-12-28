require 'open3'
module Grit

  class Repo

    def stashes(branch='master')
      Grit::Stash.find_all(self, branch)
    end

    def pop_first_at(branch_name)
      stashes = self.stashes(branch_name)
      if stashes.length > 1
        raise Exception.new("branch has too many stashes")
      else
        stashes.first.try(:pop)
      end
    end

    def create_stash
      Dir.chdir(self.working_dir) do
        `git stash`
      end
    end

    def checkout_to(branch_name)
      Dir.chdir(self.working_dir) do
        Open3.popen3("git checkout #{branch_name}")
      end
    end

    def create_branch(branch_name)
      Dir.chdir(self.working_dir) do
        #`git branch #{branch_name}`
        Open3.popen3("git branch #{branch_name}")
      end
    end
    def add_u
      Dir.chdir(self.working_dir) do
        `git add -u`
      end
    end
  end

  class Stash
    attr_accessor :id, :branch, :repo
    def initialize(repo, rev, id, branch)
      @repo, @rev, @id, @branch = repo, rev, id, branch
    end
    def self.find_all(repo, branch)
      output = repo.git.native :stash, {}, "list"
      self.list_from_string(repo, output, branch)
    end

    def self.list_from_string(repo, text, branch)
      stashes = []
      lines = text.split("\n")
      lines.each do |line|
        l_branch = line.split[3].delete(":")
        id = line.split[4]
        rev = line.split[0].delete(":")
        stashes << Stash.new(repo, rev, id, branch) if branch == l_branch
      end
      stashes
    end

    def pop
      Dir.chdir(@repo.working_dir) do
        `git stash pop #{@rev}`
      end
    end

    def destroy
      Dir.chdir(@repo.working_dir) do
        `git stash drop #{@rev}`
      end
    end
  end

end
