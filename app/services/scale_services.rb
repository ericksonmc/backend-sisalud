# frozen_string_literal: true

class ScaleServices
  def initialize(eventualities: [], date_from: nil, date_to: nil)
    @date_from = date_from
    @date_to = date_to
    @eventualities = eventualities.blank? ? eventualities_ids : eventualities
  end

  def scale_consumption_graph
    EventualityExpense.select('scale_id, count(scale_id) as scale_count, (select title from '\
                              'scales where id = eventuality_expenses.scale_id) as title, '\
                              'sum(amount) as total')
                      .where(eventuality_id: @eventualities)
                      .order(:scale_count)
                      .group(:scale_id)
                      .map { |i| [i.title, i.scale_count, i.total] }
  end

  private

  def eventualities_ids
    Eventuality.where(created_at: date_range).ids
  end

  def date_range
    return unless @date_to.present?

    date_from = @date_from.to_time.beginning_of_day
    date_to = @date_to.to_time.end_of_day

    [date_from..date_to]
  end
end
