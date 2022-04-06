# frozen_string_literal: true

module Api
  module V1
    class DashboardController < ApiController
      def index
        data = {
          total_customers: total_customers,
          payment_fee_total: payment_fee_total,
          eventualities_total: eventualities_total,
          new_customers_total: new_customers_total,
          emergency_eventualities: emergency_eventualities,
          scale_consumption_graph: scale_consumption_graph,
          eventuality_types_graph: eventuality_types_graph,
          best_selling_plans_graph: best_selling_plans_graph,
        }
        render json: data
      end

      def total_customers
        @total_customers ||= customers_count
      end

      def payment_fee_total
        total = 0
        @customers.each do |data|
          total += data.payment_fee.to_f
        end
        total
      end

      def eventualities_total
        @eventualities_total ||= Eventuality.where(date: set_interval(params[:event_total_interval]))
                                            .where(aasm_state: 'closed')
                                            .sum(:amount)
      end

      def new_customers_total
        @new_customers_total ||= Customer.where(created_at: set_interval(params[:new_custtomer_interval])).count
      end

      def emergency_eventualities
        @emergency_eventualities ||= Eventuality.joins(:customer).where(customer: { deleted_at: nil })
                                                .where(event_type: 'emergency')
                                                .where(created_at: (Time.now - 1.day).all_day)
                                                .order(id: :DESC).limit(10).map do |event|
          {
            agreement_id: event.customer&.act_agreement&.id,
            customer: event.customer.full_name,
            total: event.amount&.round(2),
            remaining_coverage: event.customer.remaining_coverage,
            coverage_referencen: event.customer.coverage_reference || event.customer.plan.coverage,
            id: event.id,
            date: event.date,
            status: I18n.t("eventuality.status.#{event.aasm_state}"),
            agent: event.customer.act_agreement.user.to_s,
            agreement_number: event.customer.act_agreement.agreement_number
          }
        end
      end

      def eventuality_types_graph
        @eventuality_types_graph ||= Eventuality.select("event_type, count(event_type)")
                                                .where(date: set_interval(params[:event_type_graph_interval]))
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
        events = Eventuality.where(date: set_interval(params[:scale_consumption_interval])).ids
        @scale_consumption_graph ||= EventualityExpense.select('scale_id, count(scale_id) as scale_count, (select title from '\
                                                               'scales where id = eventuality_expenses.scale_id) as title, '\
                                                               'sum(amount) as total')
                                                       .where(eventuality_id: events)
                                                       .order(:scale_count)
                                                       .group(:scale_id)
                                                       .limit(10)
      end

      private

      def set_interval(param)
        interval = param.nil? ? 'week' : param
        date = Time.now
        case interval
        when 'day'
          return [date.beginning_of_day..date.end_of_day]
        when 'week'
          [date.beginning_of_week..date.end_of_week]
        when 'month'
          [date.beginning_of_month..date.end_of_month]
        when 'year'
          [date.beginning_of_year..date.end_of_year]
        end
      end

      def customers_count
        @customers = []
        count = 0
        Customer.all.each do |customer|
          if customer.active_agreement? && customer.is_insured
            count += 1
            @customers << customer
          end
        end
        count
      end
    end
  end
end
