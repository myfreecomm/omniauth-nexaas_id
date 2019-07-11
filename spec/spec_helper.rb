$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'byebug'
require 'omniauth-nexaas_id'

OmniAuth.config.test_mode = true
