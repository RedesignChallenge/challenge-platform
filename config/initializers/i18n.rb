require 'i18n/backend/recursive_lookup'
I18n::Backend::Simple.send(:include, I18n::Backend::RecursiveLookup)