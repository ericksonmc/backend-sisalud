# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create user for tests
if User.find_by_email('admin@sipca.com').nil?
  User.create(email: 'admin@sipca.com', password: '12345678')
end

coverage_items = [
  {title: 'Hospitaliacion', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Uic', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugia Electiva', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugia Emergencia', value: 100, pe: nil },
  {title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Servicios de Emergencias', value: 100, pe: nil },
  {title: 'Consultas Basicas', value: 100, pe: nil },
  {title: 'Consultas Especializadas', value: 100, pe: nil },
  {title: 'Servicios de Odontologia Basica', value: 100, pe: nil },
  {title: 'Rayos x', value: 100, pe: nil },
  {title: 'Mamografia', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Tomografia', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Examenes Basicos', value: 100, pe: nil },
  {title: 'Examenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Ecogramas Basicos', value: 100, pe: nil },
  {title: 'Examenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Electrocardiograma', value: 100, pe: nil },
  {title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Gastrocopia', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Colonoscopia', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Mastologia', value: 0, pe: '(1 Ano P/E)' }
]
coverage_items_oro = [
  {title: 'Hospitaliacion', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Uic', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Cirugia Electiva', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Cirugia Emergencia', value: 100, pe: nil },
  {title: 'Maternidad', value: 100, pe: '(1 Ano P/E)' },
  {title: 'Servicios de Emergencias', value: 100, pe: nil },
  {title: 'Consultas Basicas', value: 100, pe: nil },
  {title: 'Consultas Especializadas', value: 100, pe: nil },
  {title: 'Servicios de Odontologia Basica', value: 100, pe: nil },
  {title: 'Rayos x', value: 100, pe: nil },
  {title: 'Mamografia', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Tomografia', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Examenes Basicos', value: 100, pe: nil },
  {title: 'Examenes Lab. Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Ecogramas Basicos', value: 100, pe: nil },
  {title: 'Examenes Especiales', value: 100, pe: '(3 Meses P/E)' },
  {title: 'Electrocardiograma', value: 100, pe: nil },
  {title: 'Ecocardiograma, Mapa, Holter', value: 100, pe: nil },
  {title: 'Gastrocopia', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Colonoscopia', value: 100, pe: '(6 Meses P/E)' },
  {title: 'Mastologia', value: 0, pe: '(1 Ano P/E)' }
]

unless Company.all.present?
  company = Company.create({ name: 'SIPCA ', rif: 'J-00000000-0' })
  producs = company.products.create({ description: 'Medicina Prepagada', title: 'SIPCA' })
  bronce = producs.plans.create({ coverage: 12000, coverage_items: coverage_items, payment_fee: 18, title: 'Bronce' })
  plata = producs.plans.create({ coverage: 20000, coverage_items: coverage_items, payment_fee: 25, title: 'Plata' })
  oro = producs.plans.create({ coverage: 50000, coverage_items: coverage_items_oro, payment_fee: 45, title: 'Oro' })
end
