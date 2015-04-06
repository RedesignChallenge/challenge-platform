# Be sure to restart your server when you modify this file.

Rails.application.config.session_store ActionDispatch::Session::CacheStore, key: "_#{I18n.t(:project_name)}_session"
