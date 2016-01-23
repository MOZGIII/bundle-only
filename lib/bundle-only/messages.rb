module BundleOnly
  module Messages
    module_function

    def without_groups_message(groups)
      group_list = [groups[0...-1].join(', '), groups[-1..-1]]
                   .reject { |s| s.to_s.empty? }.join(' and ')
      group_str = (groups.size == 1) ? 'group' : 'groups'
      "Gems in the #{group_str} #{group_list} were not installed."
    end

    def confirm_without_groups
      groups = Bundler.settings.without
      Bundler.ui.confirm without_groups_message(groups) if groups.any?
    end

    def dependencies_count_for(definition)
      count = definition.dependencies.count
      "#{count} Gemfile #{count == 1 ? 'dependency' : 'dependencies'}"
    end

    def gems_installed_for(definition)
      count = definition.specs.count
      "#{count} #{count == 1 ? 'gem' : 'gems'} now installed"
    end

    def print_post_install_message(name, msg)
      Bundler.ui.confirm "Post-install message from #{name}:"
      Bundler.ui.info msg
    end

    def print_installation_complete(definition)
      Bundler.ui.confirm "Bundle complete! #{dependencies_count_for(definition)}, #{gems_installed_for(definition)}."
    end
  end
end
