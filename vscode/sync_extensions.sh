#!/usr/bin/env ruby
require 'set'

installed_extensions = Set.new(`code --list-extensions`.lines.map(&:chomp))
saved_extensions = Set.new(open("#{File.dirname $0}/extensions.txt").each_line.map(&:chomp))

install_extensions = saved_extensions - installed_extensions
uninstall_extensions = installed_extensions - saved_extensions

unless install_extensions.empty?
  system 'code', *install_extensions.map {|e| ['--install-extension', e]}.flatten
end

unless uninstall_extensions.empty?
  system 'code', *uninstall_extensions.map {|e| ['--uninstall-extension', e]}.flatten
end
