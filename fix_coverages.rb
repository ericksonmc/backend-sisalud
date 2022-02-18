require_relative 'config/environment'

class FixCoverages
  def initialize
    fix_coverages
  end

  def fix_coverages
    puts "ID,CI,Cliente,Cobertura,Total Eventualidades,Total de gastos en eventualidades"
    customers.each do |customer|
      consumed = eventualities(customer.id).sum(:amount)
      consumed_detail = calculate_total_details(customer.id)
      unless customer.coverage.to_f.round(2) == consumed.to_f.round(2) and consumed.to_f.round(2) == consumed_detail.to_f.round(2)
        puts "#{customer.id},#{customer.dni},#{customer.full_name},#{customer.coverage.round(2)},#{consumed.round(2)},#{consumed_detail.round(2)}"
      end
    end
  end

  private

  def customers
    @customers ||= Customer.all.order(:id)
  end

  def eventualities(customer_id)
    Eventuality.where(customer_id: customer_id)
  end

  def calculate_total_details(customer_id)
    EventualityExpense.where(eventuality_id: eventualities(customer_id).pluck(:id)).sum(:amount).to_f + EventualityExpenseManual.where(eventuality_id: eventualities(customer_id).pluck(:id)).sum(:amount).to_f
  end
end

FixCoverages.new