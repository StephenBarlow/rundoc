require 'test_helper'

class BashTest < Test::Unit::TestCase

  def test_bash_returns_cd
    original_dir = `pwd`
    Docdown::CodeCommands::Bash.new("cd ..").call
    now_dir      = `pwd`
    refute_equal original_dir, now_dir
  ensure
    Dir.chdir(original_dir.strip)
  end


  def test_bash_shells_and_shows_correctly
    ["pwd", "ls"].each do |command|
      bash  = Docdown::CodeCommands::Bash.new(command)
      assert_equal "$ #{command}", bash.to_md
      assert_equal `#{command}`,   bash.call
    end
  end
end
