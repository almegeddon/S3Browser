require 'test_helper'

class BucketsControllerTest < ActionController::TestCase
  test "build prefix links" do
    path = "dev-clario/"
    prefix = "5002/projects/workbench"
    paths = prefix.split('/')
    paths.each_index do |x|
      if x + 1 == paths.length
        puts "no link for: #{paths[x]}"
      else
        path += "#{paths[x]}/"
        puts "link for: #{path}"
      end
    end
  end

end
