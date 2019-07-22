# frozen_string_literal: true

module BundleOnly
  module Messages
    module Install
      # Ref: https://github.com/bundler/bundler/blob/d0d3f2786149cbaca6506b95e4be91be98161c15/lib/bundler/cli/install.rb

      def self.dependencies_count_for(definition)
        count = definition.dependencies.count
        "#{count} Gemfile #{count == 1 ? 'dependency' : 'dependencies'}"
      end

      def self.gems_installed_for(definition)
        count = definition.specs.count
        "#{count} #{count == 1 ? 'gem' : 'gems'} now installed"
      end

      def self.output_installation_complete_message(definition)
        Bundler.ui.confirm "Bundle complete! #{dependencies_count_for(definition)}, #{gems_installed_for(definition)}."
      end
    end

    module Common
      # Ref: https://github.com/bundler/bundler/blob/d0d3f2786149cbaca6506b95e4be91be98161c15/lib/bundler/cli/common.rb

      def self.output_post_install_messages(messages)
        return if Bundler.settings['ignore_messages']

        messages.to_a.each do |name, msg|
          print_post_install_message(name, msg) unless Bundler.settings["ignore_messages.#{name}"]
        end
      end

      def self.print_post_install_message(name, msg)
        Bundler.ui.confirm "Post-install message from #{name}:"
        Bundler.ui.info msg
      end

      def self.output_without_groups_message(command)
        return if Bundler.settings[:without].empty?

        Bundler.ui.confirm without_groups_message(command)
      end

      def self.without_groups_message(command)
        command_in_past_tense = command == :install ? 'installed' : 'updated'
        groups = Bundler.settings[:without]
        group_list = [groups[0...-1].join(', '), groups[-1..-1]]
                     .reject { |s| s.to_s.empty? }.join(' and ')
        group_str = groups.size == 1 ? 'group' : 'groups'
        "Gems in the #{group_str} #{group_list} were not #{command_in_past_tense}."
      end
    end
  end
end
