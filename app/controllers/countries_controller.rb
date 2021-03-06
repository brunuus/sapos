# encoding: utf-8
# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class CountriesController < ApplicationController
  authorize_resource

  active_scaffold :country do |config|
    config.list.sorting = {:name => 'ASC'}
    config.list.columns = [:name]
    config.create.label = :create_country_label
    config.create.columns = [:name]
    config.update.label = :update_country_label
    config.update.columns = [:name]
  end

end 