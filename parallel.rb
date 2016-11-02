#!/usr/bin/env ruby

require 'parallel'

Parallel.each(1..100, :in_processes => 50) do |i|
	puts "Item: #{i}, Worker: #{Parallel.worker_number}"
end