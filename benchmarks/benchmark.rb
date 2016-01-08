require 'rspec'
require "#{Dir.pwd}/spec/spec_helper"

module BenchmarkBase
  def self.benchmark
    puts "Starting benchmarks..."
    puts "Creatings Users and associations"
    
    group_number = 0
    groups = []
    
    [10, 50, 100, 1000].each do |x|
      FactoryGirl.create_list(:user, x, :with_associations, group: group_number)
      FactoryGirl.create_list(:user, x, :with_associations, group: (group_number + 1))
      
      groups[group_number] = User.where(group: group_number)
      groups[group_number + 1] = User.where(group: group_number + 1)
      
      group_number += 2
    end
    
    Benchmark.bm do |bm|
      groups.each_with_index do |group, index|
        if index.even?
          puts
          puts "Destroy #{group.count} users with #mass_destroy"
          bm.report { group.mass_destroy }
        else
          puts "Destroy #{group.count} users with #destroy_all"
          bm.report { group.destroy_all }
        end
      end
    end
    puts
  end
end
