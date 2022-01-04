# frozen_string_literal: true

module Api
  module V1
    class DashboardController < ApiController
      def index
        data = {
          payment_fee_total: payment_fee_total,
          total_customers: total_customers,
          eventualities_total: eventualities_total,
          new_customers_total: new_customers_total,
          emergency_eventualities: emergency_eventualities,
          scale_consumption_graph: scale_consumption_graph,
          eventuality_types_graph: eventuality_types_graph,
          best_selling_plans_graph: best_selling_plans_graph,
        }
        render json: data
      end

      def payment_fee_total
        @payment_feed_total ||= Customer.all.reduce(0) do |memo, data|
          if data.payment_fee.present?
            memo + data.payment_fee.to_f 
          else
            memo + data&.plan&.payment_fee.to_f
          end
        end
      end

      def total_customers
        @total_customers ||= Customer.count
      end

      def eventualities_total
        @eventualities_total ||= Eventuality.where(created_at: set_interval(params[:event_total_interval]))
                                            .where(aasm_state: 'closed')
                                            .sum(:amount)
      end

      def new_customers_total
        @new_customers_total ||= Customer.where(created_at: set_interval(params[:new_custtomer_interval])).count
      end

      def emergency_eventualities
        @emergency_eventualities ||= Eventuality.emergencies.order(id: :DESC).limit(10).map do |event|
          {
            customer: event.customer.full_name,
            total: event.amount,
            remaining_coverage: event.customer.remaining_coverage,
            coverage_referencen: event.customer.coverage_reference || event.customer.plan.coverage,
            id: event.id,
            date: event.date
          }
        end
      end

      def eventuality_types_graph
        @eventuality_types_graph ||= Eventuality.select("event_type, count(event_type)")
                                                .where(created_at: set_interval(params[:event_type_graph_interval]))
                                                .group(:event_type)
      end

      def best_selling_plans_graph
        @best_selling_plans_graph ||= Customer.select("count(plan_id), (select title from plans where id = customers.plan_id) as title")
                                      .group(:plan_id)
                                      .map do |plan|
                                        {
                                          title: plan.title.present? ? plan.title : 'No Plan',
                                          count: plan.count,
                                        }
                                      end
      end

      def scale_consumption_graph
        @scale_consumption_graph ||= EventualityExpense.select('scale_id, count(scale_id) as scale_count, (select title from '\
                                                               'scales where id = eventuality_expenses.scale_id) as title, '\
                                                               'sum(amount) as total')
                                                       .where.not(id: [54, 31, 32])
                                                       .where(created_at: set_interval(params[:scale_consumption_interval]))
                                                       .order(:scale_count)
                                                       .group(:scale_id)
      end

      private

      def set_interval(param)
        interval = param || 'week'
        case param
        when 'day'
          return [Time.now.beginning_of_day..Time.now.end_of_day]
        when 'week'
          [Time.now.beginning_of_week..Time.now.end_of_week]
        when 'month'
          [Time.now.beginning_of_month..Time.now.end_of_month]
        when 'year'
          [Time.now.beginning_of_year..Time.now.end_of_year]
        end
      end
    end
  end
end
