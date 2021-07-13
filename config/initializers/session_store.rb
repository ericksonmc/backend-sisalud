# frozen_string_literal: true

# In order to work with devise JWT we need to disable session storage
Rails.application.config.session_store :disabled
