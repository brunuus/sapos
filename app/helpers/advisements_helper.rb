#coding: utf-8
# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

module AdvisementsHelper
  include PdfHelper
  include AdvisementsPdfHelper 
  def active_search_column(record,options)
    select(record, :active, [["Todas","all"],["Ativas","active"],["Inativas","not_active"]], options, options)
  end

  def co_advisor_search_column(record,options)
    select(record, :co_advisor, [[I18n.t("active_scaffold._select_"),"all"],["Sim","sim"],["Não","nao"]], options, options)
  end

  def level_search_column(record,options)
    levels = [["Todos",nil]]
    levels += Level.all.map { |level| [level.name,level.id]}
    select(record, :level, levels, options,options)
  end

  def professor_form_column(record, options)
    record_select_field :professor, record.professor || Professor.new, options.merge!(class: "text-input")
  end

  def enrollment_form_column(record, options)
    record_select_field :enrollment, record.enrollment || Enrollment.new, options.merge!(class: "text-input")
  end
end